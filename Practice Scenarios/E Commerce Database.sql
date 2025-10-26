Create database ECommerceDB;
Use ECommerceDB;

Create table Customers (
CustomerID int primary key,
Name varchar(100),
Email varchar(100),
Address varchar(100));

Create table Products (
ProductID int primary key,
Name varchar(100),
Price Decimal(10, 2),
Stock int);

Create table Orders (
OrderID int primary key,
CustomerID int,
ProductID int,
OrderDate date,
Quantity int,
Foreign Key(CustomerID) references Customers(CustomerID),
Foreign Key(ProductID) references Products(ProductID));

Insert into Customers values
(1, 'Aarav', 'aarav@gmail.com', 'Bengaluru'),
(2, 'Pranati', 'pranathi@rediff.com', 'Hyderabad'),
(3, 'Bobby', 'bobby@yahoo.com', 'Mysore');

Insert into Products values
(101, 'Laptop', 75000.00, 10),
(102, 'Smartphone', 30000.00, 10),
(103, 'Headphones', 2500.00, 10);

Insert into Orders values
(1001, 2, 101, '2025-10-16', 1),
(1002, 3, 101, '2025-10-12', 2),
(1003, 1, 103, '2025-10-20', 1),
(1004, 1, 102, '2025-10-21', 2);

Select p.ProductID, p.Name, Sum(o.Quantity * p.Price) as TotalSales
from Orders o inner join Products p on o.ProductID = p.ProductID
group by p.ProductID, p.Name;
/* # ProductID, Name, TotalSales
'101', 'Laptop', '225000.00'
'102', 'Smartphone', '60000.00'
'103', 'Headphones', '2500.00' */

Select p.ProductID, p.Name, Sum(o.Quantity) as TotalQuantity
from Orders o left join Products p on o.ProductID = p.ProductID
group by p.ProductID, p.Name order by TotalQuantity desc
limit 1;
/* # ProductID, Name, TotalQuantity
'101', 'Laptop', '3' */

Select c.Name as CustomerName, o.OrderID, o.OrderDate
from Customers c right join Orders o on c.CustomerID = o.CustomerID;
/* # CustomerName, OrderID, OrderDate
'Pranati', '1001', '2025-10-16'
'Bobby', '1002', '2025-10-12'
'Aarav', '1003', '2025-10-20'
'Aarav', '1004', '2025-10-21' */

Delimiter //
Create procedure UpdateProductStock (
in p_ProductID int,
in p_Quantity int)
begin
Update Products
set Stock = Stock - p_Quantity
where ProductID = p_ProductID;
End //
Delimiter ;

Call UpdateProductStock(103, 2);