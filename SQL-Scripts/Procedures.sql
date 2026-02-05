/* ================================
   STORED PROCEDURE
================================ */
CREATE PROCEDURE sp_LoadSalesSummary
AS
BEGIN
    INSERT INTO tbSalesSummary
    (
        CustomerId,
        CustomerName,
        SummaryDate,
        Total_Items,
        Total_Sales,
        Source
    )
    SELECT
        v.CustomerId,
        v.CustomerName,
        v.SummaryDate,
        v.Total_Items,
        v.Total_Sales,
        'SYSTEM'
    FROM vw_SalesSummary_Source v
    WHERE NOT EXISTS
    (
        SELECT 1
        FROM tbSalesSummary t
        WHERE t.CustomerId = v.CustomerId
          AND t.SummaryDate = v.SummaryDate
          AND t.Source = 'SYSTEM'
    );
END;
GO
