Create database EmployeesDB;
Use EmployeesDB;

Create table Departments (
DeptID int primary key,
DeptName varchar(50));

Create table Employees (
EmpID int primary key,
EmpName varchar(100),
DeptID int,
JoinDate date,
Foreign Key(DeptID) references Departments(DeptID));

Create table Salaries (
SalaryID int primary key,
EmpID int,
Basic decimal(10, 2),
Allowance decimal(10, 2),
Deductions decimal(10, 2),
EffectiveDate date,
Foreign Key(EmpID) references Employees(EmpID));

Insert into Departments values (1, 'Engineering'), (2, 'HR'), (3, 'Finance');

Insert into Employees values
(101, 'Alice', 1, '2022-01-15'),
(102, 'Bob', 2, '2021-03-10'),
(103, 'Charlie', 1, '2023-07-01'),
(104, 'Diana', 3, '2020-11-20');

Insert into Salaries values
(1001, 101, 50000, 10000, 5000, '2023-01-01'),
(1002, 102, 40000, 8000, 3000, '2023-01-01'),
(1003, 103, 55000, 12000, 6000, '2023-01-01'),
(1004, 104, 60000, 15000, 7000, '2023-01-01');

Select d.DeptName, Sum(s.Basic +s.Allowance - s.Deductions) as TotalSalary
from Salaries s inner join Employees e on s.EmpID = e.EmpID
inner join Departments d on e.DeptID = d.DeptID
group by d.DeptName;
/* # DeptName, TotalSalary
'Engineering', '116000.00'
'HR', '45000.00'
'Finance', '68000.00' */

Select d.DeptName, avg(s.Basic) as AvgBasicSalary from Salaries s
inner join Employees e on s.EmpID = e.EmpID inner join
Departments d on e.DeptID = d.DeptID
group by d.DeptName;
/* # DeptName, AvgBasicSalary
'Engineering', '52500.000000'
'HR', '40000.000000'
'Finance', '60000.000000' */

Select e.EmpID, e.EmpName, d.DeptName, e.JoinDate from Employees e
inner join Departments d on e.DeptID = d.DeptID;
/* # EmpID, EmpName, DeptName, JoinDate
'101', 'Alice', 'Engineering', '2022-01-15'
'103', 'Charlie', 'Engineering', '2023-07-01'
'102', 'Bob', 'HR', '2021-03-10'
'104', 'Diana', 'Finance', '2020-11-20' */

Delimiter //
Create Procedure InsertSalary (
in p_SalaryID int,
in p_EmpID int,
in p_Basic Decimal(10, 2),
in p_Allowance Decimal(10, 2),
in p_Deductions Decimal(10, 2),
in p_EffectiveDate date)
Begin
insert into Salaries (SalaryID, EmpID, Basic, Allowance, Deductions, EffectiveDate)
values (p_SalaryID, p_EmpID, p_Basic, p_Allowance, p_Deductions, p_EffectiveDate);
End //
Delimiter ;

Call InsertSalary (1005, 101, 60000, 15000, 2500, '2023-05-01');

Delimiter //
Create procedure UpdateSalary (
in p_SalaryID int,
in p_Basic decimal(10, 2),
in p_Allowance decimal(10, 2),
in p_Deductions decimal(10, 2))
Begin
Update Salaries
set Basic = p_Basic,
Allowance = p_Allowance,
Deductions = p_Deductions
where SalaryID = p_SalaryID;
End //
Delimiter ;

Call UpdateSalary (1002, 55000, 12000, 6000);