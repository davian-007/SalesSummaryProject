using Microsoft.EntityFrameworkCore;
using SalesSummaryApi.Models;

namespace SalesSummaryApi.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<SalesSummary> SalesSummaries { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<SalesSummary>()
                .ToTable("tbSalesSummary")
                .HasKey(x => x.SalesSummaryId);
        }
    }
}
