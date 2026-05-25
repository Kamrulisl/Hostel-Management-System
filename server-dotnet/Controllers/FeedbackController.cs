using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
[Route("api/v1/feedback")]
public class FeedbackController(AppDbContext db) : ApiControllerBase
{
    [Authorize(Roles = "student")]
    [HttpPost]
    public async Task<IActionResult> Submit(JsonElement body)
    {
        var date = body.Date("date")?.Date ?? DateTime.UtcNow.Date;
        var mealType = body.String("mealType") ?? "";
        var feedback = await db.Feedback.FirstOrDefaultAsync(f => f.StudentId == User.Id() && f.Date == date && f.MealType == mealType);

        if (feedback is null)
        {
            feedback = new Feedback { Id = Ids.New(), StudentId = User.Id()!, Date = date, MealType = mealType };
            db.Feedback.Add(feedback);
        }

        feedback.Rating = body.Int("rating") ?? feedback.Rating;
        feedback.Comment = body.String("comment");
        feedback.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return CreatedResponse(new { feedback = feedback.Dto() }, "Feedback submitted successfully");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpGet("summary")]
    public async Task<IActionResult> Summary(DateTime? startDate, DateTime? endDate, string? mealType)
    {
        var query = db.Feedback.Include(f => f.Student).AsQueryable();
        if (startDate is not null && endDate is not null) query = query.Where(f => f.Date >= startDate.Value.Date && f.Date <= endDate.Value.Date);
        if (!string.IsNullOrEmpty(mealType)) query = query.Where(f => f.MealType == mealType);

        var feedbacks = await query.ToListAsync();
        object MealRating(string meal)
        {
            var rows = feedbacks.Where(f => f.MealType == meal).ToList();
            return new { count = rows.Count, avgRating = rows.Count == 0 ? 0 : Math.Round(rows.Average(f => f.Rating), 2) };
        }

        var summary = new
        {
            totalFeedbacks = feedbacks.Count,
            averageRating = feedbacks.Count == 0 ? 0 : Math.Round(feedbacks.Average(f => f.Rating), 2),
            ratingDistribution = Enumerable.Range(1, 5).ToDictionary(i => i.ToString(), i => feedbacks.Count(f => f.Rating == i)),
            byMealType = new { breakfast = MealRating("breakfast"), lunch = MealRating("lunch"), dinner = MealRating("dinner") }
        };

        return OkResponse(new { summary, feedbacks = feedbacks.Select(f => f.Dto()) });
    }

    [Authorize(Roles = "student")]
    [HttpGet("me")]
    public async Task<IActionResult> Mine()
    {
        var feedbacks = await db.Feedback.Where(f => f.StudentId == User.Id()).OrderByDescending(f => f.Date).ToListAsync();
        return OkResponse(new { feedbacks = feedbacks.Select(f => f.Dto()) });
    }
}
