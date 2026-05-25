using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace HostelManagement.Api.Migrations
{
    /// <inheritdoc />
    public partial class MultipleHolidayRanges : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_StudentHolidayModes_StudentId",
                table: "StudentHolidayModes");

            migrationBuilder.CreateIndex(
                name: "IX_StudentHolidayModes_StudentId",
                table: "StudentHolidayModes",
                column: "StudentId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_StudentHolidayModes_StudentId",
                table: "StudentHolidayModes");

            migrationBuilder.CreateIndex(
                name: "IX_StudentHolidayModes_StudentId",
                table: "StudentHolidayModes",
                column: "StudentId",
                unique: true);
        }
    }
}
