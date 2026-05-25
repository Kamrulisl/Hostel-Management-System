using System.Security.Claims;
using System.Security.Cryptography;
using System.Globalization;
using System.Text.Json;

public static class Json
{
    public static object? Parse(string json) => JsonSerializer.Deserialize<object>(json);
}

public static class JsonExtensions
{
    public static string? String(this JsonElement element, string name) =>
        element.TryGetProperty(name, out var value) && value.ValueKind != JsonValueKind.Null ? value.GetString() : null;

    public static string? Raw(this JsonElement element, string name) =>
        element.TryGetProperty(name, out var value) ? value.GetRawText() : null;

    public static bool? Bool(this JsonElement element, string name) =>
        element.TryGetProperty(name, out var value) && (value.ValueKind == JsonValueKind.True || value.ValueKind == JsonValueKind.False)
            ? value.GetBoolean()
            : null;

    public static int? Int(this JsonElement element, string name) =>
        element.TryGetProperty(name, out var value) && value.TryGetInt32(out var result) ? result : null;

    public static decimal? Decimal(this JsonElement element, string name) =>
        element.TryGetProperty(name, out var value) && value.TryGetDecimal(out var result) ? result : null;

    public static DateTime? Date(this JsonElement element, string name)
    {
        if (!element.TryGetProperty(name, out var value) || value.ValueKind != JsonValueKind.String)
            return null;

        var text = value.GetString();
        if (string.IsNullOrWhiteSpace(text)) return null;
        if (DateTime.TryParseExact(text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out var dateOnly))
            return dateOnly;
        return DateTime.TryParse(text, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out var result)
            ? result
            : null;
    }
}

public static class ClaimsExtensions
{
    public static string? Id(this ClaimsPrincipal principal) =>
        principal.FindFirstValue("id") ?? principal.FindFirstValue(ClaimTypes.NameIdentifier);
}

public static class Ids
{
    public static string New()
    {
        Span<byte> bytes = stackalloc byte[12];
        RandomNumberGenerator.Fill(bytes);
        return Convert.ToHexString(bytes).ToLowerInvariant();
    }
}

public static class CsvWriter
{
    public static string Csv(params string?[] values) =>
        string.Join(",", values.Select(v => $"\"{(v ?? "").Replace("\"", "\"\"")}\""));
}
