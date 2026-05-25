using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
[Route("api/v1/complaints")]
public class ComplaintsController(AppDbContext db) : ApiControllerBase
{
    [Authorize(Roles = "student")]
    [HttpPost]
    public async Task<IActionResult> Create(JsonElement body)
    {
        var complaint = new Complaint
        {
            Id = Ids.New(),
            StudentId = User.Id()!,
            Category = body.String("category") ?? "",
            Title = body.String("title") ?? "",
            Description = body.String("description") ?? "",
            Priority = body.String("priority") ?? "medium"
        };
        db.Complaints.Add(complaint);
        await db.SaveChangesAsync();
        return CreatedResponse(new { complaint = complaint.Dto() }, "Complaint submitted successfully");
    }

    [Authorize(Roles = "admin,manager")]
    [HttpGet]
    public async Task<IActionResult> All(string? status, string? category)
    {
        var query = db.Complaints.Include(c => c.Student).Include(c => c.ResolvedBy).AsQueryable();
        if (!string.IsNullOrEmpty(status)) query = query.Where(c => c.Status == status);
        if (!string.IsNullOrEmpty(category)) query = query.Where(c => c.Category == category);
        var complaints = await query.OrderByDescending(c => c.CreatedAt).ToListAsync();
        return OkResponse(new { complaints = complaints.Select(c => c.Dto()) });
    }

    [Authorize(Roles = "student")]
    [HttpGet("me")]
    public async Task<IActionResult> Mine()
    {
        var complaints = await db.Complaints.Include(c => c.ResolvedBy).Where(c => c.StudentId == User.Id()).OrderByDescending(c => c.CreatedAt).ToListAsync();
        return OkResponse(new { complaints = complaints.Select(c => c.Dto()) });
    }

    [Authorize(Roles = "admin")]
    [HttpPatch("{id}/status")]
    public async Task<IActionResult> UpdateStatus(string id, JsonElement body)
    {
        var complaint = await db.Complaints.FindAsync(id);
        if (complaint is null) return ErrorResponse(404, "Complaint not found");

        complaint.Status = body.String("status") ?? complaint.Status;
        complaint.AdminNotes = body.String("adminNotes") ?? complaint.AdminNotes;
        if (complaint.Status == "resolved")
        {
            complaint.ResolvedById = User.Id();
            complaint.ResolvedAt = DateTime.UtcNow;
        }

        await db.SaveChangesAsync();
        return OkResponse(new { complaint = complaint.Dto() }, "Complaint status updated successfully");
    }
}
