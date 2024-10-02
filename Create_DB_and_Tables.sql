CREATE DATABASE NUSERY_PROJECT;
use NUSERY_PROJECT;
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Category_name VARCHAR(50) unique NOT NULL,
      created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME,
);

CREATE TABLE Sectors (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Sector_number INTEGER NOT NULL,
    Space FLOAT NOT NULL,
      created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME
);

CREATE TABLE Seedlings_types (
    Id INT IDENTITY(1,1) PRIMARY KEY,
	Category_Id INT NOT NULL,
    Sector_Id INT NOT NULL,
    Seedling_name VARCHAR(50) NOT NULL,
    Count INTEGER NOT NULL,
    Country NVARCHAR(20),
    is_imported bit NOT NULL,
      created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME,
	FOREIGN KEY (Category_Id) REFERENCES Categories(Id) ON DELETE CASCADE,
    FOREIGN KEY (Sector_Id) REFERENCES Sectors(Id) ON DELETE CASCADE
);


CREATE TABLE Baits (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Bait_name VARCHAR(50) NOT NULL,
    [Description] TEXT,
      created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME
);


CREATE TABLE Seedlings (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Seedling_type_Id INT NOT NULL,
    Bait_Id INT,
    Seedling_name VARCHAR(50) NOT NULL,
    Parcode_name VARCHAR(50) NOT NULL,
    agriculture_date DATETIME NOT NULL, 
    sale_date DATETIME,                 
    Destruction_date DATETIME,  
	[Count] INT not null,
    Sale_price FLOAT,
    By_price FLOAT,
    created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME,
    FOREIGN KEY (Seedling_type_Id) REFERENCES Seedlings_types(Id) ON DELETE CASCADE,
    FOREIGN KEY (Bait_Id) REFERENCES Baits(Id) ON DELETE CASCADE,
    CHECK (sale_date IS NULL OR Destruction_date IS NULL)  
);


CREATE TABLE Order_types (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    type VARCHAR(50) UNIQUE NOT NULL,
      created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME
);


CREATE TABLE Orders (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Order_type_Id INT NOT NULL,
    Total_price FLOAT NOT NULL,
    sale_date DATETIME,
    created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME,
    FOREIGN KEY (Order_type_Id) REFERENCES Order_types(Id) ON DELETE CASCADE
);

CREATE TABLE Orders_Audites (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Order_Id INT NOT NULL,
    Operation VARCHAR(10) NOT NULL,
    sale_or_by VARCHAR(10) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    FOREIGN KEY (Order_Id) REFERENCES Orders(Id) ON DELETE SET NULL
);


CREATE TABLE Order_deatils (
	Id int identity primary key,
    Order_Id INT,
    Seedling_Id INT,
    Seedling_name VARCHAR(50) NOT NULL,
    Count INTEGER NOT NULL,
    Piece_price FLOAT NOT NULL,
    Total_price FLOAT NOT NULL,
      created_at DATETIME NOT NULL DEFAULT GETDATE(), 
    updated_at DATETIME,
    FOREIGN KEY (Order_Id) REFERENCES Orders(Id) ON DELETE CASCADE,
    FOREIGN KEY (Seedling_Id) REFERENCES Seedlings(Id) ON DELETE CASCADE
);


