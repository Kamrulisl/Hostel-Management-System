using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
[Route("api/v1/menus")]
public class MenusController(AppDbContext db, AuditService audit) : ApiControllerBase
{
    [HttpGet("today")]
    public async Task<IActionResult> Today()
    {
        var today = DateTime.UtcNow.Date;
        var menus = await db.Menus.Include(m => m.CreatedBy).Where(m => m.Date == today).OrderBy(m => m.MealType).ToListAsync();
        return OkResponse(new
        {
            menu = new
            {
                date = today,
                breakfast = menus.FirstOrDefault(m => m.MealType == "breakfast")?.Dto(),
                lunch = menus.FirstOrDefault(m => m.MealType == "lunch")?.Dto(),
                dinner = menus.FirstOrDefault(m => m.MealType == "dinner")?.Dto()
            }
        });
    }

    [HttpGet]
    public async Task<IActionResult> Get(DateTime? date)
    {
        if (date is null) return ErrorResponse(400, "Date parameter is required");
        var day = date.Value.Date;
        var menus = await db.Menus.Include(m => m.CreatedBy).Where(m => m.Date == day).OrderBy(m => m.MealType).ToListAsync();
        return OkResponse(new { menus = menus.Select(m => m.Dto()) });
    }

    [Authorize(Roles = "manager,admin")]
    [HttpPost]
    public async Task<IActionResult> Create(JsonElement body)
    {
        var menu = new Menu
        {
            Id = Ids.New(),
            Date = body.Date("date")?.Date ?? DateTime.UtcNow.Date,
            MealType = body.String("mealType") ?? "",
            ItemsJson = body.Raw("items") ?? "[]",
            ImageUrl = body.String("imageUrl") ?? "",
            CreatedById = User.Id()!
        };

        db.Menus.Add(menu);
        await db.SaveChangesAsync();
        await audit.LogAsync(User.Id(), User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value, "CREATE", "Menu", menu.Id, $"Created {menu.MealType} menu");
        return CreatedResponse(new { menu = menu.Dto() }, "Menu created successfully");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(string id, JsonElement body)
    {
        var menu = await db.Menus.FindAsync(id);
        if (menu is null) return ErrorResponse(404, "Menu not found");

        menu.ItemsJson = body.Raw("items") ?? menu.ItemsJson;
        menu.ImageUrl = body.String("imageUrl") ?? menu.ImageUrl;
        menu.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        await audit.LogAsync(User.Id(), User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value, "UPDATE", "Menu", menu.Id, $"Updated {menu.MealType} menu");
        return OkResponse(new { menu = menu.Dto() }, "Menu updated successfully");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(string id)
    {
        var menu = await db.Menus.FindAsync(id);
        if (menu is null) return ErrorResponse(404, "Menu not found");

        db.Menus.Remove(menu);
        await db.SaveChangesAsync();
        await audit.LogAsync(User.Id(), User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value, "DELETE", "Menu", id, "Deleted menu");
        return OkResponse(new { }, "Menu deleted successfully");
    }
}
