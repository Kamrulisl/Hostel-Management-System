using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize(Roles = "admin")]
[Route("api/v1/settings")]
public class SettingsController(AppDbContext db) : ApiControllerBase
{
    [HttpGet]
    public async Task<IActionResult> Get() => OkResponse((await GetSettings()).Dto(), "Settings retrieved successfully");

    [HttpPatch]
    public async Task<IActionResult> Update(JsonElement body)
    {
        var settings = await GetSettings();
        settings.BreakfastPrice = body.Decimal("breakfastPrice") ?? settings.BreakfastPrice;
        settings.LunchPrice = body.Decimal("lunchPrice") ?? settings.LunchPrice;
        settings.DinnerPrice = body.Decimal("dinnerPrice") ?? settings.DinnerPrice;
        settings.CutoffTime = body.String("cutoffTime") ?? settings.CutoffTime;
        settings.CutoffDaysBefore = body.Int("cutoffDaysBefore") ?? settings.CutoffDaysBefore;
        settings.ExtraCharges = body.Decimal("extraCharges") ?? settings.ExtraCharges;
        settings.DiscountPercentage = body.Decimal("discountPercentage") ?? settings.DiscountPercentage;
        settings.TaxPercentage = body.Decimal("taxPercentage") ?? settings.TaxPercentage;
        settings.MessName = body.String("messName") ?? settings.MessName;
        settings.MessAddress = body.String("messAddress") ?? settings.MessAddress;
        settings.ContactEmail = body.String("contactEmail") ?? settings.ContactEmail;
        settings.ContactPhone = body.String("contactPhone") ?? settings.ContactPhone;
        settings.EnableEmailNotifications = body.Bool("enableEmailNotifications") ?? settings.EnableEmailNotifications;
        settings.EnableSmsNotifications = body.Bool("enableSMSNotifications") ?? settings.EnableSmsNotifications;
        settings.UpdatedById = User.Id();
        await db.SaveChangesAsync();
        return OkResponse(settings.Dto(), "Settings updated successfully");
    }

    [HttpPost("holidays")]
    public async Task<IActionResult> AddHoliday(JsonElement body)
    {
        var settings = await GetSettings();
        settings.Holidays.Add(new Holiday { Id = Ids.New(), Date = body.Date("date")?.Date ?? DateTime.UtcNow.Date, Reason = body.String("reason") ?? "" });
        await db.SaveChangesAsync();
        return OkResponse(settings.Dto(), "Holiday added successfully");
    }

    [HttpDelete("holidays/{id}")]
    public async Task<IActionResult> RemoveHoliday(string id)
    {
        var settings = await GetSettings();
        var holiday = settings.Holidays.FirstOrDefault(h => h.Id == id);
        if (holiday is not null) db.Holidays.Remove(holiday);
        await db.SaveChangesAsync();
        return OkResponse(settings.Dto(), "Holiday removed successfully");
    }

    private async Task<Settings> GetSettings()
    {
        var settings = await db.Settings.Include(s => s.Holidays).FirstOrDefaultAsync();
        if (settings is not null) return settings;
        settings = new Settings { Id = Ids.New() };
        db.Settings.Add(settings);
        await db.SaveChangesAsync();
        return settings;
    }
}
