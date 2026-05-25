using Microsoft.EntityFrameworkCore;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<User> Users => Set<User>();
    public DbSet<Menu> Menus => Set<Menu>();
    public DbSet<MealPlan> MealPlans => Set<MealPlan>();
    public DbSet<MealSelection> MealSelections => Set<MealSelection>();
    public DbSet<WeeklyMealSchedule> WeeklyMealSchedules => Set<WeeklyMealSchedule>();
    public DbSet<StudentHolidayMode> StudentHolidayModes => Set<StudentHolidayMode>();
    public DbSet<Attendance> Attendance => Set<Attendance>();
    public DbSet<Complaint> Complaints => Set<Complaint>();
    public DbSet<Notice> Notices => Set<Notice>();
    public DbSet<Feedback> Feedback => Set<Feedback>();
    public DbSet<Settings> Settings => Set<Settings>();
    public DbSet<Holiday> Holidays => Set<Holiday>();
    public DbSet<InventoryItem> Inventory => Set<InventoryItem>();
    public DbSet<DailyBazar> DailyBazars => Set<DailyBazar>();
    public DbSet<UtilityExpense> UtilityExpenses => Set<UtilityExpense>();
    public DbSet<AdvancePayment> AdvancePayments => Set<AdvancePayment>();
    public DbSet<Bill> Bills => Set<Bill>();
    public DbSet<Message> Messages => Set<Message>();
    public DbSet<AuditLog> AuditLogs => Set<AuditLog>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>().HasIndex(u => u.Email).IsUnique();
        modelBuilder.Entity<User>().HasIndex(u => u.RollNumber).IsUnique();
        modelBuilder.Entity<Menu>().HasIndex(m => new { m.Date, m.MealType }).IsUnique();
        modelBuilder.Entity<MealPlan>().HasIndex(m => new { m.StudentId, m.Date }).IsUnique();
        modelBuilder.Entity<MealSelection>().HasIndex(m => new { m.StudentId, m.Date }).IsUnique();
        modelBuilder.Entity<WeeklyMealSchedule>().HasIndex(m => new { m.DayOfWeek, m.MealType }).IsUnique();
        modelBuilder.Entity<StudentHolidayMode>().HasIndex(h => h.StudentId);
        modelBuilder.Entity<Attendance>().HasIndex(a => new { a.StudentId, a.Date, a.MealType }).IsUnique();
        modelBuilder.Entity<Feedback>().HasIndex(f => new { f.StudentId, f.Date, f.MealType }).IsUnique();
        modelBuilder.Entity<Bill>().HasIndex(b => new { b.StudentId, b.Month, b.Year }).IsUnique();
        modelBuilder.Entity<UtilityExpense>().HasIndex(e => new { e.Year, e.Month, e.Type });
        modelBuilder.Entity<AdvancePayment>().HasIndex(p => new { p.StudentId, p.Date });

        foreach (var entity in modelBuilder.Model.GetEntityTypes())
        {
            foreach (var property in entity.GetProperties().Where(p => p.ClrType == typeof(DateTime) || p.ClrType == typeof(DateTime?)))
                property.SetColumnType("timestamp without time zone");
        }
    }
}
