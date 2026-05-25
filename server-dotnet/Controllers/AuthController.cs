using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Route("api/v1/auth")]
public class AuthController(AppDbContext db, JwtTokenService jwt, AuditService audit) : ApiControllerBase
{
    [HttpPost("register")]
    public async Task<IActionResult> Register(JsonElement body)
    {
        var email = body.String("email")?.Trim().ToLowerInvariant();
        var password = body.String("password");
        var name = body.String("name")?.Trim();

        if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            return ErrorResponse(400, "Name, email, and password are required");

        if (await db.Users.AnyAsync(u => u.Email == email))
            return ErrorResponse(400, "User already exists");

        var user = new User
        {
            Id = Ids.New(),
            Name = name,
            Email = email,
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(password, 12),
            Role = body.String("role") ?? "student",
            RollNumber = body.String("rollNumber"),
            RoomNumber = body.String("roomNumber"),
            Phone = body.String("phone")
        };

        db.Users.Add(user);
        await db.SaveChangesAsync();
        await audit.LogAsync(user.Id, user.Role, "CREATE", "User", user.Id, "User registered");

        return CreatedResponse(new { user = user.AuthDto(), token = jwt.CreateToken(user) }, "User registered successfully");
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login(JsonElement body)
    {
        var email = body.String("email")?.Trim().ToLowerInvariant();
        var password = body.String("password") ?? "";
        var user = await db.Users.FirstOrDefaultAsync(u => u.Email == email);

        if (user is null || !BCrypt.Net.BCrypt.Verify(password, user.PasswordHash))
            return ErrorResponse(401, "Invalid credentials");

        if (!user.IsActive)
            return ErrorResponse(401, "Account is deactivated");

        await audit.LogAsync(user.Id, user.Role, "LOGIN", "User", user.Id, "User logged in");

        return OkResponse(new { user = user.AuthDto(), token = jwt.CreateToken(user) }, "Login successful");
    }

    [Authorize]
    [HttpGet("me")]
    public async Task<IActionResult> Me()
    {
        var user = await db.Users.FindAsync(User.Id());
        return user is null ? ErrorResponse(401, "Not authorized") : OkResponse(new { user = user.Dto() });
    }
}
