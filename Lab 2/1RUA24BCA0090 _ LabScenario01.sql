-- Lab Experiment 01: Implementation of DDL Commands in SQL for the given scenarios
-- STUDENT NAME: Swayam Deeksha R B
-- USN: 1RUA24BCA0090
-- SECTION: A

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
'root@localhost', 'SwayamDeeksha', '8.4.6', '2025-08-25 11:27:40';

-- Scenario: College Student Management System

-- CREATE AND LOAD THE database
-- Write your SQL query below Codespace:

create database CollegeStudentManagementSystem;
use CollegeStudentManagementSystem;

-- Task 1: Create the Tables under this system (min 5 tables)
  -- Table 01: Departments ( DepartmentID, DepartmentName, HOD,ContactEmail,PhoneNumber,Location )
  -- Table 02: Course (CourseID, CourseName,Credits,DepartmentID,Duration,Fee )
  -- Table 03: Students (StudentID,FirstName,LastName,Email,DateOfBirth,CourseID)
  -- Table 04: Faculty FacultyID,FacultyName,DepartmentID,Qualification,Email,PhoneNumber)
  -- Table 05: Enrollments (  EnrollmentID,StudentID,CourseID,Semester,Year,Grade)
-- Specify the Key (Primary and Foreign) for each table while creating

-- Write your SQL query below Codespace:

create table Departments (
DepartmentID varchar(10) Primary key,
DepartmentName varchar(20),
HOD varchar(40),
ContactEmail varchar(50) unique,
PhoneNumber Numeric(10),
Location varchar(60));

create table Course (
CourseID varchar(6) primary key,
CourseName Varchar(20),
Credits int,
DepartmentID varchar(10),
Duration Numeric(2,2),
Fee Numeric(5),
Foreign key(DepartmentID) references Department(DepartmentID)) ;

create table Students (
StudentID varchar(10) Primary key,
FirstName varchar(30),
LastName varchar(30),
Email varchar(30) unique,
DateOfBirth date,
CourseID varchar(6),
foreign key(CourseID) references Course(CourseID));

create table Faculty (
FacultyID varchar(10) primary key,
FacultyName varchar(20),
DepartmentID varchar(10),
Qualification varchar(20),
Email varchar(40) unique,
PhoneNumber numeric(10),
Foreign key(DepartmentID) references Department(DepartmentID));

create table  Enrollments (
EnrollmentID varchar(20) primary key,
StudentID varchar(10),
CourseID varchar(6),
Semester int,
YearofStudy int,
Grade varchar(2),
foreign key(StudentID) references Students(StudentID),
foreign key(CourseID) references Course(CourseID));

-- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code
--  describe the structure of each table and copy paste the Output 

desc Departments;

/* 
'DepartmentID', 'varchar(10)', 'NO', 'PRI', NULL, ''
'DepartmentName', 'varchar(20)', 'YES', '', NULL, ''
'HOD', 'varchar(40)', 'YES', '', NULL, ''
'ContactEmail', 'varchar(50)', 'YES', 'UNI', NULL, ''
'PhoneNumber', 'decimal(10,0)', 'YES', '', NULL, ''
'Location', 'varchar(60)', 'YES', '', NULL, ''
*/

desc Course;

/* 
'CourseID', 'varchar(6)', 'NO', 'PRI', NULL, ''
'CourseName', 'varchar(20)', 'YES', '', NULL, ''
'Credits', 'int', 'YES', '', NULL, ''
'DepartmentID', 'varchar(10)', 'YES', 'MUL', NULL, ''
'Duration', 'numeric(2,2)', 'YES', '', NULL, ''
'Fee', 'numeric(5,0)', 'YES', '', NULL, ''
*/

desc Students;

/* 
'StudentID', 'varchar(10)', 'NO', 'PRI', NULL, ''
'FirstName', 'varchar(30)', 'YES', '', NULL, ''
'LastName', 'varchar(30)', 'YES', '', NULL, ''
'Email', 'varchar(30)', 'YES', 'UNI', NULL, ''
'DateOfBirth', 'date', 'YES', '', NULL, ''
'CourseID', 'varchar(6)', 'YES', 'MUL', NULL, ''
*/

desc Faculty;

/* 
'FacultyID', 'varchar(10)', 'NO', 'PRI', NULL, ''
'FacultyName', 'varchar(20)', 'YES', '', NULL, ''
'DepartmentID', 'varchar(10)', 'YES', 'MUL', NULL, ''
'Qualification', 'varchar(20)', 'YES', '', NULL, ''
'Email', 'varchar(40)', 'YES', 'UNI', NULL, ''
'PhoneNumber', 'decimal(10,0)', 'YES', '', NULL, ''
*/

desc Enrollments;

/* 
'EnrollmentID', 'varchar(20)', 'NO', 'PRI', NULL, ''
'StudentID', 'varchar(10)', 'YES', 'MUL', NULL, ''
'CourseID', 'varchar(6)', 'YES', 'MUL', NULL, ''
'Semester', 'int', 'YES', '', NULL, ''
'YearofStudy', 'int', 'YES', '', NULL, ''
'Grade', 'varchar(2)', 'YES', '', NULL, ''
*/

-- Perform the following operations on the each of the tables
-- 01: add 2 new columns for each table
-- 02: Modify the existing column from each table
-- 03 change the datatypes
-- 04: Rename a column
-- 05: Drop a column
-- 06: Rename the table
-- 07: describe the structure of the new table

-- Task 01
alter table Departments add(EstablishedYear int, Website varchar(100));
alter table Course add(CourseType varchar(20), Language varchar(20));
alter table Students add(Gender varchar(10), EnrollmentDate date);
alter table Faculty add(ExperienceYears int, OfficeLocation varchar(50));
alter table Enrollments add(AttendancePercent decimal(5,2), Remarks varchar(50));

-- Task 02
alter table Departments modify DepartmentName varchar(30);
alter table Course modify Credits decimal;
alter table Students modify Email varchar(50);
alter table Faculty modify Qualification varchar(30);
alter table Enrollments modify Grade varchar(3);

-- Task 03
alter table Departments modify PhoneNumber int;
alter table Course modify Fee decimal(7,2);
alter table Students modify DateOfBirth datetime;
alter table Faculty modify PhoneNumber varchar(15);
alter table Enrollments modify YearofStudy decimal;

-- Task 04 
alter table Departments rename column HOD to HeadOfDepartment;
alter table Course rename column Duration to CourseDuration;
alter table Students rename column FirstName to GivenName;
alter table Faculty rename column FacultyName to Name;
alter table Enrollments rename column Semester to Term;

-- Task 05
alter table Departments drop column Location;
alter table Course drop column Language;
alter table Students drop column Gender;
alter table Faculty drop column OfficeLocation;
alter table Enrollments drop column Remarks;

-- Task 06
rename table Departments to Dept;
rename table Course to Courses;
rename table Students to Learners;
rename table Faculty to Professors;
rename table Enrollments to CourseEnrollments;

-- Task 07
desc Dept;
desc Courses;
desc Learners;
desc Professors;
desc CourseEnrollments;

/*  Additional set of questions 
--1 Add a new column Address (VARCHAR(100)) to the Students table.
--2 Add a column Gender (CHAR(1)) to the Students table.
--3 Add a column JoiningDate (DATE) to the Faculty table.
--4 Modify the column CourseName in the Courses table to increase its size from VARCHAR(50) to VARCHAR(100).
--5 Modify the column Location in the Departments table to VARCHAR(80).
--6 Rename the column Qualification in the Faculty table to Degree.
--7 Rename the table Faculty to Teachers.
--8 Drop the column PhoneNumber from the Departments table.
--9 Drop the column Email from the Students table.
--10 Drop the column Duration from the Courses table.
*/

-- Additional Task 01
alter table Learners add(Address varchar(100));

-- Additional Task 02
alter table Learners add(Gender char(1));

-- Additional Task 03
alter table Professors add(JoiningDate date);

-- Additional Task 04
alter table Courses modify CourseName varchar(100);

-- Additional Task 05
alter table Dept modify Location varchar(80);

-- Additional Task 06
alter table Professors rename column Qualification to Degree;

-- Additional Task 07
rename table Professors to Teachers;

-- Additional Task 08
alter table Dept drop column PhoneNumber;

-- Additional Task 09
alter table Learners drop column Email;

-- Additional Task 10
alter table Courses drop column CourseDuration;

SHOW TABLES; -- Before dropping the table

/*
'courseenrollments'
'courses'
'dept'
'learners'
'teachers'
*/

-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:

drop table Courses;
drop table CourseEnrollments;

SHOW TABLES; -- After dropping the table Enrollement and Course

/*
'dept'
'learners'
'teachers'
*/

-- Note: Perform the specified operations on all the 5 tables in the system
-- End of Lab Experiment 01