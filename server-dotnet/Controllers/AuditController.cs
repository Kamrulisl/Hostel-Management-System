using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize(Roles = "admin")]
[Route("api/v1/audit")]
public class AuditController(AppDbContext db) : ApiControllerBase
{
    [HttpGet]
    public async Task<IActionResult> Logs(string? action, string? entityType, DateTime? startDate, DateTime? endDate, int page = 1, int limit = 50)
    {
        var query = Filter(action, entityType, startDate, endDate);
        var total = await query.CountAsync();
        var logs = await query.OrderByDescending(a => a.CreatedAt).Skip((page - 1) * limit).Take(limit).ToListAsync();
        return OkResponse(new { logs = logs.Select(a => a.Dto()), pagination = new { total, page, pages = (int)Math.Ceiling(total / (double)limit) } });
    }

    [HttpGet("trail/{entityType}/{entityId}")]
    public async Task<IActionResult> Trail(string entityType, string entityId)
    {
        var logs = await db.AuditLogs.Where(a => a.EntityType == entityType && a.EntityId == entityId).OrderByDescending(a => a.CreatedAt).ToListAsync();
        return OkResponse(new { logs = logs.Select(a => a.Dto()) });
    }

    [HttpGet("export")]
    public async Task<IActionResult> Export(string? action, string? entityType, DateTime? startDate, DateTime? endDate)
    {
        var logs = await Filter(action, entityType, startDate, endDate).OrderByDescending(a => a.CreatedAt).ToListAsync();
        var csv = "Date,ActorId,ActorRole,Action,EntityType,EntityId,Description\n"
            + string.Join("\n", logs.Select(l => CsvWriter.Csv(l.CreatedAt.ToString("yyyy-MM-dd HH:mm"), l.ActorId, l.ActorRole, l.Action, l.EntityType, l.EntityId, l.Description)));
        return File(System.Text.Encoding.UTF8.GetBytes(csv), "text/csv", "audit.csv");
    }

    private IQueryable<AuditLog> Filter(string? action, string? entityType, DateTime? startDate, DateTime? endDate)
    {
        var query = db.AuditLogs.AsQueryable();
        if (!string.IsNullOrWhiteSpace(action)) query = query.Where(a => a.Action == action);
        if (!string.IsNullOrWhiteSpace(entityType)) query = query.Where(a => a.EntityType == entityType);
        if (startDate is not null) query = query.Where(a => a.CreatedAt >= startDate.Value.Date);
        if (endDate is not null) query = query.Where(a => a.CreatedAt < endDate.Value.Date.AddDays(1));
        return query;
    }
}
