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
('√‘Ã«— «·›«ﬂÂ…', GETDATE(), NULL),
('‰»« «  «·Œ÷«—', GETDATE(), NULL),
('”—Ê', GETDATE(), NULL),
('“ÂÊ— «·“Ì‰…', GETDATE(), NULL);

-- Inserting sample data into Sectors in Arabic
INSERT INTO Sectors (Sector_number, Space, created_at, updated_at) VALUES 
(1, 100.0, GETDATE(), NULL),
(2, 150.0, GETDATE(), NULL),
(3, 200.0, GETDATE(), NULL),
(4, 250.0, GETDATE(), NULL);

-- Inserting sample data into Seedlings_types in Arabic
INSERT INTO Seedlings_types (Category_Id, Sector_Id, Seedling_name, Count, Country, is_imported, created_at, updated_at) VALUES 
(1, 1, '‘ ·…  ›«Õ', 50, '„’—', 0, GETDATE(), NULL),
(2, 2, '‘ ·… ÿ„«ÿ„', 75, '√·„«‰Ì«', 1, GETDATE(), NULL),
(3, 3, '”—Ê ›—‰”Ì', 100, '›—‰”«', 1, GETDATE(), NULL),
(4, 4, '‘ ·… “ÂÊ—', 30, 'ÂÊ·‰œ«', 0, GETDATE(), NULL);

-- Inserting sample data into Baits in Arabic
INSERT INTO Baits (Bait_name, [Description], created_at, updated_at) VALUES 
('ÿı⁄„ ⁄÷ÊÌ', 'ÿı⁄„ ÿ»Ì⁄Ì ·„ﬂ«›Õ… «·¬›« .', GETDATE(), NULL),
('ÿı⁄„ ﬂÌ„Ì«∆Ì', 'ÿı⁄„ ﬂÌ„Ì«∆Ì ·„ﬂ«›Õ… «·¬›« .', GETDATE(), NULL);

-- Inserting sample data into Seedlings in Arabic
INSERT INTO Seedlings (Seedling_type_Id, Bait_Id, Seedling_name, agriculture_date, sale_date, Destruction_date, [Count], Sale_price, By_price, created_at, updated_at) VALUES 
(1, 1, '‘Ã—…  ›«Õ', GETDATE(), NULL, NULL,50, 50.0, 35.0, GETDATE(), NULL),
(2, NULL, '‰»«  ÿ„«ÿ„', GETDATE(), NULL, NULL,75, 15.0, 10.0, GETDATE(), NULL),
(3, 2, '‰»«  —ÌÕ«‰', GETDATE(), NULL, NULL, 100, 20.0, 15.0, GETDATE(), NULL),
(4, NULL, '“ÂÊ— “Ì‰…', GETDATE(), NULL, NULL, 30, 30.0, 25.0, GETDATE(), NULL);

-- Inserting sample data into Order_types in Arabic
INSERT INTO Order_types (type, created_at, updated_at) VALUES 
('Sale', GETDATE(), NULL),
('Bay', GETDATE(), NULL),
('ÿ·» Œ«’', GETDATE(), NULL);

-- Inserting sample data into Orders in Arabic
INSERT INTO Orders (Order_type_Id, Total_price, sale_date, Destruction_date, created_at, updated_at) VALUES 
(1, 500.0, GETDATE(), NULL, GETDATE(), NULL),
(2, 150.0, GETDATE(), NULL, GETDATE(), NULL),
(3, 300.0, GETDATE(), NULL, GETDATE(), NULL);

-- Inserting sample data into Orders_Audites in Arabic
INSERT INTO Orders_Audites (Order_Id, Operation, sale_or_by, created_at) VALUES 
(1, '≈÷«›…', '»Ì⁄', GETDATE()),
(2, ' ÕœÌÀ', '‘—«¡', GETDATE()),
(3, '≈·€«¡', '»Ì⁄', GETDATE());

-- Inserting sample data into Order_details in Arabic
INSERT INTO Order_deatils (Order_Id, Seedling_Id, Seedling_name, Count, Piece_price, Total_price, created_at, updated_at) VALUES 
(1, 1, '‘Ã—…  ›«Õ', 10, 50.0, 500.0, GETDATE(), NULL),
(2, 2, '‰»«  ÿ„«ÿ„', 5, 15.0, 75.0, GETDATE(), NULL),
(3, 3, '‰»«  —ÌÕ«‰', 3, 20.0, 60.0, GETDATE(), NULL),
(1, 4, '“ÂÊ— “Ì‰…', 7, 30.0, 210.0, GETDATE(), NULL);
COMMIT
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION;
SELECT ERROR_LINE(), ERROR_MESSAGE();
END CATCH