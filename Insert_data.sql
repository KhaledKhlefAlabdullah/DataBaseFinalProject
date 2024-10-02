--RESET IDS TO 1 IF THERE AN OLD REMOVED DATA
/*
DBCC CHECKIDENT ('Categories', RESEED, 0);
DBCC CHECKIDENT ('Sectors', RESEED, 0);
DBCC CHECKIDENT ('Seedlings_types', RESEED, 0);
DBCC CHECKIDENT ('Baits', RESEED, 0);
DBCC CHECKIDENT ('Seedlings', RESEED, 0);
DBCC CHECKIDENT ('Order_types', RESEED, 0);
DBCC CHECKIDENT ('Orders', RESEED, 0);
DBCC CHECKIDENT ('Orders_Audites', RESEED, 0);
DBCC CHECKIDENT ('Order_details', RESEED, 0);
*/
BEGIN TRY
BEGIN TRANSACTION

-- Inserting sample data into Categories in Arabic
INSERT INTO Categories (Category_name, created_at, updated_at) VALUES 
('����� �������', GETDATE(), NULL),
('������ ������', GETDATE(), NULL),
('���', GETDATE(), NULL),
('���� ������', GETDATE(), NULL);

-- Inserting sample data into Sectors in Arabic
INSERT INTO Sectors (Sector_number, Space, created_at, updated_at) VALUES 
(1, 100.0, GETDATE(), NULL),
(2, 150.0, GETDATE(), NULL),
(3, 200.0, GETDATE(), NULL),
(4, 250.0, GETDATE(), NULL);

-- Inserting sample data into Seedlings_types in Arabic
INSERT INTO Seedlings_types (Category_Id, Sector_Id, Seedling_name, Count, Country, is_imported, created_at, updated_at) VALUES 
(1, 1, '���� ����', 50, '���', 0, GETDATE(), NULL),
(2, 2, '���� �����', 75, '�������', 1, GETDATE(), NULL),
(3, 3, '��� �����', 100, '�����', 1, GETDATE(), NULL),
(4, 4, '���� ����', 30, '������', 0, GETDATE(), NULL);

-- Inserting sample data into Baits in Arabic
INSERT INTO Baits (Bait_name, [Description], created_at, updated_at) VALUES 
('���� ����', '���� ����� ������� ������.', GETDATE(), NULL),
('���� �������', '���� ������� ������� ������.', GETDATE(), NULL);

-- Inserting sample data into Seedlings in Arabic
INSERT INTO Seedlings (Seedling_type_Id, Bait_Id, Seedling_name, agriculture_date, sale_date, Destruction_date, [Count], Sale_price, By_price, created_at, updated_at) VALUES 
(1, 1, '���� ����', GETDATE(), NULL, NULL,50, 50.0, 35.0, GETDATE(), NULL),
(2, NULL, '���� �����', GETDATE(), NULL, NULL,75, 15.0, 10.0, GETDATE(), NULL),
(3, 2, '���� �����', GETDATE(), NULL, NULL, 100, 20.0, 15.0, GETDATE(), NULL),
(4, NULL, '���� ����', GETDATE(), NULL, NULL, 30, 30.0, 25.0, GETDATE(), NULL);

-- Inserting sample data into Order_types in Arabic
INSERT INTO Order_types (type, created_at, updated_at) VALUES 
('Sale', GETDATE(), NULL),
('Bay', GETDATE(), NULL),
('��� ���', GETDATE(), NULL);

-- Inserting sample data into Orders in Arabic
INSERT INTO Orders (Order_type_Id, Total_price, sale_date, Destruction_date, created_at, updated_at) VALUES 
(1, 500.0, GETDATE(), NULL, GETDATE(), NULL),
(2, 150.0, GETDATE(), NULL, GETDATE(), NULL),
(3, 300.0, GETDATE(), NULL, GETDATE(), NULL);

-- Inserting sample data into Orders_Audites in Arabic
INSERT INTO Orders_Audites (Order_Id, Operation, sale_or_by, created_at) VALUES 
(1, '�����', '���', GETDATE()),
(2, '�����', '����', GETDATE()),
(3, '�����', '���', GETDATE());

-- Inserting sample data into Order_details in Arabic
INSERT INTO Order_deatils (Order_Id, Seedling_Id, Seedling_name, Count, Piece_price, Total_price, created_at, updated_at) VALUES 
(1, 1, '���� ����', 10, 50.0, 500.0, GETDATE(), NULL),
(2, 2, '���� �����', 5, 15.0, 75.0, GETDATE(), NULL),
(3, 3, '���� �����', 3, 20.0, 60.0, GETDATE(), NULL),
(1, 4, '���� ����', 7, 30.0, 210.0, GETDATE(), NULL);
COMMIT
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION;
SELECT ERROR_LINE(), ERROR_MESSAGE();
END CATCH