-- INSERT ORDER TYPE PROCEDURE
CREATE OR ALTER PROCEDURE InsertOrderType
    @type VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Order_types WHERE type = @type)
    BEGIN
        RAISERROR('Order type %s already exists.', 16, 1, @type);
        RETURN;
    END

    INSERT INTO Order_types (type, created_at)
    VALUES (@type, GETDATE());
END;

EXEC InsertOrderType @type = 'Retail';


-- UPDATE ORDER TYPE PROCEDURE
CREATE OR ALTER PROCEDURE UpdateOrderType
    @Id INT,
    @type VARCHAR(50)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Order_types WHERE Id = @Id)
    BEGIN
        RAISERROR('Order type with ID %d does not exist.', 16, 1, @Id);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Order_types WHERE type = @type AND Id <> @Id)
    BEGIN
        RAISERROR('Order type %s already exists.', 16, 1, @type);
        RETURN;
    END

    UPDATE Order_types
    SET type = @type,
        updated_at = GETDATE()
    WHERE Id = @Id;
END;

EXEC UpdateOrderType @Id = 1, @type = 'Wholesale';

-- DELETE ORDER TYPE PROCEDURE
CREATE OR ALTER PROCEDURE DeleteOrderType
    @Id INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Order_types WHERE Id = @Id)
    BEGIN
        RAISERROR('Order type with ID %d does not exist.', 16, 1, @Id);
        RETURN;
    END

    DELETE FROM Order_types
    WHERE Id = @Id;
END;

EXEC DeleteOrderType @Id = 1;
