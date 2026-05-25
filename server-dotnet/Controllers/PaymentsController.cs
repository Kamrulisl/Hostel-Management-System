using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Route("api/v1/payments")]
public class PaymentsController(AppDbContext db) : ApiControllerBase
{
    [HttpPost("webhook")]
    public IActionResult Webhook() => Ok(new { received = true });

    [Authorize(Roles = "student")]
    [HttpPost("create-intent")]
    public IActionResult CreateIntent(JsonElement body) =>
        OkResponse(new { clientSecret = "stripe_not_configured", paymentIntentId = "local_" + Ids.New() }, "Payment intent created successfully");

    [Authorize(Roles = "student")]
    [HttpPost("confirm")]
    public async Task<IActionResult> Confirm(JsonElement body)
    {
        var bill = await db.Bills.FirstOrDefaultAsync(b => b.Id == body.String("billId") && b.StudentId == User.Id() && b.Status == "DUE");
        if (bill is null) return ErrorResponse(404, "Bill not found or already paid");
        bill.Status = "PAID";
        bill.PaidAt = DateTime.UtcNow;
        bill.PaymentMethod = "stripe";
        bill.TransactionId = body.String("paymentIntentId");
        await db.SaveChangesAsync();
        return OkResponse(new { bill = bill.Dto() }, "Payment confirmed successfully");
    }

    [Authorize(Roles = "student")]
    [HttpGet("history")]
    public async Task<IActionResult> History()
    {
        var payments = await db.Bills.Where(b => b.StudentId == User.Id() && b.Status == "PAID").OrderByDescending(b => b.PaidAt).ToListAsync();
        return OkResponse(new { payments = payments.Select(b => b.Dto()) }, "Payment history retrieved successfully");
    }
}
