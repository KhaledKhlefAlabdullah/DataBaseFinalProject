-- CHECK IF CATEGORY EXISTS BEFORE
CREATE TRIGGER CheckIfCategorExists
    ON Categories
    INSTEAD OF INSERT
    AS
    BEGIN
    IF EXISTS(SELECT * FROM inserted I INNER JOIN Categories c on I.Category_name=c.Category_name where I.Id <> c.Id)
	BEGIN
		SELECT 'This category name exists befor in database'
	END
	ELSE
	BEGIN
		INSERT INTO Categories(Category_name, created_at) SELECT Category_name, created_at FROM inserted
	END
    END


-- UPDATE UPDATED AT FAILED VALUE AFTER UPDATE
CREATE OR ALTER TRIGGER UpdateCategoriesTimestamp
ON Categories
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Categories
    SET Updated_at = GETDATE()
    WHERE Id IN (SELECT Id FROM INSERTED);
END;
