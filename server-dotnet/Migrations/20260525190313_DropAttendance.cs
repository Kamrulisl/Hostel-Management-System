using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HostelManagement.Api.Migrations
{
    /// <inheritdoc />
    public partial class DropAttendance : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Attendance");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Attendance",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    MarkedById = table.Column<string>(type: "text", nullable: false),
                    StudentId = table.Column<string>(type: "text", nullable: false),
                    Approved = table.Column<bool>(type: "boolean", nullable: false),
                    ApprovedAt = table.Column<DateTime>(type: "timestamp without time zone", nullable: true),
                    ApprovedById = table.Column<string>(type: "text", nullable: true),
                    CreatedAt = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    Date = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    MealType = table.Column<string>(type: "text", nullable: false),
                    Present = table.Column<bool>(type: "boolean", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp without time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Attendance", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Attendance_Users_MarkedById",
                        column: x => x.MarkedById,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Attendance_Users_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Attendance_MarkedById",
                table: "Attendance",
                column: "MarkedById");

            migrationBuilder.CreateIndex(
                name: "IX_Attendance_StudentId_Date_MealType",
                table: "Attendance",
                columns: new[] { "StudentId", "Date", "MealType" },
                unique: true);
        }
    }
}
