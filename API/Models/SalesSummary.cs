using System;

namespace SalesSummaryApi.Models
{
    public class SalesSummary
    {
        public int SalesSummaryId { get; set; }
        public int CustomerId { get; set; }
        public string CustomerName { get; set; }
        public DateTime SummaryDate { get; set; }
        public int Total_Items { get; set; }
        public decimal Total_Sales { get; set; }
        public string Source { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
