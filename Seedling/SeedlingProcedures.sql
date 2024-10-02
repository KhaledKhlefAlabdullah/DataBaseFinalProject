-- INSERT SEDDLING PROCEDURE
CREATE OR ALTER PROCEDURE InsertSeedling
    @Seedling_type_Id INT,
    @Seedling_name VARCHAR(50),
    @agriculture_date DATETIME,
    @Destruction_date DATETIME,
    @Sale_price FLOAT,
    @By_price FLOAT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Seedlings_types WHERE Id = @Seedling_type_Id)
    BEGIN
        RAISERROR('Seedling type with ID %d does not exist.', 16, 1, @Seedling_type_Id);
        RETURN;
    END

    INSERT INTO Seedlings (Seedling_type_Id, Seedling_name, agriculture_date, sale_date, Destruction_date, Sale_price, By_price, created_at)
    VALUES (@Seedling_type_Id, @Seedling_name, @agriculture_date, @Destruction_date, @Sale_price, @By_price, GETDATE());
END;

EXEC InsertSeedling
    @Seedling_type_Id = 1, 
    @Seedling_name = 'ÔÌÑÉ ÊÝÇÍ', 
    @agriculture_date = '2024-08-06', 
    @Destruction_date = NULL, 
    @Sale_price = 50.0, 
    @By_price = 35.0;


-- UPDATE SEEDLING PROCEDURE
CREATE OR ALTER PROCEDURE UpdateSeedling
    @Id INT,
    @Seedling_type_Id INT = NULL,
    @Bait_Id INT = NULL,
    @Seedling_name VARCHAR(50) = NULL,
    @agriculture_date DATETIME = NULL,
    @sale_date DATETIME = NULL,
    @Destruction_date DATETIME = NULL,
    @Sale_price FLOAT = NULL,
    @By_price FLOAT = NULL
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Seedlings WHERE Id = @Id)
    BEGIN
        RAISERROR('Seedling with ID %d does not exist.', 16, 1, @Id);
        RETURN;
    END

    IF @Seedling_type_Id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Seedlings_types WHERE Id = @Seedling_type_Id)
    BEGIN
        RAISERROR('Seedling type with ID %d does not exist.', 16, 1, @Seedling_type_Id);
        RETURN;
    END

    IF @Bait_Id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Baits WHERE Id = @Bait_Id)
    BEGIN
        RAISERROR('Bait with ID %d does not exist.', 16, 1, @Bait_Id);
        RETURN;
    END

    UPDATE Seedlings
    SET 
        Seedling_type_Id = COALESCE(@Seedling_type_Id, Seedling_type_Id),
        Bait_Id = COALESCE(@Bait_Id, Bait_Id),
        Seedling_name = COALESCE(@Seedling_name, Seedling_name),
        agriculture_date = COALESCE(@agriculture_date, agriculture_date),
        sale_date = COALESCE(@sale_date, sale_date),
        Destruction_date = COALESCE(@Destruction_date, Destruction_date),
        Sale_price = COALESCE(@Sale_price, Sale_price),
        By_price = COALESCE(@By_price, By_price),
        updated_at = GETDATE()
    WHERE Id = @Id;
END;

EXEC UpdateSeedling 
@Id = 1, 
@Seedling_type_Id = 1, 
@Bait_Id = 1,
@Seedling_name = 'ÔÌÑÉ ÊÝÇÍ', 
@agriculture_date = '2024-08-06', 
@sale_date = NULL, 
@Destruction_date = NULL, 
@Sale_price = 55.0, 
@By_price = 40.0;

-- DELETE SEDDLING PROCEDURE
CREATE OR ALTER PROCEDURE DeleteSeedling
    @Id INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Seedlings WHERE Id = @Id)
    BEGIN
        RAISERROR('Seedling with ID %d does not exist.', 16, 1, @Id);
        RETURN;
    END

	DELETE FROM Order_deatils WHERE Seedling_Id = @Id;
    DELETE FROM Seedlings
    WHERE Id = @Id;
END;

EXEC DeleteSeedling @Id = 1;

-- BAITTING SEEDLING
CREATE PROCEDURE BaittingSeedlings
    @seedling_id int, 
    @Bait_Id int  
AS
    EXEC UpdateSeedling @Id = 1, @Bait_Id = 1
RETURN 0 

EXEC BaittingSeedlings @seedling_id = 1, @Bait_Id = 1

-- ÊÊÈÚ ÇáÔÊáÇÊ ÈäÇÁ Úáì ÇáÊæÇÑíÎ
-- PROCEDURE TO RETRIEVE SEEDLINGS BASED ON DATES
CREATE OR ALTER PROCEDURE GetSeedlingsByDate
    @agriculture_date_from DATETIME = NULL,    
    @agriculture_date_to DATETIME = NULL,    
    @sale_date_from DATETIME = NULL,        
    @sale_date_to DATETIME = NULL,           
    @Destruction_date_from DATETIME = NULL,   
    @Destruction_date_to DATETIME = NULL    
AS
BEGIN
    SELECT *
    FROM Seedlings
    WHERE

        (@agriculture_date_from IS NULL OR agriculture_date >= @agriculture_date_from) AND
        (@agriculture_date_to IS NULL OR agriculture_date <= @agriculture_date_to) AND
        
        (@sale_date_from IS NULL OR sale_date >= @sale_date_from) AND
        (@sale_date_to IS NULL OR sale_date <= @sale_date_to) AND

        (@Destruction_date_from IS NULL OR Destruction_date >= @Destruction_date_from) AND
        (@Destruction_date_to IS NULL OR Destruction_date <= @Destruction_date_to);
END;

EXEC GetSeedlingsByDate @agriculture_date_from = '2023-01-01', @agriculture_date_to = '2023-12-31';

EXEC GetSeedlingsByDate @sale_date_from = '2024-01-01', @sale_date_to = '2024-12-31';

EXEC GetSeedlingsByDate @agriculture_date_from = '2023-01-01', @Destruction_date_to = '2024-01-01';
