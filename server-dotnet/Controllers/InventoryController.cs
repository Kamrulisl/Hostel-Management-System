using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize(Roles = "manager,admin")]
[Route("api/v1/inventory")]
public class InventoryController(AppDbContext db) : ApiControllerBase
{
    [HttpGet]
    public async Task<IActionResult> All(string? category, string? status, string? search)
    {
        var query = db.Inventory.AsQueryable();
        if (!string.IsNullOrEmpty(category)) query = query.Where(i => i.Category == category);
        if (!string.IsNullOrEmpty(status)) query = query.Where(i => i.Status == status);
        if (!string.IsNullOrEmpty(search)) query = query.Where(i => i.ItemName.ToLower().Contains(search.ToLower()));
        var items = await query.OrderByDescending(i => i.CreatedAt).ToListAsync();
        return OkResponse(new { items = items.Select(i => i.Dto()) });
    }

    [HttpGet("stats")]
    public async Task<IActionResult> Stats()
    {
        var items = await db.Inventory.ToListAsync();
        return OkResponse(new
        {
            totalItems = items.Count,
            lowStockItems = items.Count(i => i.Status == "low-stock"),
            outOfStockItems = items.Count(i => i.Status == "out-of-stock"),
            inStockItems = items.Count(i => i.Status == "in-stock"),
            categoryStats = items.GroupBy(i => i.Category).Select(g => new { _id = g.Key, count = g.Count(), totalValue = g.Sum(i => i.Quantity * i.Price) }),
            totalInventoryValue = items.Sum(i => i.Quantity * i.Price)
        });
    }

    [HttpGet("low-stock")]
    public async Task<IActionResult> LowStock()
    {
        var items = await db.Inventory.Where(i => i.Status == "low-stock" || i.Status == "out-of-stock").OrderBy(i => i.Quantity).ToListAsync();
        return OkResponse(new { items = items.Select(i => i.Dto()), count = items.Count });
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> Get(string id)
    {
        var item = await db.Inventory.FindAsync(id);
        return item is null ? ErrorResponse(404, "Inventory item not found") : OkResponse(new { item = item.Dto() });
    }

    [HttpPost]
    public async Task<IActionResult> Create(JsonElement body)
    {
        var item = new InventoryItem { Id = Ids.New() };
        Apply(item, body);
        db.Inventory.Add(item);
        await db.SaveChangesAsync();
        return CreatedResponse(new { item = item.Dto() }, "Inventory item created successfully");
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> Update(string id, JsonElement body)
    {
        var item = await db.Inventory.FindAsync(id);
        if (item is null) return ErrorResponse(404, "Inventory item not found");
        Apply(item, body);
        await db.SaveChangesAsync();
        return OkResponse(new { item = item.Dto() }, "Inventory item updated successfully");
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(string id)
    {
        var item = await db.Inventory.FindAsync(id);
        if (item is null) return ErrorResponse(404, "Inventory item not found");
        db.Inventory.Remove(item);
        await db.SaveChangesAsync();
        return OkResponse(null, "Inventory item deleted successfully");
    }

    [HttpPatch("{id}/restock")]
    public async Task<IActionResult> Restock(string id, JsonElement body)
    {
        var item = await db.Inventory.FindAsync(id);
        if (item is null) return ErrorResponse(404, "Inventory item not found");
        item.Quantity += body.Decimal("quantity") ?? 0;
        item.LastRestocked = DateTime.UtcNow;
        item.RecalculateStatus();
        await db.SaveChangesAsync();
        return OkResponse(new { item = item.Dto() }, "Inventory item restocked successfully");
    }

    private static void Apply(InventoryItem item, JsonElement body)
    {
        item.ItemName = body.String("itemName") ?? item.ItemName;
        item.Category = body.String("category") ?? item.Category;
        item.Quantity = body.Decimal("quantity") ?? item.Quantity;
        item.Unit = body.String("unit") ?? item.Unit;
        item.MinThreshold = body.Decimal("minThreshold") ?? item.MinThreshold;
        item.Price = body.Decimal("price") ?? item.Price;
        item.Supplier = body.String("supplier") ?? item.Supplier;
        item.ExpiryDate = body.Date("expiryDate") ?? item.ExpiryDate;
        item.Notes = body.String("notes") ?? item.Notes;
        item.RecalculateStatus();
        item.UpdatedAt = DateTime.UtcNow;
    }
}
