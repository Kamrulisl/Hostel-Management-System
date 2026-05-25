public interface IMealFlags
{
    bool Breakfast { get; set; }
    bool Lunch { get; set; }
    bool Dinner { get; set; }
}

public class BaseEntity
{
    public string Id { get; set; } = Ids.New();
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
}

public class User : BaseEntity
{
    public string Name { get; set; } = "";
    public string Email { get; set; } = "";
    public string PasswordHash { get; set; } = "";
    public string Role { get; set; } = "student";
    public string? RollNumber { get; set; }
    public string? RoomNumber { get; set; }
    public string? Phone { get; set; }
    public bool IsActive { get; set; } = true;

    public object AuthDto() => new { _id = Id, id = Id, name = Name, email = Email, role = Role, rollNumber = RollNumber, roomNumber = RoomNumber };
    public object Dto() => new { _id = Id, id = Id, name = Name, email = Email, role = Role, rollNumber = RollNumber, roomNumber = RoomNumber, phone = Phone, isActive = IsActive, createdAt = CreatedAt, updatedAt = UpdatedAt };
    public object Mini() => new { _id = Id, id = Id, name = Name, email = Email, role = Role, rollNumber = RollNumber, roomNumber = RoomNumber };
}

public class Menu : BaseEntity
{
    public DateTime Date { get; set; }
    public string MealType { get; set; } = "";
    public string ItemsJson { get; set; } = "[]";
    public string ImageUrl { get; set; } = "";
    public string CreatedById { get; set; } = "";
    public User? CreatedBy { get; set; }
    public object Dto() => new { _id = Id, id = Id, date = Date, mealType = MealType, items = Json.Parse(ItemsJson), imageUrl = ImageUrl, createdBy = CreatedBy?.Mini() ?? CreatedById, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class MealPlan : BaseEntity, IMealFlags
{
    public string StudentId { get; set; } = "";
    public User? Student { get; set; }
    public DateTime Date { get; set; }
    public bool Breakfast { get; set; }
    public bool Lunch { get; set; }
    public bool Dinner { get; set; }
    public object Dto() => new { _id = Id, id = Id, student = Student?.Mini() ?? StudentId, date = Date, meals = new { breakfast = Breakfast, lunch = Lunch, dinner = Dinner }, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class MealSelection : BaseEntity, IMealFlags
{
    public string StudentId { get; set; } = "";
    public User? Student { get; set; }
    public DateTime Date { get; set; }
    public bool Breakfast { get; set; }
    public bool Lunch { get; set; }
    public bool Dinner { get; set; }
    public string BreakfastChoice { get; set; } = "default";
    public string LunchChoice { get; set; } = "default";
    public string DinnerChoice { get; set; } = "default";
    public string BreakfastStatus { get; set; } = "approved";
    public string LunchStatus { get; set; } = "approved";
    public string DinnerStatus { get; set; } = "approved";
    public string BreakfastItemsJson { get; set; } = "[]";
    public string LunchItemsJson { get; set; } = "[]";
    public string DinnerItemsJson { get; set; } = "[]";
    public string? Note { get; set; }
    public string? ApprovedById { get; set; }
    public DateTime? ApprovedAt { get; set; }
    public object Dto() => new
    {
        _id = Id,
        id = Id,
        student = Student?.Mini() ?? StudentId,
        date = Date,
        meals = new { breakfast = Breakfast, lunch = Lunch, dinner = Dinner },
        choices = new
        {
            breakfast = new { choice = BreakfastChoice, status = BreakfastStatus, items = Json.Parse(BreakfastItemsJson) },
            lunch = new { choice = LunchChoice, status = LunchStatus, items = Json.Parse(LunchItemsJson) },
            dinner = new { choice = DinnerChoice, status = DinnerStatus, items = Json.Parse(DinnerItemsJson) }
        },
        note = Note,
        approvedBy = ApprovedById,
        approvedAt = ApprovedAt,
        createdAt = CreatedAt,
        updatedAt = UpdatedAt
    };
}

public class WeeklyMealSchedule : BaseEntity
{
    public int DayOfWeek { get; set; }
    public string MealType { get; set; } = "";
    public string DefaultItemsJson { get; set; } = "[]";
    public string AlternativeItemsJson { get; set; } = "[]";
    public bool IsActive { get; set; } = true;
    public string? UpdatedById { get; set; }
    public object Dto() => new
    {
        _id = Id,
        id = Id,
        dayOfWeek = DayOfWeek,
        dayName = Enum.GetName(typeof(DayOfWeek), DayOfWeek),
        mealType = MealType,
        defaultItems = Json.Parse(DefaultItemsJson),
        alternativeItems = Json.Parse(AlternativeItemsJson),
        isActive = IsActive,
        updatedBy = UpdatedById,
        createdAt = CreatedAt,
        updatedAt = UpdatedAt
    };
}

public class StudentHolidayMode : BaseEntity
{
    public string StudentId { get; set; } = "";
    public User? Student { get; set; }
    public bool IsEnabled { get; set; }
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public string? Reason { get; set; }
    public object Dto() => new
    {
        _id = Id,
        id = Id,
        student = Student?.Mini() ?? StudentId,
        isEnabled = IsEnabled,
        startDate = StartDate,
        endDate = EndDate,
        reason = Reason,
        createdAt = CreatedAt,
        updatedAt = UpdatedAt
    };
}

public class Attendance : BaseEntity
{
    public string StudentId { get; set; } = "";
    public User? Student { get; set; }
    public DateTime Date { get; set; }
    public string MealType { get; set; } = "";
    public bool Present { get; set; }
    public bool Approved { get; set; }
    public string? ApprovedById { get; set; }
    public DateTime? ApprovedAt { get; set; }
    public string MarkedById { get; set; } = "";
    public User? MarkedBy { get; set; }
    public object Dto() => new { _id = Id, id = Id, student = Student?.Mini() ?? StudentId, date = Date, mealType = MealType, present = Present, approved = Approved, approvedBy = ApprovedById, approvedAt = ApprovedAt, markedBy = MarkedBy?.Mini() ?? MarkedById, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class Complaint : BaseEntity
{
    public string StudentId { get; set; } = "";
    public User? Student { get; set; }
    public string Category { get; set; } = "";
    public string Title { get; set; } = "";
    public string Description { get; set; } = "";
    public string Status { get; set; } = "pending";
    public string Priority { get; set; } = "medium";
    public string? ResolvedById { get; set; }
    public User? ResolvedBy { get; set; }
    public DateTime? ResolvedAt { get; set; }
    public string? AdminNotes { get; set; }
    public object Dto() => new { _id = Id, id = Id, student = Student?.Mini() ?? StudentId, category = Category, title = Title, description = Description, status = Status, priority = Priority, resolvedBy = ResolvedBy?.Mini() ?? (object?)ResolvedById, resolvedAt = ResolvedAt, adminNotes = AdminNotes, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class Notice : BaseEntity
{
    public string Title { get; set; } = "";
    public string Content { get; set; } = "";
    public string Category { get; set; } = "general";
    public bool IsPinned { get; set; }
    public string TargetAudience { get; set; } = "all";
    public string CreatedById { get; set; } = "";
    public User? CreatedBy { get; set; }
    public DateTime? ExpiresAt { get; set; }
    public object Dto() => new { _id = Id, id = Id, title = Title, content = Content, category = Category, isPinned = IsPinned, targetAudience = TargetAudience, createdBy = CreatedBy?.Mini() ?? CreatedById, expiresAt = ExpiresAt, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class Feedback : BaseEntity
{
    public string StudentId { get; set; } = "";
    public User? Student { get; set; }
    public DateTime Date { get; set; }
    public string MealType { get; set; } = "";
    public int Rating { get; set; }
    public string? Comment { get; set; }
    public object Dto() => new { _id = Id, id = Id, student = Student?.Mini() ?? StudentId, date = Date, mealType = MealType, rating = Rating, comment = Comment, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class Settings : BaseEntity
{
    public decimal BreakfastPrice { get; set; } = 30;
    public decimal LunchPrice { get; set; } = 50;
    public decimal DinnerPrice { get; set; } = 40;
    public string CutoffTime { get; set; } = "20:00";
    public int CutoffDaysBefore { get; set; } = 1;
    public decimal ExtraCharges { get; set; }
    public decimal DiscountPercentage { get; set; }
    public decimal TaxPercentage { get; set; }
    public List<Holiday> Holidays { get; set; } = [];
    public string MessName { get; set; } = "Hostel Mess";
    public string MessAddress { get; set; } = "";
    public string ContactEmail { get; set; } = "";
    public string ContactPhone { get; set; } = "";
    public bool EnableEmailNotifications { get; set; }
    public bool EnableSmsNotifications { get; set; }
    public string? UpdatedById { get; set; }
    public object Dto() => new { _id = Id, id = Id, breakfastPrice = BreakfastPrice, lunchPrice = LunchPrice, dinnerPrice = DinnerPrice, cutoffTime = CutoffTime, cutoffDaysBefore = CutoffDaysBefore, extraCharges = ExtraCharges, discountPercentage = DiscountPercentage, taxPercentage = TaxPercentage, holidays = Holidays.Select(h => h.Dto()), messName = MessName, messAddress = MessAddress, contactEmail = ContactEmail, contactPhone = ContactPhone, enableEmailNotifications = EnableEmailNotifications, enableSMSNotifications = EnableSmsNotifications, updatedBy = UpdatedById, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class Holiday
{
    public string Id { get; set; } = Ids.New();
    public DateTime Date { get; set; }
    public string Reason { get; set; } = "";
    public string SettingsId { get; set; } = "";
    public object Dto() => new { _id = Id, id = Id, date = Date, reason = Reason };
}

public class InventoryItem : BaseEntity
{
    public string ItemName { get; set; } = "";
    public string Category { get; set; } = "other";
    public decimal Quantity { get; set; }
    public string Unit { get; set; } = "kg";
    public decimal MinThreshold { get; set; }
    public decimal Price { get; set; }
    public string? Supplier { get; set; }
    public DateTime LastRestocked { get; set; } = DateTime.UtcNow;
    public DateTime? ExpiryDate { get; set; }
    public string Status { get; set; } = "in-stock";
    public string? Notes { get; set; }
    public void RecalculateStatus() => Status = Quantity == 0 ? "out-of-stock" : Quantity <= MinThreshold ? "low-stock" : "in-stock";
    public object Dto() => new { _id = Id, id = Id, itemName = ItemName, category = Category, quantity = Quantity, unit = Unit, minThreshold = MinThreshold, price = Price, supplier = Supplier, lastRestocked = LastRestocked, expiryDate = ExpiryDate, status = Status, notes = Notes, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class DailyBazar : BaseEntity
{
    public DateTime Date { get; set; }
    public string ItemsJson { get; set; } = "[]";
    public decimal TotalAmount { get; set; }
    public string CreatedById { get; set; } = "";
    public User? CreatedBy { get; set; }
    public string? Notes { get; set; }
    public object Dto() => new { _id = Id, id = Id, date = Date, items = Json.Parse(ItemsJson), totalAmount = TotalAmount, createdBy = CreatedBy?.Mini() ?? CreatedById, notes = Notes, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class UtilityExpense : BaseEntity
{
    public int Month { get; set; }
    public int Year { get; set; }
    public string Type { get; set; } = "";
    public decimal Amount { get; set; }
    public string? Notes { get; set; }
    public object Dto() => new { _id = Id, id = Id, month = Month, year = Year, type = Type, amount = Amount, notes = Notes, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class AdvancePayment : BaseEntity
{
    public string StudentId { get; set; } = "";
    public User? Student { get; set; }
    public DateTime Date { get; set; }
    public decimal Amount { get; set; }
    public string ReceivedById { get; set; } = "";
    public string? Notes { get; set; }
    public object Dto() => new { _id = Id, id = Id, student = Student?.Mini() ?? StudentId, date = Date, amount = Amount, receivedBy = ReceivedById, notes = Notes, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class Bill : BaseEntity
{
    public string StudentId { get; set; } = "";
    public User? Student { get; set; }
    public int Month { get; set; }
    public int Year { get; set; }
    public int TotalMeals { get; set; }
    public decimal MealCost { get; set; }
    public decimal FixedCost { get; set; } = 2000;
    public decimal UtilityCost { get; set; }
    public decimal AdvancePaid { get; set; }
    public decimal PreviousDue { get; set; }
    public decimal MealRate { get; set; }
    public decimal TotalAmount { get; set; }
    public string Status { get; set; } = "DUE";
    public DateTime? PaidAt { get; set; }
    public string? PaymentMethod { get; set; }
    public string? TransactionId { get; set; }
    public int BreakfastCount { get; set; }
    public decimal BreakfastRate { get; set; }
    public int LunchCount { get; set; }
    public decimal LunchRate { get; set; }
    public int DinnerCount { get; set; }
    public decimal DinnerRate { get; set; }
    public string? GeneratedById { get; set; }
    public object Dto() => new { _id = Id, id = Id, student = Student?.Mini() ?? StudentId, month = Month, year = Year, totalMeals = TotalMeals, mealCost = MealCost, fixedCost = FixedCost, utilityCost = UtilityCost, advancePaid = AdvancePaid, previousDue = PreviousDue, mealRate = MealRate, totalAmount = TotalAmount, status = Status, paidAt = PaidAt, paymentMethod = PaymentMethod, transactionId = TransactionId, breakdown = new { breakfast = new { count = BreakfastCount, rate = BreakfastRate, total = BreakfastCount * BreakfastRate }, lunch = new { count = LunchCount, rate = LunchRate, total = LunchCount * LunchRate }, dinner = new { count = DinnerCount, rate = DinnerRate, total = DinnerCount * DinnerRate } }, generatedBy = GeneratedById, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class Message : BaseEntity
{
    public string SenderId { get; set; } = "";
    public User? Sender { get; set; }
    public string ReceiverId { get; set; } = "";
    public User? Receiver { get; set; }
    public string Text { get; set; } = "";
    public bool Read { get; set; }
    public DateTime? ReadAt { get; set; }
    public object Dto() => new { _id = Id, id = Id, sender = Sender?.Mini() ?? SenderId, receiver = Receiver?.Mini() ?? ReceiverId, message = Text, read = Read, readAt = ReadAt, createdAt = CreatedAt, updatedAt = UpdatedAt };
}

public class AuditLog : BaseEntity
{
    public string? ActorId { get; set; }
    public string? ActorRole { get; set; }
    public string Action { get; set; } = "";
    public string EntityType { get; set; } = "";
    public string? EntityId { get; set; }
    public string? Description { get; set; }
    public string MetadataJson { get; set; } = "{}";
    public object Dto() => new { _id = Id, id = Id, actorId = ActorId, actorRole = ActorRole, action = Action, entityType = EntityType, entityId = EntityId, description = Description, metadata = Json.Parse(MetadataJson), createdAt = CreatedAt, updatedAt = UpdatedAt };
}
