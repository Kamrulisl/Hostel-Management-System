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
        totalStudents = await db.Users.CountAsync(u => u.Role == "student"),
        totalMeals = await db.MealSelections.CountAsync(),
        totalRevenue = await db.Bills.Where(b => b.Status == "PAID").SumAsync(b => b.TotalAmount),
        pendingComplaints = await db.Complaints.CountAsync(c => c.Status != "resolved")
    }, "Overview analytics retrieved successfully");

    [HttpGet("attendance-trends")]
    public async Task<IActionResult> AttendanceTrends() =>
        OkResponse(new { trends = await db.Attendance.GroupBy(a => a.Date).Select(g => new { date = g.Key, present = g.Count(a => a.Present), absent = g.Count(a => !a.Present) }).ToListAsync() }, "Attendance trends retrieved successfully");

    [Authorize(Roles = "admin")]
    [HttpGet("revenue-trends")]
    public async Task<IActionResult> RevenueTrends(int? year) =>
        OkResponse(new { trends = await db.Bills.Where(b => year == null || b.Year == year).GroupBy(b => b.Month).Select(g => new { month = g.Key, revenue = g.Sum(b => b.Status == "PAID" ? b.TotalAmount : 0) }).ToListAsync() }, "Revenue trends retrieved successfully");

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
