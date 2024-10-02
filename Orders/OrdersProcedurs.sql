
-- INSERT PROCEDURE
CREATE OR ALTER PROCEDURE InsertPurchaseInvoice
    @Order_type_Id INT,
    @sale_date DATETIME,
    @Seedling_Id INT,
    @Count INTEGER
AS
BEGIN

	DECLARE @OrderType nvarchar(10)
	select @OrderType = [type] from Order_types where Id = @Order_type_Id

	if NOT Exists(SELECT * from Order_types where Id = @Order_type_Id)
	BEGIN
		RAISERROR('The order type is not exists',15,1);
	END

    DECLARE @Order_Id INT;
    DECLARE @Piece_price FLOAT;
	select @Piece_price = Sale_price from Seedlings where Id = @Seedling_Id;
	DECLARE @Total_price FLOAT = @Count * @Piece_price;

    INSERT INTO Orders (Order_type_Id, Total_price, sale_date, created_at)
    VALUES (@Order_type_Id, @Total_price, @sale_date, GETDATE());
    
    SET @Order_Id = SCOPE_IDENTITY();

    INSERT INTO Order_deatils (Order_Id, Seedling_Id, Seedling_name, Count, Piece_price, Total_price, created_at)
    VALUES (@Order_Id, @Seedling_Id, (SELECT Seedling_name FROM Seedlings WHERE Id = @Seedling_Id), @Count, @Piece_price, @Total_price, GETDATE());

	DECLARE @Seedling_type_Id int
	select @Seedling_type_Id = Seedling_type_Id from Seedlings where Id = @Seedling_Id

	if @OrderType = 'Sale'
	BEGIN
		update Seedlings_types set [Count] = [Count]-@Count where Id = @Seedling_type_Id 
		update Seedlings set [Count] = [Count]-@Count where Id = @Seedling_Id
	END
	Else if @OrderType = 'Bay'
		update Seedlings_types set [Count] = [Count]-@Count where Id = @Seedling_type_Id 
		update Seedlings set [Count] = [Count]+@Count where Id = @Seedling_Id
	END
END;

EXEC InsertPurchaseInvoice 
    @Order_type_Id = 1,
    @sale_date = '2024-5-3',
    @Seedling_Id = 1,
    @Count = 10

	
-- UPDATE PROCEDURE
CREATE OR ALTER PROCEDURE UpdatePurchaseInvoice
    @Order_Id INT,
    @Order_type_Id INT,
    @sale_date DATETIME,
    @Seedling_Id INT,
    @Count INTEGER
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Orders WHERE Id = @Order_Id)
    BEGIN
        RAISERROR('Order with ID %d does not exist.', 16, 1, @Order_Id);
        RETURN;
    END

    DECLARE @Piece_price FLOAT;
	select @Piece_price = Sale_price from Seedlings where Id = @Seedling_Id;
	DECLARE @Total_price FLOAT = @Count * @Piece_price;

    UPDATE Orders
    SET Order_type_Id = @Order_type_Id,
        Total_price = @Total_price,
        sale_date = @sale_date,
        updated_at = GETDATE()
    WHERE Id = @Order_Id;

    UPDATE Order_deatils
    SET Seedling_Id = @Seedling_Id,
        Count = @Count,
        Piece_price = @Piece_price,
        Total_price = @Total_price,
        updated_at = GETDATE()
    WHERE Order_Id = @Order_Id;
END;

EXEC UpdatePurchaseInvoice 
    @Order_Id = 1,
    @Order_type_Id = 1,
    @sale_date = '2024-5-3',
    @Seedling_Id = 1,
    @Count = 12



-- DELETE PROCEDURE
CREATE OR ALTER PROCEDURE DeletePurchaseInvoice
    @Order_Id INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Orders WHERE Id = @Order_Id)
    BEGIN
        RAISERROR('Order with ID %d does not exist.', 16, 1, @Order_Id);
        RETURN;
    END

    DELETE FROM Orders WHERE Id = @Order_Id;

    DELETE FROM Order_deatils WHERE Order_Id = @Order_Id;
END;

EXEC DeletePurchaseInvoice @Order_Id=1;