Create database InventoryDB;
Use InventoryDB;

Create table Products (
ProductID int primary key,
ProductName varchar(100),
UnitPrice decimal(10, 2));

Create table Suppliers (
SupplierID int primary key,
Name varchar(100),
ContactEmail varchar(100),
Phone varchar(20));

Create table SupplyOrders (
OrderID int primary key,
SupplierID int,
ProductID int,
Quantity int,
OrderDate date,
DeliveryDate date,
Status varchar(20),
Foreign key(SupplierID) references Suppliers(SupplierID),
Foreign Key(ProductID) references Products(ProductID));

INSERT INTO Products VALUES
(101, 'LED Monitor', 8500.00),
(102, 'Wireless Mouse', 1200.00),
(103, 'Keyboard', 1500.00);

INSERT INTO Suppliers VALUES
(1, 'Global Traders', 'contact@globaltraders.com', '9876543210'),
(2, 'FreshSource Ltd.', 'info@freshsource.com', '9123456789'),
(3, 'TechSupply Co.', 'sales@techsupply.com', '9988776655');

INSERT INTO SupplyOrders VALUES
(1001, 1, 101, 50, '2025-10-01', '2025-10-05', 'Delivered'),
(1002, 2, 102, 100, '2025-10-03', '2025-10-07', 'Pending'),
(1003, 3, 103, 75, '2025-10-04', '2025-10-08', 'Delivered'),
(1004, 1, 102, 60, '2025-10-06', '2025-10-10', 'Delivered');

SELECT
    s.Name AS SupplierName,
    SUM(o.Quantity) AS TotalQuantitySupplied
FROM Suppliers s
JOIN SupplyOrders o ON s.SupplierID = o.SupplierID
WHERE o.Status = 'Delivered'
GROUP BY s.SupplierID, s.Name;
/* # SupplierName, TotalQuantitySupplied
'Global Traders', '110'
'TechSupply Co.', '75' */

SELECT
    o.OrderID,
    s.Name AS SupplierName,
    DATEDIFF(o.DeliveryDate, o.OrderDate) AS DaysToDeliver
FROM SupplyOrders o
JOIN Suppliers s ON o.SupplierID = s.SupplierID;
/* # OrderID, SupplierName, DaysToDeliver
'1001', 'Global Traders', '4'
'1004', 'Global Traders', '4'
'1002', 'FreshSource Ltd.', '4'
'1003', 'TechSupply Co.', '4' */

SELECT
    o.OrderID,
    s.Name AS SupplierName,
    p.ProductName,
    o.Quantity,
    o.OrderDate,
    o.DeliveryDate,
    o.Status
FROM SupplyOrders o
JOIN Suppliers s ON o.SupplierID = s.SupplierID
JOIN Products p ON o.ProductID = p.ProductID;
/* # OrderID, SupplierName, ProductName, Quantity, OrderDate, DeliveryDate, Status
'1001', 'Global Traders', 'LED Monitor', '50', '2025-10-01', '2025-10-05', 'Delivered'
'1004', 'Global Traders', 'Wireless Mouse', '60', '2025-10-06', '2025-10-10', 'Delivered'
'1002', 'FreshSource Ltd.', 'Wireless Mouse', '100', '2025-10-03', '2025-10-07', 'Pending'
'1003', 'TechSupply Co.', 'Keyboard', '75', '2025-10-04', '2025-10-08', 'Delivered' */

DELIMITER //
CREATE PROCEDURE InsertSupplyOrder (
    IN p_OrderID INT,
    IN p_SupplierID INT,
    IN p_ProductID INT,
    IN p_Quantity INT,
    IN p_OrderDate DATE,
    IN p_DeliveryDate DATE,
    IN p_Status VARCHAR(20)
)
BEGIN
    INSERT INTO SupplyOrders (OrderID, SupplierID, ProductID, Quantity, OrderDate, DeliveryDate, Status)
    VALUES (p_OrderID, p_SupplierID, p_ProductID, p_Quantity, p_OrderDate, p_DeliveryDate, p_Status);
END //
DELIMITER ;

Call InsertSupplyOrder (1005, 3, 101, 40, '2025-10-06', '2025-10-08', 'Delivered');

DELIMITER //
CREATE PROCEDURE UpdateSupplyOrderStatus (
    IN p_OrderID INT,
    IN p_NewStatus VARCHAR(20)
)
BEGIN
    UPDATE SupplyOrders
    SET Status = p_NewStatus
    WHERE OrderID = p_OrderID;
END //
DELIMITER ;

Call UpdateSupplyOrderStatus (1002, 'Delivered');