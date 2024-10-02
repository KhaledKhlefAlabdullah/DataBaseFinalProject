CREATE OR ALTER FUNCTION GetSectorById(
    @Id INT
)
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM Sectors
    WHERE Id = @Id
);

SELECT * FROM GetSectorById(@Id = 1);



CREATE OR ALTER FUNCTION GetAllSecto(
    @Id INT
)
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM Sectors
);

SELECT * FROM GetAllSector();
