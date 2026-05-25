using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HostelManagement.Api.Migrations
{
    /// <inheritdoc />
    public partial class WeeklyMealWorkflow : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "ApprovedAt",
                table: "MealSelections",
                type: "timestamp without time zone",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ApprovedById",
                table: "MealSelections",
                type: "text",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "BreakfastChoice",
                table: "MealSelections",
                type: "text",
                nullable: false,
                defaultValue: "default");

            migrationBuilder.AddColumn<string>(
                name: "BreakfastItemsJson",
                table: "MealSelections",
                type: "text",
                nullable: false,
                defaultValue: "[]");

            migrationBuilder.AddColumn<string>(
                name: "BreakfastStatus",
                table: "MealSelections",
                type: "text",
                nullable: false,
                defaultValue: "approved");

            migrationBuilder.AddColumn<string>(
                name: "DinnerChoice",
                table: "MealSelections",
                type: "text",
                nullable: false,
                defaultValue: "default");

            migrationBuilder.AddColumn<string>(
                name: "DinnerItemsJson",
                table: "MealSelections",
                type: "text",
                nullable: false,
                defaultValue: "[]");

            migrationBuilder.AddColumn<string>(
                name: "DinnerStatus",
                table: "MealSelections",
                type: "text",
                nullable: false,
                defaultValue: "approved");

            migrationBuilder.AddColumn<string>(
                name: "LunchChoice",
                table: "MealSelections",
                type: "text",
                nullable: false,
                defaultValue: "default");

            migrationBuilder.AddColumn<string>(
                name: "LunchItemsJson",
                table: "MealSelections",
                type: "text",
                nullable: false,
                defaultValue: "[]");

            migrationBuilder.AddColumn<string>(
                name: "LunchStatus",
                table: "MealSelections",
                type: "text",
                nullable: false,
                defaultValue: "approved");

            migrationBuilder.AddColumn<string>(
                name: "Note",
                table: "MealSelections",
                type: "text",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "StudentHolidayModes",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    StudentId = table.Column<string>(type: "text", nullable: false),
                    IsEnabled = table.Column<bool>(type: "boolean", nullable: false),
                    StartDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    EndDate = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    Reason = table.Column<string>(type: "text", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp without time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StudentHolidayModes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StudentHolidayModes_Users_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "WeeklyMealSchedules",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    DayOfWeek = table.Column<int>(type: "integer", nullable: false),
                    MealType = table.Column<string>(type: "text", nullable: false),
                    DefaultItemsJson = table.Column<string>(type: "text", nullable: false),
                    AlternativeItemsJson = table.Column<string>(type: "text", nullable: false),
                    IsActive = table.Column<bool>(type: "boolean", nullable: false),
                    UpdatedById = table.Column<string>(type: "text", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp without time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_WeeklyMealSchedules", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_StudentHolidayModes_StudentId",
                table: "StudentHolidayModes",
                column: "StudentId",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_WeeklyMealSchedules_DayOfWeek_MealType",
                table: "WeeklyMealSchedules",
                columns: new[] { "DayOfWeek", "MealType" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "StudentHolidayModes");

            migrationBuilder.DropTable(
                name: "WeeklyMealSchedules");

            migrationBuilder.DropColumn(
                name: "ApprovedAt",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "ApprovedById",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "BreakfastChoice",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "BreakfastItemsJson",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "BreakfastStatus",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "DinnerChoice",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "DinnerItemsJson",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "DinnerStatus",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "LunchChoice",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "LunchItemsJson",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "LunchStatus",
                table: "MealSelections");

            migrationBuilder.DropColumn(
                name: "Note",
                table: "MealSelections");
        }
    }
}
