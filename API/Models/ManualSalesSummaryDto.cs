using System;

namespace SalesSummaryApi.Models
{
    public class ManualSalesSummaryDto
    {
        public int CustomerId { get; set; }
        public string CustomerName { get; set; }
        public DateTime SummaryDate { get; set; }
        public int Total_Items { get; set; }
        public decimal Total_Sales { get; set; }
    }
}
