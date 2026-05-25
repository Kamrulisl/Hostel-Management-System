using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
[Route("api/v1/notices")]
public class NoticesController(AppDbContext db) : ApiControllerBase
{
    [Authorize(Roles = "admin")]
    [HttpPost]
    public async Task<IActionResult> Create(JsonElement body)
    {
        var notice = new Notice
        {
            Id = Ids.New(),
            Title = body.String("title") ?? "",
            Content = body.String("content") ?? "",
            Category = body.String("category") ?? "general",
            IsPinned = body.Bool("isPinned") ?? false,
            TargetAudience = body.String("targetAudience") ?? "all",
            ExpiresAt = body.Date("expiresAt"),
            CreatedById = User.Id()!
        };
        db.Notices.Add(notice);
        await db.SaveChangesAsync();
        return CreatedResponse(new { notice = notice.Dto() }, "Notice created successfully");
    }

    [HttpGet]
    public async Task<IActionResult> All()
    {
        var role = User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value;
        var now = DateTime.UtcNow;
        var query = db.Notices.Include(n => n.CreatedBy).Where(n => n.ExpiresAt == null || n.ExpiresAt > now);
        if (role == "student") query = query.Where(n => n.TargetAudience == "all" || n.TargetAudience == "students");
        if (role == "manager") query = query.Where(n => n.TargetAudience == "all" || n.TargetAudience == "managers");

        var notices = await query.OrderByDescending(n => n.IsPinned).ThenByDescending(n => n.CreatedAt).ToListAsync();
        return OkResponse(new { notices = notices.Select(n => n.Dto()) });
    }

    [Authorize(Roles = "admin")]
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(string id, JsonElement body)
    {
        var notice = await db.Notices.FindAsync(id);
        if (notice is null) return ErrorResponse(404, "Notice not found");

        notice.Title = body.String("title") ?? notice.Title;
        notice.Content = body.String("content") ?? notice.Content;
        notice.Category = body.String("category") ?? notice.Category;
        notice.IsPinned = body.Bool("isPinned") ?? notice.IsPinned;
        notice.TargetAudience = body.String("targetAudience") ?? notice.TargetAudience;
        notice.ExpiresAt = body.Date("expiresAt") ?? notice.ExpiresAt;
        await db.SaveChangesAsync();
        return OkResponse(new { notice = notice.Dto() }, "Notice updated successfully");
    }

    [Authorize(Roles = "admin")]
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(string id)
    {
        var notice = await db.Notices.FindAsync(id);
        if (notice is null) return ErrorResponse(404, "Notice not found");
        db.Notices.Remove(notice);
        await db.SaveChangesAsync();
        return OkResponse(new { }, "Notice deleted successfully");
    }
}
