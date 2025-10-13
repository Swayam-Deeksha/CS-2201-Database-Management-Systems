-- Lab Experiment 08: Implementation of Procedure ( insert, update and delete)
-- STUDENT NAME: Swayam Deeksha R B
-- USN: 1RUA24BCA0090
-- SECTION: A

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- 'root@localhost', 'SwayamDeeksha', '8.4.6', '2025-10-13 11:38:04'

-- Scenario: Employee Management System
-- CREATE AND LOAD THE database DBLab008
-- Write your SQL query below Codespace:

Create Database DBLab008;
Use DBLab008;

-- Task 1: Create the Employee Table
-- Create a table to store information about Employee.
-- Include the following columns:
 --   empid INT PRIMARY KEY,
   -- empname VARCHAR(50),
   -- age INT,
   -- salary DECIMAL(10,2),
   -- designation VARCHAR(30),
   -- address VARCHAR(100),
   -- date_of_join DATE
   
-- Write your SQL query below Codespace:

Create table Employee (
EmpID int Primary Key,
EmpName Varchar(50),
Age int,
Salary decimal(10,2),
Designation Varchar(30),
Address Varchar(100),
DateOfJoin Date);

-- DESCRIBE THE SCHEMA -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

desc Employee;

-- OUTPUT : Disclaimer - This code is not the part of the SQL Code

/* # Field, Type, Null, Key, Default, Extra
'EmpID', 'int', 'NO', 'PRI', NULL, ''
'EmpName', 'varchar(50)', 'YES', '', NULL, ''
'Age', 'int', 'YES', '', NULL, ''
'Salary', 'decimal(10,2)', 'YES', '', NULL, ''
'Designation', 'varchar(30)', 'YES', '', NULL, ''
'Address', 'varchar(100)', 'YES', '', NULL, ''
'DateOfJoin', 'date', 'YES', '', NULL, '' */

-- insert 10 records to the table 
-- Write your SQL query below Codespace:

Insert into Employee values
(1, "Anil", 30, 120000, "Data Analyst", "Bengaluru, Karnataka", '2021-05-16'),
(2, "Sneha", 28, 95000, "Software Engineer", "Pune, Maharashtra", '2022-01-10'),
(3, "Rahul", 35, 135000, "Project Manager", "Hyderabad, Telangana", '2020-08-25'),
(4, "Priya", 26, 88000, "UI/UX Designer", "Chennai, Tamil Nadu", '2023-03-05'),
(5, "Vikram", 32, 110000, "DevOps Engineer", "Mumbai, Maharashtra", '2019-11-30'),
(6, "Neha", 29, 102000, "QA Analyst", "Kolkata, West Bengal", '2021-07-18'),
(7, "Arjun", 31, 125000, "Backend Developer", "Bengaluru, Karnataka", '2020-02-14'),
(8, "Divya", 27, 97000, "Frontend Developer", "Ahmedabad, Gujarat", '2022-06-22'),
(9, "Karan", 34, 140000, "Solution Architect", "Delhi", '2018-09-12'),
(10, "Meera", 30, 115000, "Business Analyst", "Jaipur, Rajasthan", '2021-12-01');

Select * from Employee;

-- COPYPASTE OF THE OUTPUT in CSV Format and terminate with ;

/* '1', 'Anil', '30', '120000.00', 'Data Analyst', 'Bengaluru, Karnataka', '2021-05-16'
'2', 'Sneha', '28', '95000.00', 'Software Engineer', 'Pune, Maharashtra', '2022-01-10'
'3', 'Rahul', '35', '135000.00', 'Project Manager', 'Hyderabad, Telangana', '2020-08-25'
'4', 'Priya', '26', '88000.00', 'UI/UX Designer', 'Chennai, Tamil Nadu', '2023-03-05'
'5', 'Vikram', '32', '110000.00', 'DevOps Engineer', 'Mumbai, Maharashtra', '2019-11-30'
'6', 'Neha', '29', '102000.00', 'QA Analyst', 'Kolkata, West Bengal', '2021-07-18'
'7', 'Arjun', '31', '125000.00', 'Backend Developer', 'Bengaluru, Karnataka', '2020-02-14'
'8', 'Divya', '27', '97000.00', 'Frontend Developer', 'Ahmedabad, Gujarat', '2022-06-22'
'9', 'Karan', '34', '140000.00', 'Solution Architect', 'Delhi', '2018-09-12'
'10', 'Meera', '30', '115000.00', 'Business Analyst', 'Jaipur, Rajasthan', '2021-12-01' */

-- perform the following procedures on the employee database and copy paste the output in the space provided
-- A. Insert Procedure

-- 1. Write a stored procedure named InsertEmployee to insert a new employee record into the Employee table with all fields as input parameters.
-- 2. Modify the insert procedure to ensure the employee’s age must be between 18 and 60.
      -- If not, display a message: "Invalid age, employee not added."
-- 3. Create a procedure that inserts a new employee record.
          -- If the salary is not provided, assign a default salary of 20000.
-- 4. Write a procedure that inserts three new employee records in a single procedure using multiple INSERT statements.

-- A. 1
Delimiter //
Create Procedure InsertEmployee (
In P_ID int,
In P_Name varchar(50),
In P_Age int,
In P_Salary Decimal(10,2),
In P_Designation Varchar(30),
In P_Address Varchar(100),
In P_DateOfJoin date
)
Begin
	Insert into Employee Values (P_ID, P_Name, P_Age, P_Salary, P_Designation, P_DateOfJoin);
End //
Delimiter ;

-- A.2
Delimiter //
Create Procedure InsertEmployeeWithAgeCheck (
In P_ID int,
In P_Name varchar(50),
In P_Age int,
In P_Salary Decimal(10,2),
In P_Designation Varchar(30),
In P_Address Varchar(100),
In P_DateOfJoin date
)
Begin
	If P_Age between 18 And 60 Then
		Insert into Employee Values (P_ID, P_Name, P_Age, P_Salary, P_Designation, P_DateOfJoin);
	else
		Select 'Invalid Age, Employee Not Added.' As Message;
	End if;
End //
Delimiter ;

-- A.3
Delimiter //
Create Procedure InsertEmployeeWithDefaultSalary (
In P_ID int,
In P_Name varchar(50),
In P_Age int,
In P_Salary Decimal(10,2),
In P_Designation Varchar(30),
In P_Address Varchar(100),
In P_DateOfJoin date
)
Begin
	If P_Salary is Null Then
		Set P_Salary = 20000;
	End if;
    Insert into Employee Values (P_ID, P_Name, P_Age, P_Salary, P_Designation, P_DateOfJoin);
End //
Delimiter ;

-- A.4
Delimiter //
Create Procedure InsertThreeEmployee ()
Begin
	Insert into Employee Values (11, 'Ravi', 29, 95000, 'Tester', 'Surat,Gujarat', '2023-04-10');
    Insert into Employee Values (12, 'Ananya', 33, 105000, 'Manager', 'Bhopal, Madhya Pradesh', '2022-09-15');
    Insert into Employee Values (13, 'Tarun', 25, 87000, 'Support Engineer', 'Lucknow, Uttar Pradesh', '2024-01-20');
End //
Delimiter ;

-- B.  Update Procedure
/*
Update Salary:
Write a stored procedure named UpdateSalary to update an employee’s salary based on their empid.

Increment Salary by Percentage:
Create a procedure to increase the salary by 10% for all employees whose designation = 'Manager'.

Update Designation:
Write a procedure to update the designation of an employee by empid.
Example: Promote an employee from 'Clerk' to 'Senior Clerk'.

Update Address:
Write a procedure to update the address of an employee when empid is given as input.

Conditional Update (Age Check):
Create a procedure that updates salary only if the employee’s age > 40; otherwise, print "Not eligible for salary update."

*/

-- B.1

Delimiter //
Create Procedure UpdateSalary (
	In P_EmpID int,
    In P_New_Salary Decimal(10,2)
)
Begin
	Update Employee Set Salary = P_New_Salary where ID = P_EmpID;
End //
Delimiter ;

-- B.2

Delimiter //
Create Procedure IncrementManagerSalary ()
Begin
	Update Employee Set Salary = Salary * 1.10 Where Designation = 'Manager';
End //
Delimiter ;

-- B.3

Delimiter //
Create Procedure UpdateDesignation (
	In P_EmpID int,
    In P_New_Designation Varchar(50)
)
Begin
	Update Employee Set Designation = P_New_Designation where ID = P_EmpID;
End //
Delimiter ;

-- B.4
Delimiter //
Create Procedure UpdateAddress (
	In P_EmpID int,
    In P_New_Address Varchar(100)
)
Begin
	Update Employee Set Address = P_New_Address where ID = P_EmpID;
End //
Delimiter ;

-- B.5
Delimiter //
Create Procedure ConditionalSalaryUpdate (
	In P_EmpID int,
    In P_New_Salary Decimal(10,2)
)
Begin
	Declare Emp_Age int;
    Select Age into Emp_Age from Employee where ID = P_EmpID;
    If Emp_Age > 40 Then
		Update Employee Set Salary = P_New_Salary Where ID = P_EmpID;
	Else 
		Select 'Not Eligible for Salary Update.' As Message;
	End if;
End //
Delimiter ;

-- C. Delete Procedure
/*
Delete by empid:
Write a stored procedure named DeleteEmployee to delete an employee record using their empid.

Delete by Designation:
Create a procedure that deletes all employees belonging to a specific designation (e.g., 'Intern').

Delete Based on Salary Range:
Write a procedure to delete employees whose salary is less than ₹15000.

Delete by Joining Year:
Write a procedure to delete employees who joined before the year 2015.
*/

-- C.1
Delimiter //
Create Procedure DeleteEmployee (
	In P_EmpID int
)
Begin
	Delete from Employee where ID = P_EmpID;
End //
Delimiter ;

-- C.2
Delimiter //
Create Procedure DeleteByDesignation (
	In P_Designation Varchar(50)
)
Begin
	Delete from Employee where Designation = P_Designation;
End //
Delimiter ;

-- C.3
Delimiter //
Create Procedure DeleteLowSalaryEmployee ()
Begin
	Delete From Employee where Salary < 15000;
End //
Delimiter ;

-- C.4
Delimiter //
Create Procedure DeleteOldEmployee ()
Begin
	Delete from Employee where Year(DateOfJoin) < 2015;
End //
Delimiter ;

-- End of Lab Experiment 
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment08