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