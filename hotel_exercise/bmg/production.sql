CREATE SCHEMA IF NOT EXISTS production;

use production;

CREATE TABLE ProductCategory
(
    ProductCategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name              VARCHAR(64) NOT NULL,
    ModifiedDate      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ProductSubcategory
(
    ProductSubcategoryID INT AUTO_INCREMENT PRIMARY KEY,
    Name                 VARCHAR(64) NOT NULL,
    ProductCategoryID    INT,
    ModifiedDate         DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory (ProductCategoryID)
);

CREATE TABLE Location
(
    LocationID   INT AUTO_INCREMENT PRIMARY KEY,
    Name         VARCHAR(64) NOT NULL,
    ModifiedDate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Product
(
    ProductID            INT AUTO_INCREMENT PRIMARY KEY,
    Name                 VARCHAR(64) NOT NULL,
    ProductNumber        VARCHAR(64),
    Color                VARCHAR(16),
    ListPrice            DECIMAL(8, 2),
    Size                 VARCHAR(10),
    Weight               DECIMAL(8, 2),
    DaysToManufacture    INT,
    ProductSubcategoryID INT,
    SellStartDate        DATETIME DEFAULT CURRENT_TIMESTAMP,
    SellEndDate          DATETIME,
    ModifiedDate         DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (ProductSubcategoryID) REFERENCES
        ProductSubcategory (ProductSubcategoryID)
);

CREATE TABLE ProductInventory
(
    ProductID    INT,
    LocationID   INT,
    Quantity     INT NOT NULL DEFAULT 0,
    ModifiedDate DATETIME     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (ProductID, LocationID),
    FOREIGN KEY (ProductID) REFERENCES Product (ProductID),
    FOREIGN KEY (LocationID) REFERENCES Location (LocationID)
);