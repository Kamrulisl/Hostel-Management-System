using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
[Route("api/v1/meal-plans")]
public class MealPlansController(AppDbContext db) : ApiControllerBase
{
    [Authorize(Roles = "student")]
    [HttpPost]
    public async Task<IActionResult> Save(JsonElement body)
    {
        var date = body.Date("date")?.Date ?? DateTime.UtcNow.Date;
        var plan = await db.MealPlans.FirstOrDefaultAsync(m => m.StudentId == User.Id() && m.Date == date);

        if (plan is null)
        {
            plan = new MealPlan { Id = Ids.New(), StudentId = User.Id()!, Date = date };
            db.MealPlans.Add(plan);
        }

        ApplyMeals(plan, body);
        plan.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return CreatedResponse(new { mealPlan = plan.Dto() }, "Meal plan saved successfully");
    }

    [Authorize(Roles = "student")]
    [HttpGet("me")]
    public async Task<IActionResult> Mine(int? month, int? year)
    {
        var query = db.MealPlans.Where(m => m.StudentId == User.Id());
        if (month is not null && year is not null) query = query.Where(m => m.Date.Month == month && m.Date.Year == year);
        var mealPlans = await query.OrderByDescending(m => m.Date).ToListAsync();
        return OkResponse(new { mealPlans = mealPlans.Select(m => m.Dto()) });
    }

    [Authorize(Roles = "manager,admin")]
    [HttpGet]
    public async Task<IActionResult> All(DateTime? date)
    {
        var query = db.MealPlans.Include(m => m.Student).AsQueryable();
        if (date is not null) query = query.Where(m => m.Date == date.Value.Date);
        var mealPlans = await query.OrderByDescending(m => m.Date).ToListAsync();
        return OkResponse(new { mealPlans = mealPlans.Select(m => m.Dto()) });
    }

    private static void ApplyMeals(IMealFlags target, JsonElement body)
    {
        if (!body.TryGetProperty("meals", out var meals)) meals = body;
        target.Breakfast = meals.Bool("breakfast") ?? target.Breakfast;
        target.Lunch = meals.Bool("lunch") ?? target.Lunch;
        target.Dinner = meals.Bool("dinner") ?? target.Dinner;
    }
}
