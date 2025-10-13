-- Lab Experiment 05: To implement different types of joins: Inner Join, Outer Join (Left, Right, Full), and Natural Join.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Swayam Deeksha R B
-- USN: 1RUA24BCA0090
-- SECTION: A
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
       
-- 'root@localhost', 'SwayamDeeksha', '8.4.6', '2025-09-22 11:25:33'

-- Write your code below this line along with the output 

Create database CustomersOrders;
use CustomersOrders;

-- table 01: Customers
-- CREATE  a TABLE named Customers (customer_id INT PRIMARY KEY,customer_name VARCHAR(50),city VARCHAR(50)

Create Table Customers (
Customer_ID int Primary Key,
Customer_Name varchar(50),
City varchar(50));

-- insert 5 records

Insert into Customers Values (101, "Amit Jain", "Bangalore"), (102, "Amar Tyagi", "Mysore"), (103, "Bhanu Prasant", "Mysore");
Insert into Customers Values (104, "Deepak Gupta", "Bangalore"), (105, "Naina Rao", "Bangalore");

-- TABLE:02 Orders Table

-- CREATE a TABLE named Orders (order_id INT PRIMARY KEY,customer_id INT foreign key,product_name VARCHAR(50),order_date DATE,

Create Table Orders (
Order_ID int Primary Key,
Customer_ID int,
Product_Name varchar(50),
Order_Date Date,
Foreign Key(Customer_ID) references Customers(Customer_ID));

-- insert 5 records

Insert into Orders Values (301, 102, "Towel", '2025-04-06'), (302, 101, "Text Book", '2024-09-19'), (303, 103, "Hair Care", '2025-08-21');
Insert into Orders Values (304, 105, "Clothes", '2025-04-01'), (305, 104, "Groceries", '2025-08-15');

-- TASK FOR STUDENTS 

 
-- Write and Execute Queries
/*
1. Inner Join – 
   Find all orders placed by customers from the city "Bangalore."
   List all customers with the products they ordered.
   Show customer names and their order dates.
   Display order IDs with the corresponding customer names.
   Find the number of orders placed by each customer.
   Show city names along with the products ordered by customers.
*/

Select c.Customer_Name, o.Product_Name, o.Order_Date from Customers c inner join Orders o On c.Customer_ID = o.Customer_ID where City = 'Bangalore';

/* # Customer_Name, Product_Name, Order_Date
'Amit Jain', 'Text Book', '2024-09-19'
'Deepak Gupta', 'Groceries', '2025-08-15'
'Naina Rao', 'Clothes', '2025-04-01' */

Select c.Customer_Name, o.Product_Name from Customers c inner join Orders o On c.Customer_ID = o.Customer_ID;

/* # Customer_Name, Product_Name
'Amit Jain', 'Text Book'
'Amar Tyagi', 'Towel'
'Bhanu Prasant', 'Hair Care'
'Deepak Gupta', 'Groceries'
'Naina Rao', 'Clothes' */

Select c.Customer_Name, o.Order_Date from Customers c inner join Orders o On c.Customer_ID = o.Customer_ID;

/* # Customer_Name, Order_Date
'Amit Jain', '2024-09-19'
'Amar Tyagi', '2025-04-06'
'Bhanu Prasant', '2025-08-21'
'Deepak Gupta', '2025-08-15'
'Naina Rao', '2025-04-01' */

Select c.Customer_Name, o.Order_ID from Customers c inner join Orders o On c.Customer_ID = o.Customer_ID;

/* # Customer_Name, Order_ID
'Amit Jain', '302'
'Amar Tyagi', '301'
'Bhanu Prasant', '303'
'Deepak Gupta', '305'
'Naina Rao', '304' */

Select c.Customer_Name, Count(o.Order_ID) from Customers c inner join Orders o On c.Customer_ID = o.Customer_ID Group by c.Customer_Name;

/* # Customer_Name, Count(o.Order_ID)
'Amit Jain', '1'
'Amar Tyagi', '1'
'Bhanu Prasant', '1'
'Deepak Gupta', '1'
'Naina Rao', '1' */

Select c.City, o.Product_Name from Customers c inner join Orders o On c.Customer_ID = o.Customer_ID;

/* # City, Product_Name
'Bangalore', 'Text Book'
'Mysore', 'Towel'
'Mysore', 'Hair Care'
'Bangalore', 'Groceries'
'Bangalore', 'Clothes' */

/* 
2  Left Outer Join – 
    Find all customers and their orders, even if a customer has no orders.
    List all customers and the products they ordered.
    Show customer IDs, names, and their order IDs.
    Find the total number of orders (if any) placed by each customer.
    Retrieve customers who have not placed any orders.
	Display customer names with their order dates.
-- Write your code below this line along with the output 
*/

Select c.Customer_Name, o.Product_Name from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID;

/* # Customer_Name, Product_Name
'Amit Jain', 'Text Book'
'Amar Tyagi', 'Towel'
'Bhanu Prasant', 'Hair Care'
'Deepak Gupta', 'Groceries'
'Naina Rao', 'Clothes' */

Select c.Customer_Name, o.Product_Name from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID;

/* # Customer_Name, Product_Name
'Amit Jain', 'Text Book'
'Amar Tyagi', 'Towel'
'Bhanu Prasant', 'Hair Care'
'Deepak Gupta', 'Groceries'
'Naina Rao', 'Clothes' */

Select c.Customer_ID, c.Customer_Name, o.Order_ID from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID; 

/* # Customer_ID, Customer_Name, Order_ID
'101', 'Amit Jain', '302'
'102', 'Amar Tyagi', '301'
'103', 'Bhanu Prasant', '303'
'104', 'Deepak Gupta', '305'
'105', 'Naina Rao', '304' */

Select c.Customer_Name, Count(o.Order_ID) as TotalOrders from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID Group by c.Customer_name;

/* # Customer_Name, TotalOrders
'Amit Jain', '1'
'Amar Tyagi', '1'
'Bhanu Prasant', '1'
'Deepak Gupta', '1'
'Naina Rao', '1' */

Select c.Customer_Name from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID where Order_ID is NULL;

-- Customer_Name

Select c.Customer_Name, o.Order_Date from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID;

/* # Customer_Name, Order_Date
'Amit Jain', '2024-09-19'
'Amar Tyagi', '2025-04-06'
'Bhanu Prasant', '2025-08-21'
'Deepak Gupta', '2025-08-15'
'Naina Rao', '2025-04-01' */
 
/* 3: Right Outer Join – 
      Find all orders and their corresponding customers, even if an order doesn't have a customer associated with it.
      Show all orders with the customer names.
      Display product names with the customers who ordered them.
	  List order IDs with customer cities.
      Find the number of orders per customer (include those without orders).
	  Retrieve customers who do not have any matching orders.
     Write your code below this line along with the output 
 */

Select o.Order_ID, c.Customer_Name from Orders o Right Join Customers c On o.Customer_ID = c.Customer_ID;

/* # Order_ID, Customer_Name
'302', 'Amit Jain'
'301', 'Amar Tyagi'
'303', 'Bhanu Prasant'
'305', 'Deepak Gupta'
'304', 'Naina Rao' */

Select o.Order_ID, c.Customer_Name from Orders o Right Join Customers c On o.Customer_ID = c.Customer_ID;

/* # Order_ID, Customer_Name
'302', 'Amit Jain'
'301', 'Amar Tyagi'
'303', 'Bhanu Prasant'
'305', 'Deepak Gupta'
'304', 'Naina Rao' */

Select o.Product_Name, c.Customer_Name from Orders o Right Join Customers c On o.Customer_ID = c.Customer_ID;

/* # Product_Name, Customer_Name
'Text Book', 'Amit Jain'
'Towel', 'Amar Tyagi'
'Hair Care', 'Bhanu Prasant'
'Groceries', 'Deepak Gupta'
'Clothes', 'Naina Rao' */

Select o.Order_ID, c.City from Orders o Right Join Customers c On o.Customer_ID = c.Customer_ID;

/* # Order_ID, City
'302', 'Bangalore'
'301', 'Mysore'
'303', 'Mysore'
'305', 'Bangalore'
'304', 'Bangalore' */

Select Count(o.Order_ID), c.Customer_Name from Orders o Right Join Customers c On o.Customer_ID = c.Customer_ID Group by c.Customer_Name;

/* # Count(o.Order_ID), Customer_Name
'1', 'Amit Jain'
'1', 'Amar Tyagi'
'1', 'Bhanu Prasant'
'1', 'Deepak Gupta'
'1', 'Naina Rao' */

Select c.Customer_Name from Orders o Right Join Customers c On o.Customer_ID = c.Customer_ID where o.Order_ID is NULL;

-- Customer_Name

/* 4: Full Outer Join – 
        Find all customers and their orders, including those customers with no orders and orders without a customer.
        List all customers and products, whether they placed an order or not.
        Show customer IDs with order IDs (include unmatched ones).
		Display customer names with order dates.
		Find all unmatched records (customers without orders and orders without customers).
        Show customer cities with products.
     Write your code below this line along with the output 
  */   
  
Select c.Customer_Name, o.Order_ID from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID
UNION
Select c.Customer_Name, o.Order_ID from Orders o Right Join Customers c On c.Customer_ID = o.Customer_ID;

/* # Customer_Name, Order_ID
'Amit Jain', '302'
'Amar Tyagi', '301'
'Bhanu Prasant', '303'
'Deepak Gupta', '305'
'Naina Rao', '304' */

Select c.Customer_Name, o.Order_ID from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID
UNION
Select c.Customer_Name, o.Order_ID from Orders o Right Join Customers c On c.Customer_ID = o.Customer_ID;

/* # Customer_Name, Order_ID
'Amit Jain', '302'
'Amar Tyagi', '301'
'Bhanu Prasant', '303'
'Deepak Gupta', '305'
'Naina Rao', '304' */

Select c.Customer_ID, o.Order_ID from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID
UNION
Select c.Customer_ID, o.Order_ID from Orders o Right Join Customers c On c.Customer_ID = o.Customer_ID;

/* # Customer_ID, Order_ID
'101', '302'
'102', '301'
'103', '303'
'104', '305'
'105', '304' */

Select c.Customer_Name, o.Order_Date from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID
UNION
Select c.Customer_Name, o.Order_Date from Orders o Right Join Customers c On c.Customer_ID = o.Customer_ID;

/* # Customer_Name, Order_Date
'Amit Jain', '2024-09-19'
'Amar Tyagi', '2025-04-06'
'Bhanu Prasant', '2025-08-21'
'Deepak Gupta', '2025-08-15'
'Naina Rao', '2025-04-01' */

Select c.Customer_Name, o.Order_Date from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID where o.Order_ID is NULL
UNION
Select c.Customer_Name, o.Order_Date from Orders o Right Join Customers c On c.Customer_ID = o.Customer_ID where c.Customer_ID is NULL;

-- Customer_Name, Order_Date

Select c.City, o.Product_Name from Customers c Left Join Orders o On c.Customer_ID = o.Customer_ID
UNION
Select c.City, o.Product_Name from Orders o Right Join Customers c On c.Customer_ID = o.Customer_ID;

/* # City, Product_Name
'Bangalore', 'Text Book'
'Mysore', 'Towel'
'Mysore', 'Hair Care'
'Bangalore', 'Groceries'
'Bangalore', 'Clothes' */
  
/* 5: Natural Join – 
          Find all orders placed by customers.
          List all customers with the products they ordered using NATURAL JOIN.
          Show customer names along with their order dates using NATURAL JOIN.
          Find all customer cities and the products ordered by those customers using NATURAL JOIN.

     Write your code below this line along with the output 
*/

Select * from Customers Join Orders where Customers.Customer_ID = Orders.Customer_ID;

/* # Customer_ID, Customer_Name, City, Order_ID, Customer_ID, Product_Name, Order_Date
'101', 'Amit Jain', 'Bangalore', '302', '101', 'Text Book', '2024-09-19'
'102', 'Amar Tyagi', 'Mysore', '301', '102', 'Towel', '2025-04-06'
'103', 'Bhanu Prasant', 'Mysore', '303', '103', 'Hair Care', '2025-08-21'
'104', 'Deepak Gupta', 'Bangalore', '305', '104', 'Groceries', '2025-08-15'
'105', 'Naina Rao', 'Bangalore', '304', '105', 'Clothes', '2025-04-01' */

Select Customer_Name, Product_name from Customers Join Orders where Customers.Customer_ID = Orders.Customer_ID;

/* # Customer_Name, Product_name
'Amit Jain', 'Text Book'
'Amar Tyagi', 'Towel'
'Bhanu Prasant', 'Hair Care'
'Deepak Gupta', 'Groceries'
'Naina Rao', 'Clothes'
*/

Select Customer_Name, Order_Date from Customers Join Orders where Customers.Customer_ID = Orders.Customer_ID;

/* # Customer_Name, Order_Date
'Amit Jain', '2024-09-19'
'Amar Tyagi', '2025-04-06'
'Bhanu Prasant', '2025-08-21'
'Deepak Gupta', '2025-08-15'
'Naina Rao', '2025-04-01'
*/

Select City, Product_Name from Customers Join Orders where Customers.Customer_ID = Orders.Customer_ID;

/* # City, Product_Name
'Bangalore', 'Text Book'
'Mysore', 'Towel'
'Mysore', 'Hair Care'
'Bangalore', 'Groceries'
'Bangalore', 'Clothes'
*/

  -- END OF THE EXPERIMENT