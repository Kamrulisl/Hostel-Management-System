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
        if (!CanChangeMeal(date)) return ErrorResponse(400, "Meal change must be submitted before midnight (11:59 PM) of the previous day");

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
        if (!CanChangeMeal(start)) return ErrorResponse(400, "Meal change must be submitted before midnight (11:59 PM) of the previous day");

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
        var mealSelections = await BuildDisplaySelections(User.Id()!, from, to);
        return OkResponse(new { mealSelections }, "Meal calendar retrieved successfully");
    }

    [Authorize(Roles = "student")]
    [HttpGet("my-menu")]
    public async Task<IActionResult> MyMenu(DateTime? date)
    {
        var day = (date ?? DateTime.UtcNow).Date;
        var mealSelections = await BuildDisplaySelections(User.Id()!, day, day);
        return OkResponse(new { menu = mealSelections.First() }, "Your menu retrieved successfully");
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
        var today = DateTime.Now.Date;
        var holidays = await db.StudentHolidayModes
            .Where(h => h.StudentId == User.Id())
            .OrderBy(h => h.StartDate)
            .ThenBy(h => h.EndDate)
            .ToListAsync();
        var active = holidays.FirstOrDefault(h => h.IsEnabled && HolidayContains(h, today))
            ?? holidays.FirstOrDefault(h => h.IsEnabled && (h.EndDate is null || h.EndDate.Value.Date >= today));
        return OkResponse(new
        {
            holidayMode = active?.Dto() ?? new { isEnabled = false },
            holidays = holidays.Select(h => h.Dto())
        }, "Holiday mode retrieved successfully");
    }

    [Authorize(Roles = "student")]
    [HttpPost("holiday-mode")]
    public async Task<IActionResult> SaveHolidayMode(JsonElement body)
    {
        var id = body.String("id") ?? body.String("_id");
        var studentId = User.Id()!;
        var holiday = string.IsNullOrWhiteSpace(id)
            ? null
            : await db.StudentHolidayModes.FirstOrDefaultAsync(h => h.Id == id && h.StudentId == studentId);
        if (holiday is null)
        {
            holiday = new StudentHolidayMode { Id = Ids.New(), StudentId = studentId };
            db.StudentHolidayModes.Add(holiday);
        }

        holiday.IsEnabled = body.Bool("isEnabled") ?? body.Bool("enabled") ?? holiday.IsEnabled;
        holiday.StartDate = body.Date("startDate")?.Date ?? holiday.StartDate;
        holiday.EndDate = body.Date("endDate")?.Date ?? holiday.EndDate;
        holiday.Reason = body.String("reason") ?? holiday.Reason;
        if (holiday.IsEnabled)
        {
            var tomorrow = DateTime.Now.Date.AddDays(1);
            if (holiday.StartDate is null) holiday.StartDate = tomorrow;
            if (holiday.StartDate.Value.Date < tomorrow)
                return ErrorResponse(400, "Holiday mode must start from a future date");
            if (holiday.EndDate is not null && holiday.EndDate.Value.Date < tomorrow)
                return ErrorResponse(400, "Holiday end date must be a future date");
            if (holiday.EndDate is not null && holiday.EndDate.Value.Date < holiday.StartDate.Value.Date)
                return ErrorResponse(400, "Holiday end date cannot be before start date");

            var start = holiday.StartDate.Value.Date;
            var end = holiday.EndDate?.Date ?? DateTime.MaxValue.Date;
            var overlaps = await db.StudentHolidayModes.AnyAsync(h =>
                h.Id != holiday.Id &&
                h.StudentId == studentId &&
                h.IsEnabled &&
                h.StartDate != null &&
                h.StartDate.Value.Date <= end &&
                (h.EndDate == null || h.EndDate.Value.Date >= start));
            if (overlaps)
                return ErrorResponse(400, "Holiday date range overlaps with another active holiday");
        }
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

    private async Task<List<EffectiveMealSelection>> BuildDisplaySelections(string studentId, DateTime from, DateTime to)
    {
        await EnsureWeeklySchedule();
        var result = new List<EffectiveMealSelection>();
        for (var day = from.Date; day <= to.Date; day = day.AddDays(1))
        {
            var breakfast = await DisplayChoice(studentId, day, "breakfast");
            var lunch = await DisplayChoice(studentId, day, "lunch");
            var dinner = await DisplayChoice(studentId, day, "dinner");
            result.Add(new EffectiveMealSelection(day, breakfast, lunch, dinner));
        }
        return result;
    }

    private async Task<EffectiveMealChoice> DisplayChoice(string studentId, DateTime date, string mealType)
    {
        var isHoliday = await db.StudentHolidayModes.AnyAsync(h =>
            h.StudentId == studentId && h.IsEnabled &&
            (h.StartDate == null || date >= h.StartDate.Value.Date) &&
            (h.EndDate == null || date <= h.EndDate.Value.Date));
        if (isHoliday)
            return new EffectiveMealChoice("cancel", "approved", Array.Empty<object>());

        var selection = await db.MealSelections.FirstOrDefaultAsync(m => m.StudentId == studentId && m.Date == date);
        if (selection is not null)
        {
            var choice = GetChoice(selection, mealType);
            return new EffectiveMealChoice(choice, GetStatus(selection, mealType), ParseItems(await ItemsJsonOrSchedule(selection, date, mealType, choice)));
        }

        return new EffectiveMealChoice("default", "approved", ParseItems(await ItemsFor(date, mealType, "default")));
    }

    private async Task<EffectiveMealChoice> EffectiveChoice(string studentId, DateTime date, string mealType)
    {
        var isHoliday = await db.StudentHolidayModes.AnyAsync(h =>
            h.StudentId == studentId && h.IsEnabled &&
            (h.StartDate == null || date >= h.StartDate.Value.Date) &&
            (h.EndDate == null || date <= h.EndDate.Value.Date));
        if (isHoliday)
            return new EffectiveMealChoice("cancel", "approved", Array.Empty<object>());

        var selection = await db.MealSelections.FirstOrDefaultAsync(m => m.StudentId == studentId && m.Date == date);
        if (selection is not null)
        {
            var choice = GetChoice(selection, mealType);
            var status = GetStatus(selection, mealType);
            if (choice == "default" || status == "approved")
                return new EffectiveMealChoice(choice, status, ParseItems(await ItemsJsonOrSchedule(selection, date, mealType, choice)));
        }

        return new EffectiveMealChoice("default", "approved", ParseItems(await ItemsFor(date, mealType, "default")));
    }

    private async Task<string> ItemsJsonOrSchedule(MealSelection selection, DateTime date, string mealType, string choice)
    {
        var stored = GetItemsJson(selection, mealType);
        if (!string.IsNullOrWhiteSpace(stored) && stored != "[]") return stored;
        return await ItemsFor(date, mealType, choice);
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

        for (var day = 0; day < 7; day++)
        {
            foreach (var mealType in MealTypes)
            {
                var items = WeeklyDefaults[day][mealType];
                db.WeeklyMealSchedules.Add(new WeeklyMealSchedule
                {
                    Id = Ids.New(),
                    DayOfWeek = day,
                    MealType = mealType,
                    DefaultItemsJson = JsonSerializer.Serialize(ToItems(items.Default)),
                    AlternativeItemsJson = JsonSerializer.Serialize(ToItems(items.Alternative))
                });
            }
        }

        await db.SaveChangesAsync();
    }

    private static readonly Dictionary<int, Dictionary<string, (string Default, string Alternative)>> WeeklyDefaults = new()
    {
        [0] = new()
        {
            ["breakfast"] = ("Paratha, Egg Curry, Tea", "Bread, Omelette, Banana"),
            ["lunch"] = ("Rice, Chicken Curry, Dal", "Rice, Mixed Vegetable, Egg Curry"),
            ["dinner"] = ("Khichuri, Beef Curry, Salad", "Rice, Fish Fry, Vegetable")
        },
        [1] = new()
        {
            ["breakfast"] = ("Khichuri, Boiled Egg, Tea", "Noodles, Egg, Tea"),
            ["lunch"] = ("Rice, Fish Curry, Dal", "Rice, Chicken Roast, Salad"),
            ["dinner"] = ("Rice, Lentil Soup, Vegetable", "Fried Rice, Chicken Chili")
        },
        [2] = new()
        {
            ["breakfast"] = ("Ruti, Vegetable, Tea", "Semai, Egg, Milk"),
            ["lunch"] = ("Rice, Beef Curry, Dal", "Rice, Fish Curry, Mashed Potato"),
            ["dinner"] = ("Polao, Chicken Curry, Salad", "Rice, Dal, Egg Bhuna")
        },
        [3] = new()
        {
            ["breakfast"] = ("Bread, Jam, Banana, Tea", "Paratha, Dal, Egg"),
            ["lunch"] = ("Rice, Egg Curry, Vegetable", "Rice, Chicken Curry, Dal"),
            ["dinner"] = ("Rice, Fish Curry, Dal", "Khichuri, Chicken Fry")
        },
        [4] = new()
        {
            ["breakfast"] = ("Noodles, Egg, Tea", "Ruti, Vegetable, Tea"),
            ["lunch"] = ("Rice, Chicken Roast, Dal", "Rice, Fish Curry, Salad"),
            ["dinner"] = ("Rice, Beef Bhuna, Vegetable", "Fried Rice, Egg Curry")
        },
        [5] = new()
        {
            ["breakfast"] = ("Paratha, Halwa, Tea", "Bread, Egg, Milk"),
            ["lunch"] = ("Biriyani, Salad, Borhani", "Rice, Chicken Curry, Dal"),
            ["dinner"] = ("Rice, Fish Fry, Dal", "Khichuri, Egg Curry")
        },
        [6] = new()
        {
            ["breakfast"] = ("Khichuri, Egg Fry, Tea", "Pancake, Banana, Milk"),
            ["lunch"] = ("Rice, Mutton Curry, Dal", "Rice, Fish Curry, Vegetable"),
            ["dinner"] = ("Polao, Roast Chicken, Salad", "Rice, Dal, Mixed Vegetable")
        }
    };

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

    private static bool CanChangeMeal(DateTime mealDate) => DateTime.Now < mealDate.Date;
    private static bool HolidayContains(StudentHolidayMode holiday, DateTime date) =>
        holiday.IsEnabled &&
        (holiday.StartDate is null || date >= holiday.StartDate.Value.Date) &&
        (holiday.EndDate is null || date <= holiday.EndDate.Value.Date);

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
        public bool canEdit => CanChangeMeal(Date);
        public object Meals => new { breakfast = Breakfast.Choice != "cancel", lunch = Lunch.Choice != "cancel", dinner = Dinner.Choice != "cancel" };
        public object Choices => new { breakfast = Breakfast, lunch = Lunch, dinner = Dinner };
    }
}
