using Microsoft.AspNetCore.Mvc;

[ApiController]
public abstract class ApiControllerBase : ControllerBase
{
    protected IActionResult OkResponse(object? data, string message = "Success") =>
        StatusCode(200, new ApiResponse(200, data, message));

    protected IActionResult CreatedResponse(object? data, string message) =>
        StatusCode(201, new ApiResponse(201, data, message));

    protected IActionResult ErrorResponse(int statusCode, string message, object? errors = null) =>
        StatusCode(statusCode, new
        {
            statusCode,
            data = (object?)null,
            message,
            success = false,
            errors = errors ?? Array.Empty<object>()
        });
}
