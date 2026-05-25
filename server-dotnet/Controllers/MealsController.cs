using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
[Route("api/v1/meals")]
public class MealsController(AppDbContext db, AuditService audit) : ApiControllerBase
{
    private static readonly string[] MealTypes = ["breakfast", "lunch", "dinner"];

    [Authorize(Roles = "student")]
    [HttpPost("select")]
    public async Task<IActionResult> Select(JsonElement body)
    {
        var date = body.Date("date")?.Date ?? DateTime.UtcNow.Date;
        if (date <= DateTime.Now.Date) return ErrorResponse(400, "Meal change must be submitted before the meal day starts");

        var mealType = body.String("mealType");
        if (string.IsNullOrWhiteSpace(mealType) && body.TryGetProperty("meals", out var meals))
        {
            var selection = await UpsertLegacy(User.Id()!, date, meals);
            return OkResponse(new { mealSelection = selection.Dto() }, "Meals selected successfully");
        }

        mealType = NormalizeMealType(mealType);
        if (mealType is null) return ErrorResponse(400, "Valid mealType is required");

        var choice = NormalizeChoice(body.String("choice") ?? body.String("action") ?? "default");
        if (choice is null) return ErrorResponse(400, "choice must be default, alternative, or cancel");

        var selectionForChoice = await UpsertChoice(User.Id()!, date, mealType, choice, body.String("note"));
        return OkResponse(new { mealSelection = selectionForChoice.Dto() }, "Meal request submitted successfully");
    }

    [Authorize(Roles = "student")]
    [HttpPost("bulk")]
    public async Task<IActionResult> Bulk(JsonElement body)
    {
        var start = body.Date("startDate")?.Date ?? DateTime.UtcNow.Date.AddDays(1);
        var end = body.Date("endDate")?.Date ?? start;
        if (start <= DateTime.Now.Date) return ErrorResponse(400, "Meal change must be submitted before the meal day starts");

        var updated = new List<object>();
        for (var day = start; day <= end; day = day.AddDays(1))
        {
            if (body.TryGetProperty("meals", out var meals))
                updated.Add((await UpsertLegacy(User.Id()!, day, meals)).Dto());
        }

        return OkResponse(new { result = new { count = updated.Count, mealSelections = updated } }, "Meals selected for date range successfully");
    }

    [Authorize(Roles = "student")]
    [HttpGet("my-calendar")]
    public async Task<IActionResult> Calendar(int year, int month)
    {
        var from = new DateTime(year, month, 1);
        var to = from.AddMonths(1).AddDays(-1);
        var mealSelections = await BuildEffectiveSelections(User.Id()!, from, to);
        return OkResponse(new { mealSelections }, "Meal calendar retrieved successfully");
    }

    [Authorize(Roles = "student")]
    [HttpGet("summary")]
    public async Task<IActionResult> Summary(int year, int month)
    {
        var from = new DateTime(year, month, 1);
        var to = from.AddMonths(1).AddDays(-1);
        var list = await BuildEffectiveSelections(User.Id()!, from, to);
        var summary = new
        {
            breakfast = list.Count(x => x.Breakfast.Choice != "cancel"),
            lunch = list.Count(x => x.Lunch.Choice != "cancel"),
            dinner = list.Count(x => x.Dinner.Choice != "cancel"),
            total = list.Sum(x => (x.Breakfast.Choice != "cancel" ? 1 : 0) + (x.Lunch.Choice != "cancel" ? 1 : 0) + (x.Dinner.Choice != "cancel" ? 1 : 0)),
            totalBreakfast = list.Count(x => x.Breakfast.Choice != "cancel"),
            totalLunch = list.Count(x => x.Lunch.Choice != "cancel"),
            totalDinner = list.Count(x => x.Dinner.Choice != "cancel"),
            totalMeals = list.Sum(x => (x.Breakfast.Choice != "cancel" ? 1 : 0) + (x.Lunch.Choice != "cancel" ? 1 : 0) + (x.Dinner.Choice != "cancel" ? 1 : 0))
        };
        return OkResponse(new { summary }, "Meal summary retrieved successfully");
    }

    [Authorize(Roles = "student")]
    [HttpGet("holiday-mode")]
    public async Task<IActionResult> MyHolidayMode()
    {
        var holiday = await db.StudentHolidayModes.FirstOrDefaultAsync(h => h.StudentId == User.Id());
        return OkResponse(new { holidayMode = holiday?.Dto() ?? new { isEnabled = false } }, "Holiday mode retrieved successfully");
    }

    [Authorize(Roles = "student")]
    [HttpPost("holiday-mode")]
    public async Task<IActionResult> SaveHolidayMode(JsonElement body)
    {
        var holiday = await db.StudentHolidayModes.FirstOrDefaultAsync(h => h.StudentId == User.Id());
        if (holiday is null)
        {
            holiday = new StudentHolidayMode { Id = Ids.New(), StudentId = User.Id()! };
            db.StudentHolidayModes.Add(holiday);
        }

        holiday.IsEnabled = body.Bool("isEnabled") ?? body.Bool("enabled") ?? holiday.IsEnabled;
        holiday.StartDate = body.Date("startDate")?.Date ?? holiday.StartDate;
        holiday.EndDate = body.Date("endDate")?.Date ?? holiday.EndDate;
        holiday.Reason = body.String("reason") ?? holiday.Reason;
        holiday.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return OkResponse(new { holidayMode = holiday.Dto() }, "Holiday mode updated successfully");
    }

    [HttpGet("weekly-schedule")]
    public async Task<IActionResult> WeeklySchedule()
    {
        await EnsureWeeklySchedule();
        var schedule = await db.WeeklyMealSchedules.OrderBy(s => s.DayOfWeek).ThenBy(s => s.MealType).ToListAsync();
        return OkResponse(new { schedule = schedule.Select(s => s.Dto()) }, "Weekly meal schedule retrieved successfully");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpPut("weekly-schedule")]
    public async Task<IActionResult> SaveWeeklySchedule(JsonElement body)
    {
        if (!body.TryGetProperty("schedule", out var schedule) || schedule.ValueKind != JsonValueKind.Array)
            return ErrorResponse(400, "schedule array is required");

        foreach (var item in schedule.EnumerateArray())
        {
            var dayOfWeek = item.Int("dayOfWeek");
            var mealType = NormalizeMealType(item.String("mealType"));
            if (dayOfWeek is null || dayOfWeek < 0 || dayOfWeek > 6 || mealType is null) continue;

            var row = await db.WeeklyMealSchedules.FirstOrDefaultAsync(s => s.DayOfWeek == dayOfWeek && s.MealType == mealType);
            if (row is null)
            {
                row = new WeeklyMealSchedule { Id = Ids.New(), DayOfWeek = dayOfWeek.Value, MealType = mealType };
                db.WeeklyMealSchedules.Add(row);
            }

            row.DefaultItemsJson = item.Raw("defaultItems") ?? row.DefaultItemsJson;
            row.AlternativeItemsJson = item.Raw("alternativeItems") ?? row.AlternativeItemsJson;
            row.IsActive = item.Bool("isActive") ?? row.IsActive;
            row.UpdatedById = User.Id();
            row.UpdatedAt = DateTime.UtcNow;
        }

        await db.SaveChangesAsync();
        await audit.LogAsync(User.Id(), User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value, "UPDATE", "WeeklyMealSchedule", null, "Updated weekly meal schedule");
        return await WeeklySchedule();
    }

    [Authorize(Roles = "manager,admin")]
    [HttpGet("pending")]
    public async Task<IActionResult> Pending(DateTime? date)
    {
        var query = db.MealSelections.Include(m => m.Student).AsQueryable();
        if (date is not null) query = query.Where(m => m.Date == date.Value.Date);
        var rows = await query.OrderBy(m => m.Date).ToListAsync();
        var pending = rows.SelectMany(ToPendingDtos).ToList();
        return OkResponse(new { pending }, "Pending meal requests retrieved successfully");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpPatch("{id}/approve")]
    public async Task<IActionResult> Approve(string id, JsonElement body)
    {
        var mealType = NormalizeMealType(body.String("mealType"));
        if (mealType is null) return ErrorResponse(400, "Valid mealType is required");

        var selection = await db.MealSelections.FindAsync(id);
        if (selection is null) return ErrorResponse(404, "Meal request not found");
        ApproveMeal(selection, mealType);
        await db.SaveChangesAsync();
        await audit.LogAsync(User.Id(), User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value, "APPROVE", "MealSelection", id, $"Approved {mealType} request");
        return OkResponse(new { mealSelection = selection.Dto() }, "Meal request approved successfully");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpPatch("approve-pending")]
    public async Task<IActionResult> ApprovePending(JsonElement body)
    {
        var date = body.Date("date")?.Date;
        var query = db.MealSelections.AsQueryable();
        if (date is not null) query = query.Where(m => m.Date == date.Value);
        var rows = await query.ToListAsync();
        var count = 0;

        foreach (var row in rows)
        {
            foreach (var mealType in MealTypes)
            {
                if (GetStatus(row, mealType) == "pending")
                {
                    ApproveMeal(row, mealType);
                    count++;
                }
            }
        }

        await db.SaveChangesAsync();
        await audit.LogAsync(User.Id(), User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value, "APPROVE_ALL", "MealSelection", null, $"Approved {count} meal requests");
        return OkResponse(new { approved = count }, "Pending meal requests approved successfully");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpGet("cooking-counts")]
    public async Task<IActionResult> CookingCounts(DateTime? date)
    {
        var day = (date ?? DateTime.UtcNow).Date;
        var students = await db.Users.Where(u => u.Role == "student" && u.IsActive).Select(u => u.Id).ToListAsync();
        var result = new Dictionary<string, object>();
        foreach (var mealType in MealTypes)
        {
            var defaultCount = 0;
            var alternativeCount = 0;
            var cancelledCount = 0;
            foreach (var studentId in students)
            {
                var effective = await EffectiveChoice(studentId, day, mealType);
                if (effective.Choice == "cancel") cancelledCount++;
                else if (effective.Choice == "alternative") alternativeCount++;
                else defaultCount++;
            }

            result[mealType] = new { defaultCount, alternativeCount, cancelledCount, totalToCook = defaultCount + alternativeCount };
        }

        return OkResponse(new { date = day, counts = result }, "Cooking counts retrieved successfully");
    }

    [Authorize(Roles = "admin")]
    [HttpGet("daily-counts")]
    public async Task<IActionResult> DailyCounts(DateTime date) => await CookingCounts(date);

    [Authorize(Roles = "admin")]
    [HttpGet("range")]
    public async Task<IActionResult> Range(DateTime startDate, DateTime endDate)
    {
        var selections = await db.MealSelections.Include(m => m.Student)
            .Where(m => m.Date >= startDate.Date && m.Date <= endDate.Date)
            .OrderBy(m => m.Date)
            .ToListAsync();
        return OkResponse(new { selections = selections.Select(m => m.Dto()) }, "Meal selections retrieved successfully");
    }

    private async Task<MealSelection> UpsertLegacy(string studentId, DateTime date, JsonElement meals)
    {
        var selection = await GetOrCreateSelection(studentId, date);
        await EnsureWeeklySchedule();

        foreach (var mealType in MealTypes)
        {
            var enabled = meals.Bool(mealType);
            if (enabled is null) continue;
            var choice = enabled.Value ? "default" : "cancel";
            SetMeal(selection, mealType, choice, choice == "default" ? "approved" : "pending", await ItemsFor(date, mealType, choice));
        }

        selection.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return selection;
    }

    private async Task<MealSelection> UpsertChoice(string studentId, DateTime date, string mealType, string choice, string? note)
    {
        var selection = await GetOrCreateSelection(studentId, date);
        var status = choice == "default" ? "approved" : "pending";
        SetMeal(selection, mealType, choice, status, await ItemsFor(date, mealType, choice));
        selection.Note = note ?? selection.Note;
        selection.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return selection;
    }

    private async Task<MealSelection> GetOrCreateSelection(string studentId, DateTime date)
    {
        var selection = await db.MealSelections.FirstOrDefaultAsync(m => m.StudentId == studentId && m.Date == date);
        if (selection is not null) return selection;

        selection = new MealSelection { Id = Ids.New(), StudentId = studentId, Date = date, Breakfast = true, Lunch = true, Dinner = true };
        db.MealSelections.Add(selection);
        return selection;
    }

    private async Task<List<EffectiveMealSelection>> BuildEffectiveSelections(string studentId, DateTime from, DateTime to)
    {
        await EnsureWeeklySchedule();
        var result = new List<EffectiveMealSelection>();
        for (var day = from.Date; day <= to.Date; day = day.AddDays(1))
        {
            var breakfast = await EffectiveChoice(studentId, day, "breakfast");
            var lunch = await EffectiveChoice(studentId, day, "lunch");
            var dinner = await EffectiveChoice(studentId, day, "dinner");
            result.Add(new EffectiveMealSelection(day, breakfast, lunch, dinner));
        }
        return result;
    }

    private async Task<EffectiveMealChoice> EffectiveChoice(string studentId, DateTime date, string mealType)
    {
        var holiday = await db.StudentHolidayModes.FirstOrDefaultAsync(h => h.StudentId == studentId);
        if (holiday?.IsEnabled == true && (holiday.StartDate is null || date >= holiday.StartDate.Value.Date) && (holiday.EndDate is null || date <= holiday.EndDate.Value.Date))
            return new EffectiveMealChoice("cancel", "approved", Array.Empty<object>());

        var selection = await db.MealSelections.FirstOrDefaultAsync(m => m.StudentId == studentId && m.Date == date);
        if (selection is not null)
        {
            var choice = GetChoice(selection, mealType);
            var status = GetStatus(selection, mealType);
            if (choice == "default" || status == "approved")
                return new EffectiveMealChoice(choice, status, ParseItems(GetItemsJson(selection, mealType)));
        }

        return new EffectiveMealChoice("default", "approved", ParseItems(await ItemsFor(date, mealType, "default")));
    }

    private async Task<string> ItemsFor(DateTime date, string mealType, string choice)
    {
        if (choice == "cancel") return "[]";
        await EnsureWeeklySchedule();
        var schedule = await db.WeeklyMealSchedules.FirstOrDefaultAsync(s => s.DayOfWeek == (int)date.DayOfWeek && s.MealType == mealType);
        return choice == "alternative" ? schedule?.AlternativeItemsJson ?? "[]" : schedule?.DefaultItemsJson ?? "[]";
    }

    private async Task EnsureWeeklySchedule()
    {
        if (await db.WeeklyMealSchedules.AnyAsync()) return;

        var defaults = new Dictionary<string, string[]>
        {
            ["breakfast"] = ["Rice, Dal, Egg", "Paratha, Vegetable, Tea"],
            ["lunch"] = ["Rice, Fish Curry, Dal", "Rice, Chicken Curry, Salad"],
            ["dinner"] = ["Rice, Chicken, Vegetable", "Khichuri, Egg Curry"]
        };

        for (var day = 0; day < 7; day++)
        {
            foreach (var mealType in MealTypes)
            {
                db.WeeklyMealSchedules.Add(new WeeklyMealSchedule
                {
                    Id = Ids.New(),
                    DayOfWeek = day,
                    MealType = mealType,
                    DefaultItemsJson = JsonSerializer.Serialize(ToItems(defaults[mealType][0])),
                    AlternativeItemsJson = JsonSerializer.Serialize(ToItems(defaults[mealType][1]))
                });
            }
        }

        await db.SaveChangesAsync();
    }

    private static List<object> ToItems(string text) => text.Split(", ").Select(name => new { name, description = "" }).Cast<object>().ToList();

    private void ApproveMeal(MealSelection selection, string mealType)
    {
        SetStatus(selection, mealType, "approved");
        selection.ApprovedById = User.Id();
        selection.ApprovedAt = DateTime.UtcNow;
        selection.UpdatedAt = DateTime.UtcNow;
    }

    private static IEnumerable<object> ToPendingDtos(MealSelection selection)
    {
        foreach (var mealType in MealTypes)
        {
            if (GetStatus(selection, mealType) == "pending")
            {
                yield return new
                {
                    _id = selection.Id,
                    id = selection.Id,
                    student = selection.Student?.Mini() ?? selection.StudentId,
                    date = selection.Date,
                    mealType,
                    choice = GetChoice(selection, mealType),
                    status = GetStatus(selection, mealType),
                    items = ParseItems(GetItemsJson(selection, mealType)),
                    note = selection.Note,
                    createdAt = selection.CreatedAt,
                    updatedAt = selection.UpdatedAt
                };
            }
        }
    }

    private static string? NormalizeMealType(string? mealType)
    {
        mealType = mealType?.Trim().ToLowerInvariant();
        return MealTypes.Contains(mealType) ? mealType : null;
    }

    private static string? NormalizeChoice(string? choice)
    {
        choice = choice?.Trim().ToLowerInvariant();
        return choice is "default" or "alternative" or "cancel" ? choice : null;
    }

    private static void SetMeal(MealSelection selection, string mealType, string choice, string status, string itemsJson)
    {
        switch (mealType)
        {
            case "breakfast":
                selection.Breakfast = choice != "cancel";
                selection.BreakfastChoice = choice;
                selection.BreakfastStatus = status;
                selection.BreakfastItemsJson = itemsJson;
                break;
            case "lunch":
                selection.Lunch = choice != "cancel";
                selection.LunchChoice = choice;
                selection.LunchStatus = status;
                selection.LunchItemsJson = itemsJson;
                break;
            case "dinner":
                selection.Dinner = choice != "cancel";
                selection.DinnerChoice = choice;
                selection.DinnerStatus = status;
                selection.DinnerItemsJson = itemsJson;
                break;
        }
    }

    private static string GetChoice(MealSelection selection, string mealType) => mealType switch
    {
        "breakfast" => selection.BreakfastChoice,
        "lunch" => selection.LunchChoice,
        _ => selection.DinnerChoice
    };

    private static string GetStatus(MealSelection selection, string mealType) => mealType switch
    {
        "breakfast" => selection.BreakfastStatus,
        "lunch" => selection.LunchStatus,
        _ => selection.DinnerStatus
    };

    private static void SetStatus(MealSelection selection, string mealType, string status)
    {
        if (mealType == "breakfast") selection.BreakfastStatus = status;
        else if (mealType == "lunch") selection.LunchStatus = status;
        else selection.DinnerStatus = status;
    }

    private static string GetItemsJson(MealSelection selection, string mealType) => mealType switch
    {
        "breakfast" => selection.BreakfastItemsJson,
        "lunch" => selection.LunchItemsJson,
        _ => selection.DinnerItemsJson
    };

    private static object? ParseItems(string json) => Json.Parse(string.IsNullOrWhiteSpace(json) ? "[]" : json);

    public record EffectiveMealChoice(string Choice, string Status, object? Items);

    public record EffectiveMealSelection(DateTime Date, EffectiveMealChoice Breakfast, EffectiveMealChoice Lunch, EffectiveMealChoice Dinner)
    {
        public string _id => Date.ToString("yyyyMMdd");
        public string id => _id;
        public object Meals => new { breakfast = Breakfast.Choice != "cancel", lunch = Lunch.Choice != "cancel", dinner = Dinner.Choice != "cancel" };
        public object Choices => new { breakfast = Breakfast, lunch = Lunch, dinner = Dinner };
    }
}
