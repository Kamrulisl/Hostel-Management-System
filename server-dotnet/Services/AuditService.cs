public class AuditService(AppDbContext db)
{
    public async Task LogAsync(string? actorId, string? actorRole, string action, string entityType, string? entityId, string description, string metadataJson = "{}")
    {
        db.AuditLogs.Add(new AuditLog
        {
            Id = Ids.New(),
            ActorId = actorId,
            ActorRole = actorRole,
            Action = action,
            EntityType = entityType,
            EntityId = entityId,
            Description = description,
            MetadataJson = metadataJson,
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow
        });

        await db.SaveChangesAsync();
    }
}
