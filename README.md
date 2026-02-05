# Sales Summary Integration Project

Technical project implementing ETL, reporting and API consumption using SQL Server technologies.

## 📌 Description
This project extracts data from AdventureWorks OLTP and loads summarized data into a destination database using SSIS.  
It also provides reporting through SSRS and exposes the data via a .NET REST API.

## 🧰 Technologies
- SQL Server 2019
- SSIS (SQL Server Integration Services)
- SSRS (SQL Server Reporting Services)
- .NET 6 Web API
- Entity Framework Core
- Swagger

## 🗄️ Database Objects
Destination database includes:
- Tables:  
  - tbCustomers  
  - tbProduct  
  - tbSalesSummary  
- Views  
- Stored Procedures  
- User Defined Function (UDF)

These objects are actively used by SSIS packages, SSRS report and API queries.

## 🔄 SSIS Packages
- **Package A:** Load customers data
- **Package B:** Load products data
- **Package C:** Load sales summary data

Packages are designed to be re-runnable without duplicating data.

## 📊 SSRS Report
Report based on tbSalesSummary (or view):
- Parameters:
  - InitialDate
  - FinalDate
- Filters data by selected date range.

## 🌐 REST API
Endpoints:
- **GET /api/sales_summary?idCustomer=**
  - Returns summary records for a given customer.
- **POST /api/manual_summary_entry**
  - Inserts manual records into tbSalesSummary with:
    - Source = 'MANUAL'
  - Includes:
    - Required field validation
    - Non-negative values validation
    - Date validation
    - Error handling (400 / 500)

## ▶️ How to Run
1. Restore AdventureWorks database.
2. Create destination database and objects.
3. Execute SSIS Packages A, B and C.
4. Run SSRS report with date parameters.
5. Run API project and test endpoints via Swagger.

## 📸 Evidence
Screenshots included:
- AdventureWorks restored
- Destination database structure
- SSIS package execution (including re-run)
- Data loaded into tables
- SSRS report execution
- API GET and POST tests

## 📁 Repository Structure
