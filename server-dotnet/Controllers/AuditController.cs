using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize(Roles = "admin")]
[Route("api/v1/audit")]
public class AuditController(AppDbContext db) : ApiControllerBase
{
    [HttpGet]
    public async Task<IActionResult> Logs(int page = 1, int limit = 50)
    {
        var total = await db.AuditLogs.CountAsync();
        var logs = await db.AuditLogs.OrderByDescending(a => a.CreatedAt).Skip((page - 1) * limit).Take(limit).ToListAsync();
        return OkResponse(new { logs = logs.Select(a => a.Dto()), pagination = new { total, page, pages = (int)Math.Ceiling(total / (double)limit) } });
    }

    [HttpGet("trail/{entityType}/{entityId}")]
    public async Task<IActionResult> Trail(string entityType, string entityId)
    {
        var logs = await db.AuditLogs.Where(a => a.EntityType == entityType && a.EntityId == entityId).OrderByDescending(a => a.CreatedAt).ToListAsync();
        return OkResponse(new { logs = logs.Select(a => a.Dto()) });
    }

    [HttpGet("export")]
    public IActionResult Export() => File(System.Text.Encoding.UTF8.GetBytes("Date,Actor,Action,Entity\n"), "text/csv", "audit.csv");
}
