
CREATE INDEX  IX_Seedlings_types_Category_Id_Sector_Id
    ON dbo.Seedlings_types
    (Sector_Id,Category_Id)


CREATE INDEX  IX_Seedlings_Seedling_type_Id_Bait_Id
    ON dbo.Seedlings
    (Seedling_type_Id,Bait_Id)

CREATE INDEX  IX_Orders_Order_type_Id
    ON dbo.Orders
    (Order_type_Id)


CREATE INDEX  IX_Orders_Audites_Order_Id
    ON dbo.Orders_Audites
    (Order_Id)

CREATE INDEX  IX_Order_Order_Id_Seedling_Id
    ON dbo.Order_deatils
    (Order_Id,Seedling_Id)