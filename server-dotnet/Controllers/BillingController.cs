using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
[Route("api/v1/billing")]
public class BillingController(AppDbContext db, AuditService audit) : ApiControllerBase
{
    [Authorize(Roles = "admin")]
    [HttpGet]
    public async Task<IActionResult> All(string? status, int? year, int? month)
    {
        var query = Query(status, year, month);
        var bills = await query.ToListAsync();
        return OkResponse(new { bills = bills.Select(b => b.Dto()), count = bills.Count }, "All bills retrieved successfully");
    }

    [HttpGet("me")]
    public async Task<IActionResult> Mine()
    {
        var bills = await db.Bills.Include(b => b.Student).Where(b => b.StudentId == User.Id()).OrderByDescending(b => b.Year).ThenByDescending(b => b.Month).ToListAsync();
        return OkResponse(new { bills = bills.Select(b => b.Dto()), count = bills.Count }, "Your bills retrieved successfully");
    }

    [Authorize(Roles = "student")]
    [HttpGet("advances/me")]
    public async Task<IActionResult> MyAdvances(int? month, int? year)
    {
        var query = db.AdvancePayments.Where(p => p.StudentId == User.Id());
        if (month is not null) query = query.Where(p => p.Date.Month == month);
        if (year is not null) query = query.Where(p => p.Date.Year == year);
        var advances = await query.OrderByDescending(p => p.Date).ThenByDescending(p => p.CreatedAt).ToListAsync();
        return OkResponse(new { advances = advances.Select(a => a.Dto()), total = advances.Sum(a => a.Amount) }, "Advance payments retrieved successfully");
    }

    [HttpGet("student/{studentId}")]
    public async Task<IActionResult> StudentBills(string studentId)
    {
        var bills = await db.Bills.Include(b => b.Student).Where(b => b.StudentId == studentId).OrderByDescending(b => b.Year).ThenByDescending(b => b.Month).ToListAsync();
        return OkResponse(new { bills = bills.Select(b => b.Dto()), count = bills.Count }, "Student bills retrieved successfully");
    }

    [HttpGet("summary/{studentId}")]
    public async Task<IActionResult> Summary(string studentId, int year, int month)
    {
        var bill = await db.Bills.FirstOrDefaultAsync(b => b.StudentId == studentId && b.Year == year && b.Month == month);
        return OkResponse(new { summary = bill?.Dto() }, "Bill summary retrieved successfully");
    }

    [Authorize(Roles = "admin")]
    [HttpPost("generate")]
    [HttpPost("seed")]
    [HttpPost("regenerate")]
    public async Task<IActionResult> Generate(JsonElement body) => await GenerateBills(body);

    [Authorize(Roles = "admin")]
    [HttpPost("reset-and-generate")]
    public async Task<IActionResult> ResetAndGenerate(JsonElement body)
    {
        db.Bills.RemoveRange(db.Bills.Where(b => b.Year == body.Int("year") && b.Month == body.Int("month")));
        await db.SaveChangesAsync();
        return await GenerateBills(body);
    }

    [Authorize(Roles = "admin")]
    [HttpPost("delete-all-and-generate")]
    public async Task<IActionResult> DeleteAllAndGenerate(JsonElement body)
    {
        db.Bills.RemoveRange(db.Bills);
        await db.SaveChangesAsync();
        return await GenerateBills(body);
    }

    [Authorize(Roles = "admin")]
    [HttpPost("fix-all")]
    public async Task<IActionResult> FixAll()
    {
        var bills = await db.Bills.ToListAsync();
        var fixedCount = 0;

        foreach (var bill in bills)
        {
            var totalMeals = bill.BreakfastCount + bill.LunchCount + bill.DinnerCount;
            var mealCost = totalMeals * bill.MealRate;
            var totalAmount = bill.PreviousDue + bill.FixedCost + bill.UtilityCost + mealCost - bill.AdvancePaid;
            if (totalAmount < 0) totalAmount = 0;

            if (bill.TotalMeals != totalMeals || bill.MealCost != mealCost || bill.TotalAmount != totalAmount)
            {
                bill.TotalMeals = totalMeals;
                bill.MealCost = mealCost;
                bill.TotalAmount = totalAmount;
                bill.BreakfastRate = bill.MealRate;
                bill.LunchRate = bill.MealRate;
                bill.DinnerRate = bill.MealRate;
                bill.UpdatedAt = DateTime.UtcNow;
                fixedCount++;
            }
        }

        await db.SaveChangesAsync();
        return OkResponse(new { fixedCount, message = $"Fixed {fixedCount} bills" }, $"Fixed {fixedCount} bills successfully");
    }

    [Authorize(Roles = "admin")]
    [HttpPost("generate-single")]
    public async Task<IActionResult> GenerateSingle(JsonElement body)
    {
        var bill = await BuildBill(body.String("studentId")!, body.Int("year") ?? DateTime.UtcNow.Year, body.Int("month") ?? DateTime.UtcNow.Month);
        await db.SaveChangesAsync();
        return OkResponse(new { bill = bill.Dto() }, "Bill generated successfully");
    }

    [Authorize(Roles = "admin")]
    [HttpGet("check/missing-data")]
    public async Task<IActionResult> MissingData()
    {
        var bills = await db.Bills
            .Include(b => b.Student)
            .Where(b => b.TotalAmount <= 0 || b.TotalMeals != b.BreakfastCount + b.LunchCount + b.DinnerCount || b.Student == null)
            .ToListAsync();

        return OkResponse(new { bills = bills.Select(b => b.Dto()), count = bills.Count }, $"Found {bills.Count} bills with missing data");
    }

    [Authorize(Roles = "admin")]
    [HttpGet("stats/{year:int}/{month:int}")]
    public async Task<IActionResult> Stats(int year, int month)
    {
        var bills = await db.Bills.Where(b => b.Year == year && b.Month == month).ToListAsync();
        return OkResponse(new { stats = new { totalBills = bills.Count, paidBills = bills.Count(b => b.Status == "PAID"), dueBills = bills.Count(b => b.Status == "DUE"), totalRevenue = bills.Where(b => b.Status == "PAID").Sum(b => b.TotalAmount), totalDue = bills.Where(b => b.Status == "DUE").Sum(b => b.TotalAmount) } }, "Billing statistics retrieved successfully");
    }

    [Authorize(Roles = "admin")]
    [HttpPut("{billId}")]
    public async Task<IActionResult> Update(string billId, JsonElement body)
    {
        var bill = await db.Bills.Include(b => b.Student).FirstOrDefaultAsync(b => b.Id == billId);
        if (bill is null) return ErrorResponse(404, "Bill not found");
        bill.Status = body.String("status") ?? bill.Status;
        bill.PaymentMethod = body.String("paymentMethod");
        bill.TransactionId = body.String("transactionId");
        if (bill.Status == "PAID") bill.PaidAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return OkResponse(new { bill = bill.Dto() }, "Bill status updated successfully");
    }

    [HttpGet("{billId}")]
    public async Task<IActionResult> Details(string billId)
    {
        var bill = await db.Bills.Include(b => b.Student).FirstOrDefaultAsync(b => b.Id == billId);
        return bill is null ? ErrorResponse(404, "Bill not found") : OkResponse(new { bill = bill.Dto() }, "Bill details retrieved successfully");
    }

    private IQueryable<Bill> Query(string? status, int? year, int? month)
    {
        var query = db.Bills.Include(b => b.Student).AsQueryable();
        if (!string.IsNullOrEmpty(status)) query = query.Where(b => b.Status == status);
        if (year is not null) query = query.Where(b => b.Year == year);
        if (month is not null) query = query.Where(b => b.Month == month);
        return query.OrderByDescending(b => b.Year).ThenByDescending(b => b.Month);
    }

    private async Task<IActionResult> GenerateBills(JsonElement body)
    {
        var year = body.Int("year") ?? DateTime.UtcNow.Year;
        var month = body.Int("month") ?? DateTime.UtcNow.Month;
        var students = await db.Users.Where(u => u.Role == "student" && u.IsActive).ToListAsync();
        var bills = new List<object>();
        foreach (var student in students) bills.Add((await BuildBill(student.Id, year, month)).Dto());
        await db.SaveChangesAsync();
        await audit.LogAsync(User.Id(), User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value, "BILL_GENERATE", "Bill", null, $"Generated bills for {month}/{year}", $$"""{"count":{{bills.Count}}}""");
        return OkResponse(new { count = bills.Count, bills }, $"Bills generated successfully for {bills.Count} students");
    }

    private async Task<Bill> BuildBill(string studentId, int year, int month)
    {
        var settings = await db.Settings.FirstOrDefaultAsync();
        if (settings is null)
        {
            settings = new Settings { Id = Ids.New() };
            db.Settings.Add(settings);
        }
        var selections = await db.MealSelections.Where(m => m.StudentId == studentId && m.Date.Year == year && m.Date.Month == month).ToListAsync();
        var holiday = await db.StudentHolidayModes.FirstOrDefaultAsync(h => h.StudentId == studentId);
        var daysInMonth = DateTime.DaysInMonth(year, month);
        var today = DateTime.Now.Date;
        var monthEndForBilling = new DateTime(year, month, daysInMonth);
        if (monthEndForBilling > today) monthEndForBilling = today;
        var billableDays = monthEndForBilling.Year == year && monthEndForBilling.Month == month ? monthEndForBilling.Day : 0;
        var breakfast = CountBillableMeals(selections, holiday, year, month, billableDays, "breakfast");
        var lunch = CountBillableMeals(selections, holiday, year, month, billableDays, "lunch");
        var dinner = CountBillableMeals(selections, holiday, year, month, billableDays, "dinner");
        var totalMeals = breakfast + lunch + dinner;
        var monthStart = new DateTime(year, month, 1);
        var monthEnd = monthStart.AddMonths(1).AddDays(-1);
        var bazarTotal = await db.DailyBazars.Where(b => b.Date >= monthStart && b.Date <= monthEnd).SumAsync(b => b.TotalAmount);
        var allStudents = await db.Users.Where(u => u.Role == "student" && u.IsActive).Select(u => u.Id).ToListAsync();
        var allMeals = 0;
        foreach (var id in allStudents)
        {
            var rows = await db.MealSelections.Where(m => m.StudentId == id && m.Date.Year == year && m.Date.Month == month).ToListAsync();
            var h = await db.StudentHolidayModes.FirstOrDefaultAsync(x => x.StudentId == id);
            allMeals += CountBillableMeals(rows, h, year, month, billableDays, "breakfast");
            allMeals += CountBillableMeals(rows, h, year, month, billableDays, "lunch");
            allMeals += CountBillableMeals(rows, h, year, month, billableDays, "dinner");
        }
        var mealRate = allMeals > 0 ? Math.Round(bazarTotal / allMeals, 2) : 0;
        var mealCost = totalMeals * mealRate;
        var utilityTotal = await db.UtilityExpenses.Where(e => e.Month == month && e.Year == year).SumAsync(e => e.Amount);
        var utilityCost = allStudents.Count > 0 ? Math.Round(utilityTotal / allStudents.Count, 2) : 0;
        var advancePaid = await db.AdvancePayments.Where(p => p.StudentId == studentId && p.Date.Year == year && p.Date.Month == month).SumAsync(p => p.Amount);
        var prev = monthStart.AddMonths(-1);
        var previousBill = await db.Bills.FirstOrDefaultAsync(b => b.StudentId == studentId && b.Year == prev.Year && b.Month == prev.Month && b.Status == "DUE");
        var previousDue = previousBill?.TotalAmount ?? 0;
        var fixedCost = 0m;
        var total = previousDue + utilityCost + mealCost - advancePaid;
        if (total < 0) total = 0;
        total -= total * settings.DiscountPercentage / 100;
        total += total * settings.TaxPercentage / 100;

        var bill = await db.Bills.FirstOrDefaultAsync(b => b.StudentId == studentId && b.Year == year && b.Month == month);
        if (bill is null)
        {
            bill = new Bill { Id = Ids.New(), StudentId = studentId, Year = year, Month = month, GeneratedById = User.Id() };
            db.Bills.Add(bill);
        }

        bill.BreakfastCount = breakfast;
        bill.BreakfastRate = mealRate;
        bill.LunchCount = lunch;
        bill.LunchRate = mealRate;
        bill.DinnerCount = dinner;
        bill.DinnerRate = mealRate;
        bill.TotalMeals = totalMeals;
        bill.MealCost = mealCost;
        bill.FixedCost = fixedCost;
        bill.UtilityCost = utilityCost;
        bill.AdvancePaid = advancePaid;
        bill.PreviousDue = previousDue;
        bill.MealRate = mealRate;
        bill.TotalAmount = total;
        bill.UpdatedAt = DateTime.UtcNow;
        return bill;
    }

    private static int CountBillableMeals(List<MealSelection> selections, StudentHolidayMode? holiday, int year, int month, int daysInMonth, string mealType)
    {
        var count = 0;
        for (var day = 1; day <= daysInMonth; day++)
        {
            var date = new DateTime(year, month, day);
            if (holiday?.IsEnabled == true && (holiday.StartDate is null || date >= holiday.StartDate.Value.Date) && (holiday.EndDate is null || date <= holiday.EndDate.Value.Date))
                continue;

            var selection = selections.FirstOrDefault(m => m.Date.Date == date);
            if (selection is null)
            {
                count++;
                continue;
            }

            var choice = mealType switch
            {
                "breakfast" => selection.BreakfastChoice,
                "lunch" => selection.LunchChoice,
                _ => selection.DinnerChoice
            };
            var status = mealType switch
            {
                "breakfast" => selection.BreakfastStatus,
                "lunch" => selection.LunchStatus,
                _ => selection.DinnerStatus
            };

            if (choice != "cancel" || status != "approved") count++;
        }
        return count;
    }
}
