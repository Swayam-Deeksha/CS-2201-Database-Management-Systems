-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 03: Implementation of different types of SQL functions.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Swayam Deeksha R B
-- USN: 1RUA24BCA0090
-- SECTION: A
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command

-- 'root@localhost', 'SwayamDeeksha', '8.4.6', '2025-09-08 11:31:57'

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- PreCoded Relational Schema and Instance.
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- 1. create a table named Employee with EmpID ,FirstName,LastName Salary BirthDate HireDate 

Create database Company;
use Company;

create table Employee (
EmpID varchar(10) Primary Key,
FirstName varchar(30),
LastName varchar(30),
Salary int,
BirthDate date,
HireDate date );

-- 2. Insert 10 records to employee;

Insert into Employee values (01, "John", "Doe", 80000, '1996-02-20', '2020-04-03');
Insert into Employee values (02, "David", "Jones", 95000, '1989-05-06', '2019-06-02');
Insert into Employee values (03, "James", "Hunt", 75000, '1989-07-19', '2020-03-06');
Insert into Employee values (04, "William", "Smith", 85000, '1992-06-09', '2020-04-08');
Insert into Employee values (05, "Mary", "Stunt", 90000, '1988-05-07', '2020-06-07');
Insert into Employee values (06, "Adam", "Will", 76000, '1996-06-05', '2018-05-29');
Insert into Employee values (07, " Eve", "Poe", 95000, '1993-05-09', '2019-06-24');
Insert into Employee values (08, "Anna", "Kat", 89000, '1994-07-09', '2021-03-06');
Insert into Employee values (09, "Eliza", "Don", 78000, '1996-05-09', '2021-06-09');
Insert into Employee values (10, "Peter", "Parker", 80000, '1995-06-08', '2023-05-19');

-- 3. create a table named Orders with OrderID , OrderDate, totalAmount, EmpID(foreign key) 

Create table Orders (
OrderID varchar(10) Primary Key,
OrderDate date,
TotalAmount int,
EmpID varchar(10),
Foreign Key(EmpID) references Employee(EmpID)); 

-- 4. Insert 10 records to Orders

Insert into Orders values ("OD1", '2025-06-04', 500, 02);
Insert into Orders values ("OD2", '2025-08-19', 2500, 05);
Insert into Orders values ("OD3", '2025-08-04', 1200, 10);
Insert into Orders values ("OD4", '2025-06-04', 6500, 03);
Insert into Orders values ("OD5", '2025-06-04', 1750, 08);
Insert into Orders values ("OD6", '2025-06-04', 600, 04);
Insert into Orders values ("OD7", '2025-06-04', 8000, 06);
Insert into Orders values ("OD8", '2025-06-04', 900, 01);
Insert into Orders values ("OD9", '2025-06-04', 870, 09);
Insert into Orders values ("OD10", '2025-06-04', 950, 07);

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Print the Information of the Employee and Order Table. [ Hint: SELECT * FROM TABLENAME ]
-- Write the SQL Query below this line.

Select * from Employee;
Select * from Orders;

-- Output: 

/* '1', 'John', 'Doe', '80000', '1996-02-20', '2020-04-03'
'10', 'Peter', 'Parker', '80000', '1995-06-08', '2023-05-19'
'2', 'David', 'Jones', '95000', '1989-05-06', '2019-06-02'
'3', 'James', 'Hunt', '75000', '1989-07-19', '2020-03-06'
'4', 'William', 'Smith', '85000', '1992-06-09', '2020-04-08'
'5', 'Mary', 'Stunt', '90000', '1988-05-07', '2020-06-07'
'6', 'Adam', 'Will', '76000', '1996-06-05', '2018-05-29'
'7', ' Eve', 'Poe', '95000', '1993-05-09', '2019-06-24'
'8', 'Anna', 'Kat', '89000', '1994-07-09', '2021-03-06'
'9', 'Eliza', 'Don', '78000', '1996-05-09', '2021-06-09' */

/* 'OD1', '2025-06-04', '500', '2'
'OD10', '2025-06-04', '950', '7'
'OD2', '2025-08-19', '2500', '5'
'OD3', '2025-08-04', '1200', '10'
'OD4', '2025-06-04', '6500', '3'
'OD5', '2025-06-04', '1750', '8'
'OD6', '2025-06-04', '600', '4'
'OD7', '2025-06-04', '8000', '6'
'OD8', '2025-06-04', '900', '1'
'OD9', '2025-06-04', '870', '9' */

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Number Functions Section
-- ------------------------------------------------------------
/* a. Round Salaries: Round employee salaries to nearest integer */

Select Round(Salary) As RoundSalary From Employee;

-- Output: 

/* '80000'
'80000'
'95000'
'75000'
'85000'
'90000'
'76000'
'95000'
'89000'
'78000' */

/* b. Absolute Values: Show absolute values of salaries */

Select Abs(Salary) As AbsoluteSalary From Employee;

-- Output: 

/* '80000'
'80000'
'95000'
'75000'
'85000'
'90000'
'76000'
'95000'
'89000'
'78000' */ 

/* c. Ceiling Values: Get ceiling values of order amounts */

Select Ceiling(TotalAmount) as CeilingAmount from Orders;

-- Output: 

/* '500'
'950'
'2500'
'1200'
'6500'
'1750'
'600'
'8000'
'900'
'870' */

-- ------------------------------------------------------------
-- Aggregate Functions Section
-- ------------------------------------------------------------
/* a. Count of Employees: Find total number of employees */

Select count(*) as TotalEmployees from Employee;

-- Output: 

-- '10'

/* b. Sum of Salaries: Calculate total salary expense */

Select Sum(Salary) as TotalSalaries from Employee;

-- Output: 

-- '843000'

/* c. Average Order Amount: Find average order value */

Select Avg(TotalAmount) as AverageOrderValue from Orders;

-- Output: 

-- '2377.0000'

/* d. Max/Min Salary: Find highest and lowest salaries */

Select Min(Salary) As MinSalary from Employee;
Select Max(Salary) As MaxSalary from Employee;

-- Output: 

/* # MinSalary
'75000' */

/* # MaxSalary
'95000' */

-- ------------------------------------------------------------
-- Character Functions Section
-- ------------------------------------------------------------
/* a. Case Conversion: Show names in uppercase and lowercase */

Select Upper(FirstName) As UpperFirstName from Employee;
Select Lower(LastName) As LowerLastName from Employee;

-- Output: 

/* 'JOHN'
'PETER'
'DAVID'
'JAMES'
'WILLIAM'
'MARY'
'ADAM'
' EVE'
'ANNA'
'ELIZA' */

/* 'doe'
'parker'
'jones'
'hunt'
'smith'
'stunt'
'will'
'poe'
'kat'
'don' */

/* b. Concatenate Names: Create full names */

Select Concat(FirstName, LastName) As FullName from Employee;

-- Output: 

/* 'JohnDoe'
'PeterParker'
'DavidJones'
'JamesHunt'
'WilliamSmith'
'MaryStunt'
'AdamWill'
' EvePoe'
'AnnaKat'
'ElizaDon' */

/* c. Extract Substring: Get first 3 characters of first names */

Select substr(FirstName, 1, 3) from Employee; 

-- Output: 

/* 'Joh'
'Pet'
'Dav'
'Jam'
'Wil'
'Mar'
'Ada'
' Ev'
'Ann'
'Eli' */

-- ------------------------------------------------------------
-- Conversion Functions Section
-- ------------------------------------------------------------
/* Convert String to Date: Convert DATE to string type */

Select Cast(OrderDate AS Char) As ConvertedDate from Orders;

-- Output: 

/* '2025-06-04'
'2025-06-04'
'2025-08-19'
'2025-08-04'
'2025-06-04'
'2025-06-04'
'2025-06-04'
'2025-06-04'
'2025-06-04'
'2025-06-04' */

-- ------------------------------------------------------------
-- Date Functions Section
-- ------------------------------------------------------------
/* a. Current Date/Time: Get current timestamp */

Select now();

-- Output: 

-- '2025-09-08 12:45:05'

/* b. Extract Year: Get year from order dates */

Select Extract(Year From OrderDate) As OrderYear from Orders;

-- Output: 

/* '2025'
'2025'
'2025'
'2025'
'2025'
'2025'
'2025'
'2025'
'2025'
'2025' */

/* c. Add Months: Add 3 months to order dates */

Select Date_Add(OrderDate, Interval 3 Month) as FinalDate from Orders;

-- Output: 

/* '2025-09-04'
'2025-09-04'
'2025-11-19'
'2025-11-04'
'2025-09-04'
'2025-09-04'
'2025-09-04'
'2025-09-04'
'2025-09-04'
'2025-09-04' */

/* d. Days Since Order: Calculate days between order date and now */

Select OrderID, datediff(Now(), OrderDate) As DaysSinceOrder from Orders;

-- Output: 

/* 'OD1', '96'
'OD10', '96'
'OD2', '20'
'OD3', '35'
'OD4', '96'
'OD5', '96'
'OD6', '96'
'OD7', '96'
'OD8', '96'
'OD9', '96' */

-- END of the Task -- 