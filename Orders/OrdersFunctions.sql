-- GET ORDER DETAILS
CREATE OR ALTER FUNCTION GetSalesInfoByOrderId
(
    @Order_Id INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        s.Id AS Seedling_Id,
        s.Seedling_name,
        od.Count,
        od.Piece_price AS Sale_Price,
        o.sale_date AS Sale_Date,
        od.Total_price AS Total_Sale_Price
    FROM 
        Order_deatils od
    INNER JOIN 
        Orders o ON od.Order_Id = o.Id
    INNER JOIN 
        Seedlings s ON od.Seedling_Id = s.Id
    WHERE 
        o.Id = @Order_Id
);

SELECT *
FROM GetSalesInfoByOrderId( 1);


-- GET ALL ORDERS DETAILS
CREATE OR ALTER FUNCTION GetSalesInfo
()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        s.Id AS Seedling_Id,
		s.Parcode_name,
        s.Seedling_name,
        od.Count,
        od.Piece_price AS Sale_Price,
        o.sale_date AS Sale_Date,
        od.Total_price AS Total_Sale_Price
    FROM 
        Order_deatils od
    INNER JOIN 
        Orders o ON od.Order_Id = o.Id
    INNER JOIN 
        Seedlings s ON od.Seedling_Id = s.Id
);

SELECT *
FROM GetSalesInfo();


