CREATE TRIGGER UpdateUpdatedAt
ON Sectors
AFTER UPDATE
AS
BEGIN
    UPDATE Sectors
    SET updated_at = GETDATE()
    WHERE Id IN (SELECT DISTINCT Id FROM inserted);
END;
