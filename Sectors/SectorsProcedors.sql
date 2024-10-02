-- INSERT PROCEDURE
CREATE OR ALTER PROCEDURE InsertSector
    @Sector_number INTEGER,
    @Space FLOAT
AS
BEGIN
    INSERT INTO Sectors (Sector_number, Space, created_at)
    VALUES (@Sector_number, @Space, GETDATE());
END;

EXEC InsertSector @Sector_number = 1, @Space = 150.0;

-- UPDATE PROCEDURE
CREATE OR ALTER PROCEDURE UpdateSector
    @Id INT,
    @Sector_number INTEGER,
    @Space FLOAT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sectors WHERE Id = @Id)
    BEGIN
        RAISERROR('Sector with ID %d does not exist.', 16, 1, @Id);
        RETURN;
    END

    UPDATE Sectors
    SET Sector_number = @Sector_number,
        Space = @Space,
        updated_at = GETDATE()
    WHERE Id = @Id;
END;

EXEC UpdateSector @Id = 1, @Sector_number = 2, @Space = 200.0;

-- DELETE PROCEDURE
CREATE OR ALTER PROCEDURE DeleteSector
    @Id INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Sectors WHERE Id = @Id)
    BEGIN
        RAISERROR('Sector with ID %d does not exist.', 16, 1, @Id);
        RETURN;
    END

    DELETE FROM Sectors WHERE Id = @Id;
END;

EXEC DeleteSector @Id = 1;
