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