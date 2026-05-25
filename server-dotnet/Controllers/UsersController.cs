using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize(Roles = "admin")]
[Route("api/v1/users")]
public class UsersController(AppDbContext db) : ApiControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll(string? role, string? search, int page = 1, int limit = 10)
    {
        var query = db.Users.AsQueryable();
        if (!string.IsNullOrWhiteSpace(role)) query = query.Where(u => u.Role == role);
        if (!string.IsNullOrWhiteSpace(search))
        {
            var term = search.ToLower();
            query = query.Where(u => u.Name.ToLower().Contains(term) || u.Email.ToLower().Contains(term) || (u.RollNumber ?? "").ToLower().Contains(term));
        }

        var total = await query.CountAsync();
        var users = await query.OrderByDescending(u => u.CreatedAt).Skip((page - 1) * limit).Take(limit).ToListAsync();
        return OkResponse(new { users = users.Select(u => u.Dto()), pagination = new { total, page, pages = (int)Math.Ceiling(total / (double)limit) } });
    }

    [HttpGet("stats")]
    public async Task<IActionResult> Stats()
    {
        var stats = await db.Users.GroupBy(u => u.Role).Select(g => new { _id = g.Key, count = g.Count() }).ToListAsync();
        var totalUsers = await db.Users.CountAsync();
        var activeUsers = await db.Users.CountAsync(u => u.IsActive);
        return OkResponse(new { stats, totalUsers, activeUsers, inactiveUsers = totalUsers - activeUsers });
    }

    [HttpGet("export/csv")]
    public async Task<IActionResult> Export()
    {
        var users = await db.Users.OrderByDescending(u => u.CreatedAt).ToListAsync();
        var csv = "Name,Email,Role,Roll Number,Room,Phone,Active\n"
            + string.Join("\n", users.Select(u => CsvWriter.Csv(u.Name, u.Email, u.Role, u.RollNumber, u.RoomNumber, u.Phone, u.IsActive.ToString())));
        return File(System.Text.Encoding.UTF8.GetBytes(csv), "text/csv", $"users-{DateTimeOffset.UtcNow.ToUnixTimeMilliseconds()}.csv");
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(string id)
    {
        var user = await db.Users.FindAsync(id);
        return user is null ? ErrorResponse(404, "User not found") : OkResponse(new { user = user.Dto() });
    }

    [HttpPost]
    public async Task<IActionResult> Create(JsonElement body)
    {
        var email = body.String("email")?.Trim().ToLowerInvariant();
        var rollNumber = body.String("rollNumber");

        if (await db.Users.AnyAsync(u => u.Email == email || (!string.IsNullOrEmpty(rollNumber) && u.RollNumber == rollNumber)))
            return ErrorResponse(400, "User with this email or roll number already exists");

        var user = new User
        {
            Id = Ids.New(),
            Name = body.String("name") ?? "",
            Email = email ?? "",
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(body.String("password") ?? "password", 12),
            Role = body.String("role") ?? "student",
            RollNumber = rollNumber,
            RoomNumber = body.String("roomNumber"),
            Phone = body.String("phone")
        };

        db.Users.Add(user);
        await db.SaveChangesAsync();
        return CreatedResponse(new { user = user.Dto() }, "User created successfully");
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(string id, JsonElement body)
    {
        var user = await db.Users.FindAsync(id);
        if (user is null) return ErrorResponse(404, "User not found");

        user.Name = body.String("name") ?? user.Name;
        user.Email = body.String("email")?.Trim().ToLowerInvariant() ?? user.Email;
        user.Role = body.String("role") ?? user.Role;
        user.RollNumber = body.String("rollNumber") ?? user.RollNumber;
        user.RoomNumber = body.String("roomNumber") ?? user.RoomNumber;
        user.Phone = body.String("phone") ?? user.Phone;
        user.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();

        return OkResponse(new { user = user.Dto() }, "User updated successfully");
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(string id)
    {
        if (User.Id() == id) return ErrorResponse(400, "You cannot delete your own account");
        var user = await db.Users.FindAsync(id);
        if (user is null) return ErrorResponse(404, "User not found");

        db.Users.Remove(user);
        await db.SaveChangesAsync();
        return OkResponse(null, "User deleted successfully");
    }

    [HttpPatch("{id}/toggle-status")]
    public async Task<IActionResult> ToggleStatus(string id)
    {
        var user = await db.Users.FindAsync(id);
        if (user is null) return ErrorResponse(404, "User not found");

        user.IsActive = !user.IsActive;
        user.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return OkResponse(new { user = new { _id = user.Id, isActive = user.IsActive } }, $"User {(user.IsActive ? "activated" : "deactivated")} successfully");
    }
}
