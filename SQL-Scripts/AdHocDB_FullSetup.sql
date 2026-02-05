/* ================================
   CREATE DATABASE
================================ */
CREATE DATABASE AdHocDB;
GO
USE AdHocDB;
GO

/* ================================
   TABLES
================================ */
CREATE TABLE tbCustomers (
    CustomerId INT PRIMARY KEY,
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Phone NVARCHAR(50),
    Email NVARCHAR(150),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE tbProduct (
    ProductId INT PRIMARY KEY,
    Name NVARCHAR(200),
    CurrentPrice DECIMAL(18,2),
    CategoryName NVARCHAR(150),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE tbSalesSummary (
    SalesSummaryId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    CustomerName NVARCHAR(200),
    SummaryDate DATE NOT NULL,
    Total_Items INT NOT NULL,
    Total_Sales DECIMAL(18,2) NOT NULL,
    Source NVARCHAR(20) CHECK (Source IN ('SYSTEM','MANUAL')),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO
CREATE TABLE tbStarWarsCharacters (
    CharacterId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,
    Height NVARCHAR(20),
    Mass NVARCHAR(20),
    HairColor NVARCHAR(50),
    SkinColor NVARCHAR(50),
    EyeColor NVARCHAR(50),
    BirthYear NVARCHAR(50),
    Gender NVARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

/* ================================
   UDF
================================ */
CREATE FUNCTION dbo.ufn_GetCustomerName
(
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100)
)
RETURNS NVARCHAR(200)
AS
BEGIN
    RETURN RTRIM(LTRIM(@FirstName)) + ' ' + RTRIM(LTRIM(@LastName));
END;
GO

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
