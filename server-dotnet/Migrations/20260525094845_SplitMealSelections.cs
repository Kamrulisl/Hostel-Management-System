using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HostelManagement.Api.Migrations
{
    /// <inheritdoc />
    public partial class SplitMealSelections : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "MealSelections",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    StudentId = table.Column<string>(type: "text", nullable: false),
                    Date = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    Breakfast = table.Column<bool>(type: "boolean", nullable: false),
                    Lunch = table.Column<bool>(type: "boolean", nullable: false),
                    Dinner = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp without time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MealSelections", x => x.Id);
                    table.ForeignKey(
                        name: "FK_MealSelections_Users_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_MealSelections_StudentId_Date",
                table: "MealSelections",
                columns: new[] { "StudentId", "Date" },
                unique: true);

            migrationBuilder.Sql("""
                INSERT INTO "MealSelections" ("Id", "StudentId", "Date", "Breakfast", "Lunch", "Dinner", "CreatedAt", "UpdatedAt")
                SELECT "Id", "StudentId", "Date", "Breakfast", "Lunch", "Dinner", "CreatedAt", "UpdatedAt"
                FROM "MealPlans"
                WHERE "Discriminator" = 'MealSelection'
                ON CONFLICT ("StudentId", "Date") DO NOTHING;

                DELETE FROM "MealPlans"
                WHERE "Discriminator" = 'MealSelection';
                """);

            migrationBuilder.DropColumn(
                name: "Discriminator",
                table: "MealPlans");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MealSelections");

            migrationBuilder.AddColumn<string>(
                name: "Discriminator",
                table: "MealPlans",
                type: "character varying(13)",
                maxLength: 13,
                nullable: false,
                defaultValue: "");
        }
    }
}
