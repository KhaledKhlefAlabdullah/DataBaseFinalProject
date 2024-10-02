CREATE OR ALTER FUNCTION GetAllSeedlings()
RETURNS TABLE
AS
RETURN (
    SELECT * FROM Seedlings
);

select * from dbo.GetAllSeedlings()




