-- GET ALL ORDERS TYPES
CREATE OR ALTER FUNCTION GetOrderTypes()
RETURNS TABLE
AS
RETURN
(
    SELECT * 
    FROM Order_types 
);


select * from dbo.GetOrderTypes()


-- GET ORDER TYPE ID BY NAME
CREATE OR ALTER FUNCTION GetOrderTypeIdByName(
    @type NVARCHAR(50)
)
RETURNS INT
AS
BEGIN
    DECLARE @ID INT;

    IF @type IS NULL OR LTRIM(RTRIM(@type)) = ''
    BEGIN
        RETURN NULL; 
    END

    SELECT @ID = Id 
    FROM Order_types 
    WHERE [type] = @type;

    RETURN @ID;
END;




select dbo.GetOrderTypeIdByName('Wholesale')


