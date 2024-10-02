-- INSERT PROCEDUR
CREATE OR ALTER PROCEDURE InsertToSeedlingsTypes
    @Category_Id INT,
    @Sector_Id INT,
    @Seedling_name NVARCHAR(50),
    @Count INT,
    @Country NVARCHAR(50),
    @Is_imported BIT
AS
BEGIN
    INSERT INTO Seedlings_types (Category_Id, Sector_Id, Seedling_name, Count, Country, Is_imported)
    VALUES (@Category_Id, @Sector_Id, @Seedling_name, @Count, @Country, @Is_imported);
END;

EXEC InsertToSeedlingsTypes @Category_Id = 1, @Sector_Id = 1, @Seedling_name = '‘ ·…  ›«Õ', @Count = 50, @Country = '„’—', @Is_imported = 0;

-- UPDATE PROCEDUR
CREATE OR ALTER PROCEDURE UpdateSeedlingType
    @Id INT,
    @Category_Id INT,
    @Sector_Id INT,
    @Seedling_name NVARCHAR(50),
    @Count INT,
    @Country NVARCHAR(50),
    @Is_imported BIT
AS
BEGIN
    UPDATE Seedlings_types
    SET Category_Id = @Category_Id,
        Sector_Id = @Sector_Id,
        Seedling_name = @Seedling_name,
        Count = @Count,
        Country = @Country,
        Is_imported = @Is_imported,
        Updated_at = GETDATE()
    WHERE Id = @Id;
END;

EXEC UpdateSeedlingType @Id = 1, @Category_Id = 1, @Sector_Id = 1, @Seedling_name = '‘ ·… »— ﬁ«·', @Count = 30, @Country = '„’—', @Is_imported = 1;

-- DELETE PROCEDUR
CREATE OR ALTER PROCEDURE DeleteSeedlingType
    @Id INT
AS
BEGIN
    DELETE FROM Seedlings_types
    WHERE Id = @Id;
END;

EXEC DeleteSeedlingType @Id = 1;
