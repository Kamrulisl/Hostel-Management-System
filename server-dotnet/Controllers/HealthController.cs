using Microsoft.AspNetCore.Mvc;

[Route("")]
public class HealthController : ApiControllerBase
{
    [HttpGet("health")]
    public IActionResult Health() => OkResponse(new { status = "OK", message = "Server is running" });
}
