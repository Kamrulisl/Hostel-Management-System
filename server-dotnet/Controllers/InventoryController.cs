using System.Text.Json;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize(Roles = "manager,admin")]
[Route("api/v1/inventory")]
public class InventoryController(AppDbContext db) : ApiControllerBase
{
    [HttpGet("bazar")]
    public async Task<IActionResult> Bazar(DateTime? date, int? month, int? year)
    {
        var query = db.DailyBazars.Include(b => b.CreatedBy).AsQueryable();
        if (date is not null) query = query.Where(b => b.Date == date.Value.Date);
        if (month is not null && year is not null) query = query.Where(b => b.Date.Month == month && b.Date.Year == year);
        var rows = await query.OrderByDescending(b => b.Date).ThenByDescending(b => b.CreatedAt).ToListAsync();
        return OkResponse(new { bazars = rows.Select(b => b.Dto()), total = rows.Sum(b => b.TotalAmount) }, "Bazar list retrieved successfully");
    }

    [HttpGet("bazar/defaults")]
    public async Task<IActionResult> BazarDefaults(DateTime date)
    {
        var schedules = await db.WeeklyMealSchedules.Where(s => s.DayOfWeek == (int)date.Date.DayOfWeek).ToListAsync();
        var names = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        foreach (var schedule in schedules)
        {
            AddItemHints(names, schedule.DefaultItemsJson);
            AddItemHints(names, schedule.AlternativeItemsJson);
        }
        var defaults = names.OrderBy(name => name).Select(name => new { itemName = name, quantity = "", unit = "kg", price = 0, total = 0 });
        return OkResponse(new { defaults }, "Default bazar items retrieved successfully");
    }

    [HttpPost("bazar")]
    public async Task<IActionResult> CreateBazar(JsonElement body)
    {
        var itemsJson = body.Raw("items") ?? "[]";
        var bazar = new DailyBazar
        {
            Id = Ids.New(),
            Date = body.Date("date")?.Date ?? DateTime.UtcNow.Date,
            ItemsJson = itemsJson,
            TotalAmount = body.Decimal("totalAmount") ?? SumBazarItems(itemsJson),
            Notes = body.String("notes"),
            CreatedById = User.Id()!
        };
        db.DailyBazars.Add(bazar);
        await db.SaveChangesAsync();
        return CreatedResponse(new { bazar = bazar.Dto() }, "Daily bazar added successfully");
    }

    [HttpGet("utilities")]
    public async Task<IActionResult> Utilities(int month, int year)
    {
        var rows = await db.UtilityExpenses.Where(e => e.Month == month && e.Year == year).OrderByDescending(e => e.CreatedAt).ToListAsync();
        return OkResponse(new { utilities = rows.Select(e => e.Dto()), total = rows.Sum(e => e.Amount) }, "Utility expenses retrieved successfully");
    }

    [HttpGet("students")]
    public async Task<IActionResult> Students()
    {
        var students = await db.Users
            .Where(u => u.Role == "student" && u.IsActive)
            .OrderBy(u => u.Name)
            .ToListAsync();
        return OkResponse(new { users = students.Select(u => u.Dto()) }, "Students retrieved successfully");
    }

    [HttpPost("utilities")]
    public async Task<IActionResult> CreateUtility(JsonElement body)
    {
        var utility = new UtilityExpense
        {
            Id = Ids.New(),
            Month = body.Int("month") ?? DateTime.UtcNow.Month,
            Year = body.Int("year") ?? DateTime.UtcNow.Year,
            Type = body.String("type") ?? "other",
            Amount = body.Decimal("amount") ?? 0,
            Notes = body.String("notes")
        };
        db.UtilityExpenses.Add(utility);
        await db.SaveChangesAsync();
        return CreatedResponse(new { utility = utility.Dto() }, "Utility expense added successfully");
    }

    [HttpPost("advances")]
    public async Task<IActionResult> CreateAdvance(JsonElement body)
    {
        var advance = new AdvancePayment
        {
            Id = Ids.New(),
            StudentId = body.String("studentId") ?? "",
            Date = body.Date("date")?.Date ?? DateTime.UtcNow.Date,
            Amount = body.Decimal("amount") ?? 0,
            Notes = body.String("notes"),
            ReceivedById = User.Id()!
        };
        if (!await db.Users.AnyAsync(u => u.Id == advance.StudentId && u.Role == "student")) return ErrorResponse(400, "Valid studentId is required");
        db.AdvancePayments.Add(advance);
        await db.SaveChangesAsync();
        return CreatedResponse(new { advance = advance.Dto() }, "Advance payment added successfully");
    }

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

    private static void AddItemHints(HashSet<string> names, string itemsJson)
    {
        using var doc = JsonDocument.Parse(string.IsNullOrWhiteSpace(itemsJson) ? "[]" : itemsJson);
        foreach (var item in doc.RootElement.EnumerateArray())
        {
            var name = item.TryGetProperty("name", out var nameValue) ? nameValue.GetString() : null;
            if (string.IsNullOrWhiteSpace(name)) continue;
            var matched = false;
            foreach (var hint in IngredientHints)
            {
                if (!name.Contains(hint.Key, StringComparison.OrdinalIgnoreCase)) continue;
                foreach (var ingredient in hint.Value) names.Add(ingredient);
                matched = true;
            }
            if (!matched) names.Add(name);
        }
    }

    private static readonly Dictionary<string, string[]> IngredientHints = new(StringComparer.OrdinalIgnoreCase)
    {
        ["rice"] = ["Rice"],
        ["polao"] = ["Polao rice", "Oil", "Onion", "Spices"],
        ["biriyani"] = ["Rice", "Chicken", "Potato", "Oil", "Onion", "Spices"],
        ["khichuri"] = ["Rice", "Dal", "Oil", "Onion", "Spices"],
        ["chicken"] = ["Chicken", "Oil", "Onion", "Spices"],
        ["beef"] = ["Beef", "Oil", "Onion", "Spices"],
        ["mutton"] = ["Mutton", "Oil", "Onion", "Spices"],
        ["fish"] = ["Fish", "Oil", "Onion", "Spices"],
        ["egg"] = ["Egg", "Oil", "Onion"],
        ["dal"] = ["Dal", "Oil", "Onion"],
        ["lentil"] = ["Dal", "Oil", "Onion"],
        ["vegetable"] = ["Mixed vegetables", "Oil", "Spices"],
        ["salad"] = ["Cucumber", "Tomato", "Onion"],
        ["paratha"] = ["Flour", "Oil"],
        ["ruti"] = ["Flour"],
        ["bread"] = ["Bread"],
        ["tea"] = ["Tea powder", "Milk", "Sugar"],
        ["milk"] = ["Milk"],
        ["banana"] = ["Banana"],
        ["noodles"] = ["Noodles", "Egg", "Oil"],
        ["semai"] = ["Semai", "Milk", "Sugar"],
        ["halwa"] = ["Suji", "Sugar", "Oil"],
        ["borhani"] = ["Yogurt", "Spices"],
        ["pancake"] = ["Flour", "Egg", "Milk", "Sugar"],
        ["jam"] = ["Jam"],
    };

    private static decimal SumBazarItems(string itemsJson)
    {
        using var doc = JsonDocument.Parse(string.IsNullOrWhiteSpace(itemsJson) ? "[]" : itemsJson);
        var total = 0m;
        foreach (var item in doc.RootElement.EnumerateArray())
        {
            var quantity = item.TryGetProperty("quantity", out var q) && q.TryGetDecimal(out var qv) ? qv : 0;
            var price = item.TryGetProperty("price", out var p) && p.TryGetDecimal(out var pv) ? pv : 0;
            var lineTotal = item.TryGetProperty("total", out var t) && t.TryGetDecimal(out var tv) ? tv : quantity * price;
            total += lineTotal;
        }
        return total;
    }
}
