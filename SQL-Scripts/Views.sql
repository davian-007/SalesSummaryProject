/* ================================
   VIEW (uses UDF)
================================ */
CREATE VIEW vw_SalesSummary_Source
AS
SELECT
    soh.CustomerID AS CustomerId,
    dbo.ufn_GetCustomerName(p.FirstName, p.LastName) AS CustomerName,
    CAST(soh.OrderDate AS DATE) AS SummaryDate,
    SUM(sod.OrderQty) AS Total_Items,
    SUM(sod.LineTotal) AS Total_Sales
FROM AdventureWorks_v2019.Sales.SalesOrderHeader soh
INNER JOIN AdventureWorks_v2019.Sales.SalesOrderDetail sod
    ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN AdventureWorks_v2019.Person.Person p
    ON soh.CustomerID = p.BusinessEntityID
GROUP BY
    soh.CustomerID,
    dbo.ufn_GetCustomerName(p.FirstName, p.LastName) AS CustomerName,
    CAST(soh.OrderDate AS DATE)    
GO

CREATE VIEW [dbo].[vw_SalesSummary]
AS
SELECT 
    SalesSummaryId,
    CustomerId,
    CustomerName,
    SummaryDate,
    Total_Items,
    Total_Sales,
    Source,
    CreatedAt
FROM tbSalesSummary;
GO