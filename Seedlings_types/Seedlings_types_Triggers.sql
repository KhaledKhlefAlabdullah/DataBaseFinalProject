CREATE OR ALTER TRIGGER UpdateSeedlingTypeTimestamp
ON Seedlings_types
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Seedlings_types
    SET Updated_at = GETDATE()
    WHERE Id IN (SELECT Id FROM INSERTED);
END;

