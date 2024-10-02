CREATE OR ALTER TRIGGER InsertOrderAudit
ON Orders
AFTER INSERT
AS
BEGIN
    INSERT INTO Orders_Audites (Order_Id, Operation, Sale_or_by, created_at)
    SELECT 
        i.Id,               
        'INSERT',          
        (SELECT TOP 1 [type] FROM Order_types WHERE Id = i.Order_type_Id),
        GETDATE()          
    FROM inserted i;      
END;


CREATE OR ALTER TRIGGER UpdateOrderAudit
ON Orders
AFTER UPDATE
AS
BEGIN
    INSERT INTO Orders_Audites (Order_Id, Operation, Sale_or_by, created_at)
    SELECT 
        i.Id,                
        'UPDATE',          
        (SELECT TOP 1 [type] FROM Order_types WHERE Id = i.Order_type_Id),  
        GETDATE()          
    FROM inserted i;      
END;


CREATE OR ALTER TRIGGER trg_DeleteOrderAudit
ON Orders
AFTER DELETE
AS
BEGIN
    INSERT INTO Orders_Audites (Order_Id, Operation, Sale_or_by, created_at)
    SELECT 
        d.Id,                
        'DELETE',        
        (SELECT TOP 1 [type] FROM Order_types WHERE Id = (SELECT TOP 1 Order_type_Id FROM deleted WHERE Id = d.Id)), 
        GETDATE()         
    FROM deleted d;     
END;
