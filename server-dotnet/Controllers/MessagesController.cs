using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Text.Json;

[Authorize]
[Route("api/v1/messages")]
public class MessagesController(AppDbContext db) : ApiControllerBase
{
    [HttpGet("users")]
    public async Task<IActionResult> Users()
    {
        var role = User.FindFirst(System.Security.Claims.ClaimTypes.Role)?.Value;
        var query = db.Users.Where(u => u.Id != User.Id());
        if (role == "student") query = query.Where(u => u.Role == "manager" || u.Role == "admin");
        if (role == "manager") query = query.Where(u => u.Role == "student" || u.Role == "admin");
        var users = await query.ToListAsync();
        return OkResponse(new { users = users.Select(u => new { _id = u.Id, id = u.Id, u.Name, u.Email, u.Role }) });
    }

    [HttpGet("conversations")]
    public IActionResult Conversations() => OkResponse(new { conversations = Array.Empty<object>() });

    [HttpGet("{userId}")]
    public async Task<IActionResult> Conversation(string userId)
    {
        var id = User.Id();
        var messages = await db.Messages.Include(m => m.Sender).Include(m => m.Receiver)
            .Where(m => (m.SenderId == id && m.ReceiverId == userId) || (m.SenderId == userId && m.ReceiverId == id))
            .OrderBy(m => m.CreatedAt)
            .Take(100)
            .ToListAsync();
        return OkResponse(new { messages = messages.Select(m => m.Dto()) });
    }

    [HttpPost]
    public async Task<IActionResult> Send(JsonElement body)
    {
        var receiverId = body.String("receiverId");
        var text = body.String("message") ?? body.String("text");
        if (string.IsNullOrWhiteSpace(receiverId) || string.IsNullOrWhiteSpace(text))
            return ErrorResponse(400, "receiverId and message are required");

        if (!await db.Users.AnyAsync(u => u.Id == receiverId))
            return ErrorResponse(404, "Receiver not found");

        var message = new Message
        {
            Id = Ids.New(),
            SenderId = User.Id()!,
            ReceiverId = receiverId,
            Text = text.Trim()
        };
        db.Messages.Add(message);
        await db.SaveChangesAsync();

        var saved = await db.Messages.Include(m => m.Sender).Include(m => m.Receiver).FirstAsync(m => m.Id == message.Id);
        return CreatedResponse(new { message = saved.Dto() }, "Message sent successfully");
    }

    [HttpPatch("{userId}/read")]
    public async Task<IActionResult> MarkRead(string userId)
    {
        await db.Messages
            .Where(m => m.SenderId == userId && m.ReceiverId == User.Id() && !m.Read)
            .ExecuteUpdateAsync(s => s.SetProperty(m => m.Read, true).SetProperty(m => m.ReadAt, DateTime.UtcNow));
        return OkResponse(new { }, "Messages marked as read");
    }
}
