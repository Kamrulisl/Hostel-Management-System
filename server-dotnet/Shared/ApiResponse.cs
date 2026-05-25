public record ApiResponse(int StatusCode, object? Data, string Message = "Success")
{
    public bool Success => StatusCode < 400;
}
