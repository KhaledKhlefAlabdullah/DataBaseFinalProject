-- GENERATE PARCODE TRIGGER
CREATE OR ALTER TRIGGER GenerateParcode
ON Seedlings
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @Seedling_type_Id INT, 
            @Bait_Id INT,
            @Seedling_name VARCHAR(50), 
            @agriculture_date DATETIME, 
            @Sale_price FLOAT, 
            @By_price FLOAT, 
            @created_at DATETIME, 
            @updated_at DATETIME,
            @NewId INT;

    -- Insert new records with generated Parcode_name
    INSERT INTO Seedlings (Seedling_type_Id, Bait_Id, Seedling_name, Parcode_name, agriculture_date, Sale_price, By_price, created_at, updated_at) 
    SELECT 
        Seedling_type_Id,
        Bait_Id,
        Seedling_name,
        'PAR-' + CAST(IDENT_CURRENT('Seedlings') + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS VARCHAR(10)),  -- Generate Parcode_name
        agriculture_date,
        Sale_price,
        By_price,
        created_at,
        updated_at
    FROM INSERTED;
END;

-- UPDATE UPDATED AT FAILED
CREATE OR ALTER TRIGGER UpdateSeedlingTimestamp
ON Seedlings
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Seedlings
    SET Updated_at = GETDATE()
    WHERE Id IN (SELECT Id FROM INSERTED);
END;

