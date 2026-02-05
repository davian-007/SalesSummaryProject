using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SalesSummaryApi.Data;
using SalesSummaryApi.Models;

namespace SalesSummaryApi.Controllers
{
    [ApiController]
    [Route("api")]
    public class SalesSummaryController : ControllerBase
    {
        private readonly AppDbContext _context;

        public SalesSummaryController(AppDbContext context)
        {
            _context = context;
        }

        // GET /api/sales_summary?idCustomer=1
        [HttpGet("sales_summary")]
        public async Task<IActionResult> GetByCustomer([FromQuery] int idCustomer)
        {
            if (idCustomer <= 0)
                return BadRequest("CustomerId must be greater than zero.");

            var data = await _context.SalesSummaries
                .Where(x => x.CustomerId == idCustomer)
                .ToListAsync();

            return Ok(data);
        }

        // POST /api/manual_summary_entry
        [HttpPost("manual_summary_entry")]
        public async Task<IActionResult> InsertManual([FromBody] ManualSalesSummaryDto dto)
        {
            if (dto == null)
                return BadRequest("Payload is required.");

            if (dto.CustomerId <= 0)
                return BadRequest("CustomerId is required.");

            if (string.IsNullOrWhiteSpace(dto.CustomerName))
                return BadRequest("CustomerName is required.");

            if (dto.Total_Items < 0 || dto.Total_Sales < 0)
                return BadRequest("Totals must be non-negative.");

            if (dto.SummaryDate == DateTime.MinValue)
                return BadRequest("Invalid date.");

            var entity = new SalesSummary
            {
                CustomerId = dto.CustomerId,
                CustomerName = dto.CustomerName,
                SummaryDate = dto.SummaryDate.Date,
                Total_Items = dto.Total_Items,
                Total_Sales = dto.Total_Sales,
                Source = "MANUAL",
                CreatedAt = DateTime.Now
            };

            try
            {
                _context.SalesSummaries.Add(entity);
                await _context.SaveChangesAsync();
                return Ok(entity);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
