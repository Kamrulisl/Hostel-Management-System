using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize(Roles = "admin,manager")]
[Route("api/v1/analytics")]
public class AnalyticsController(AppDbContext db) : ApiControllerBase
{
    [HttpGet("overview")]
    public async Task<IActionResult> Overview() => OkResponse(new
    {
        totalStudents = await db.Users.CountAsync(u => u.Role == "student" && u.IsActive),
        totalMeals = await db.Bills.SumAsync(b => b.TotalMeals),
        totalBazar = await db.DailyBazars.SumAsync(b => b.TotalAmount),
        totalBilled = await db.Bills.SumAsync(b => b.TotalAmount),
        totalDue = await db.Bills.Where(b => b.Status == "DUE").SumAsync(b => b.TotalAmount),
        pendingComplaints = await db.Complaints.CountAsync(c => c.Status != "resolved")
    }, "Overview analytics retrieved successfully");

    [HttpGet("meal-trends")]
    public async Task<IActionResult> MealTrends(int days = 7)
    {
        var to = DateTime.Now.Date;
        var from = to.AddDays(-(Math.Max(days, 1) - 1));
        var rows = await db.MealSelections.Where(m => m.Date >= from && m.Date <= to).ToListAsync();
        var trends = Enumerable.Range(0, (to - from).Days + 1).Select(offset =>
        {
            var date = from.AddDays(offset);
            var dayRows = rows.Where(r => r.Date.Date == date).ToList();
            var meals = dayRows.Sum(r => (r.Breakfast ? 1 : 0) + (r.Lunch ? 1 : 0) + (r.Dinner ? 1 : 0));
            return new { date, meals };
        });
        return OkResponse(new { trends }, "Meal trends retrieved successfully");
    }

    [Authorize(Roles = "admin")]
    [HttpGet("revenue-trends")]
    public async Task<IActionResult> RevenueTrends(int? year) => await BillingTrends(year);

    [Authorize(Roles = "admin")]
    [HttpGet("billing-trends")]
    public async Task<IActionResult> BillingTrends(int? year)
    {
        var targetYear = year ?? DateTime.Now.Year;
        var bills = await db.Bills.Where(b => b.Year == targetYear).ToListAsync();
        var bazars = await db.DailyBazars.Where(b => b.Date.Year == targetYear).ToListAsync();
        var trends = Enumerable.Range(1, 12).Select(month => new
        {
            month,
            billed = bills.Where(b => b.Month == month).Sum(b => b.TotalAmount),
            due = bills.Where(b => b.Month == month && b.Status == "DUE").Sum(b => b.TotalAmount),
            bazar = bazars.Where(b => b.Date.Month == month).Sum(b => b.TotalAmount)
        });
        return OkResponse(new { trends }, "Billing trends retrieved successfully");
    }

    [HttpGet("feedback")]
    public async Task<IActionResult> Feedback() =>
        OkResponse(new { averageRating = await db.Feedback.AnyAsync() ? await db.Feedback.AverageAsync(f => f.Rating) : 0, totalFeedbacks = await db.Feedback.CountAsync() }, "Feedback analytics retrieved successfully");

    [Authorize(Roles = "admin")]
    [HttpGet("complaints")]
    public async Task<IActionResult> Complaints() =>
        OkResponse(new { total = await db.Complaints.CountAsync(), pending = await db.Complaints.CountAsync(c => c.Status == "pending"), resolved = await db.Complaints.CountAsync(c => c.Status == "resolved") }, "Complaint analytics retrieved successfully");

    [HttpGet("meal-popularity")]
    public async Task<IActionResult> MealPopularity() =>
        OkResponse(new { breakfast = await db.MealSelections.CountAsync(m => m.Breakfast), lunch = await db.MealSelections.CountAsync(m => m.Lunch), dinner = await db.MealSelections.CountAsync(m => m.Dinner) }, "Meal popularity retrieved successfully");
}
