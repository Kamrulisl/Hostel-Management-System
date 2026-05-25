using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
[Route("api/v1/attendance")]
public class AttendanceController(AppDbContext db) : ApiControllerBase
{
    [Authorize(Roles = "manager,admin")]
    [HttpPost("mark")]
    public async Task<IActionResult> Mark(JsonElement body)
    {
        var studentId = body.String("studentId");
        var student = await db.Users.FindAsync(studentId);
        if (student is null || student.Role != "student") return ErrorResponse(404, "Student not found");

        var date = body.Date("date")?.Date ?? DateTime.UtcNow.Date;
        var mealType = body.String("mealType") ?? "";
        var attendance = await db.Attendance.FirstOrDefaultAsync(a => a.StudentId == studentId && a.Date == date && a.MealType == mealType);

        if (attendance is null)
        {
            attendance = new Attendance { Id = Ids.New(), StudentId = studentId!, Date = date, MealType = mealType, MarkedById = User.Id()! };
            db.Attendance.Add(attendance);
        }

        attendance.Present = body.Bool("present") ?? false;
        attendance.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return CreatedResponse(new { attendance = attendance.Dto() }, "Attendance marked successfully");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpGet("report")]
    public async Task<IActionResult> Report(DateTime? date, string? mealType)
    {
        var query = db.Attendance.Include(a => a.Student).Include(a => a.MarkedBy).AsQueryable();
        if (date is not null) query = query.Where(a => a.Date == date.Value.Date);
        if (!string.IsNullOrEmpty(mealType)) query = query.Where(a => a.MealType == mealType);
        var attendance = await query.OrderByDescending(a => a.Date).ToListAsync();
        return OkResponse(new { attendance = attendance.Select(a => a.Dto()), summary = Summary(attendance) });
    }

    [Authorize(Roles = "student")]
    [HttpGet("me")]
    public async Task<IActionResult> Mine(int? month, int? year)
    {
        var query = db.Attendance.Where(a => a.StudentId == User.Id());
        if (month is not null && year is not null) query = query.Where(a => a.Date.Month == month && a.Date.Year == year);
        var attendance = await query.OrderByDescending(a => a.Date).ToListAsync();
        return OkResponse(new { attendance = attendance.Select(a => a.Dto()), summary = Summary(attendance) });
    }

    [Authorize(Roles = "manager,admin")]
    [HttpGet("export")]
    public async Task<IActionResult> Export()
    {
        var list = await db.Attendance.Include(a => a.Student).OrderByDescending(a => a.Date).ToListAsync();
        var csv = "Student,Date,Meal Type,Present,Approved\n"
            + string.Join("\n", list.Select(a => CsvWriter.Csv(a.Student?.Name, a.Date.ToString("yyyy-MM-dd"), a.MealType, a.Present.ToString(), a.Approved.ToString())));
        return File(System.Text.Encoding.UTF8.GetBytes(csv), "text/csv", "attendance.csv");
    }

    [Authorize(Roles = "student")]
    [HttpPost("self-mark")]
    public async Task<IActionResult> SelfMark(JsonElement body)
    {
        var date = body.Date("date")?.Date ?? DateTime.UtcNow.Date;
        var mealType = body.String("mealType") ?? "";

        if (await db.Attendance.AnyAsync(a => a.StudentId == User.Id() && a.Date == date && a.MealType == mealType))
            return ErrorResponse(400, "Attendance already marked for this meal");

        var attendance = new Attendance { Id = Ids.New(), StudentId = User.Id()!, Date = date, MealType = mealType, Present = true, Approved = false, MarkedById = User.Id()! };
        db.Attendance.Add(attendance);
        await db.SaveChangesAsync();
        return CreatedResponse(new { attendance = attendance.Dto() }, "Attendance marked. Waiting for manager approval");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpPatch("{id}/approve")]
    public async Task<IActionResult> Approve(string id)
    {
        var attendance = await db.Attendance.FindAsync(id);
        if (attendance is null) return ErrorResponse(404, "Attendance record not found");

        attendance.Approved = true;
        attendance.ApprovedById = User.Id();
        attendance.ApprovedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return OkResponse(new { attendance = attendance.Dto() }, "Attendance approved successfully");
    }

    [Authorize(Roles = "manager,admin")]
    [HttpGet("pending")]
    public async Task<IActionResult> Pending()
    {
        var attendance = await db.Attendance.Include(a => a.Student).Where(a => !a.Approved).OrderByDescending(a => a.Date).ToListAsync();
        return OkResponse(new { attendance = attendance.Select(a => a.Dto()), count = attendance.Count });
    }

    private static object Summary(IEnumerable<Attendance> rows) =>
        new { total = rows.Count(), present = rows.Count(a => a.Present), absent = rows.Count(a => !a.Present) };
}
