-- Lab Experiment 01: Implementation of DDL Commands in SQL
-- STUDENT NAME: Swayam Deeksha
-- USN: 1RUA24BCA0090
-- SECTION: A

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

'root@localhost', 'SwayamDeeksha', '8.4.6', '2025-08-18 11:32:42';


-- Scenario: University Course Management System
-- CREATE AND LOAD THE database DBLab001
-- Write your SQL query below Codespace:

create database DBLab001;
use DBLab001;

-- Task 1: Create the Students Table
-- Create a table to store information about students.
-- Include the following columns:
-- 1. StudentID (Primary Key)
-- 2. FirstName
-- 3. LastName
-- 4. Email (Unique Constraint)
-- 5. DateOfBirth

-- Write your SQL query below Codespace:

create table Students
( StudentID varchar(10) Primary Key,
FirstName varchar(20),
LastName varchar(20),
Email varchar(40) unique,
DOB date);

DESC STUDENTS; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code

/* 'StudentID', 'varchar(10)', 'NO', 'PRI', NULL, ''
'FirstName', 'varchar(20)', 'YES', '', NULL, ''
'LastName', 'varchar(20)', 'YES', '', NULL, ''
'Email', 'varchar(40)', 'YES', 'UNI', NULL, ''
'DOB', 'date', 'YES', '', NULL, '' */

-- Alter the table and 2 new columns
alter table students add(Gender varchar(2), Age int);

-- Modify a column data type
alter table students modify Email varchar(50);

-- Rename a column
alter table students change StudentID USN varchar(20);

-- Drop a column
alter table students drop column Age;

-- Rename the table
rename table Students to StudentInfo;

-- Task 2: Create the Courses Table
-- Create a table to store information about courses.
-- Include the following columns:
-- - CourseID (Primary Key)
-- - CourseName
-- - Credits

-- Write your SQL query below Codespace:

create table Courses
( CourseID varchar(10) Primary key,
CourseName varchar(50),
Credits int);

DESC Courses; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- OUTPUT : 'CourseID', 'varchar(10)', 'NO', 'PRI', NULL, ''
-- 'CourseName', 'varchar(50)', 'YES', '', NULL, ''
-- 'Credits', 'int', 'YES', '', NULL, ''

-- Alter the table and 2 new columns
alter table Courses add(Faculty varchar(40), CourseTime varchar(10));

-- Modify a column data type
alter table Courses modify CourseTime numeric(2,2);

-- Rename a column,
alter table Courses rename column CourseTime to LectureHours;

-- Drop a column
alter table Courses drop column LectureHours;

-- Rename the table
alter table Courses rename to CourseDetails;

-- Task 3: Create the Enrollments Table
-- Create a table to store course enrollment information.
-- Include the following columns:
-- - EnrollmentID (Primary Key)
-- - StudentID (Foreign Key referencing Students table)
-- - CourseID (Foreign Key referencing Courses table)
-- - EnrollmentDate

-- Write your SQL query below Codespace:

create table Enrollments
( EnrollmentID varchar(20) Primary Key,
USN varchar(10) ,
CourseID varchar(10) ,
EnrollmentDate date,
foreign key (USN) references StudentInfo(USN),
foreign key (CourseID) references CourseDetails(CourseID));

DESC ENROLLMENTS; -- [ [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ] ]
-- OUTPUT : 'EnrollmentID', 'varchar(20)', 'NO', 'PRI', NULL, ''
-- 'USN', 'varchar(10)', 'YES', 'MUL', NULL, ''
-- 'CourseID', 'varchar(10)', 'YES', 'MUL', NULL, ''
-- 'EnrollmentDate', 'date', 'YES', '', NULL, ''

-- Alter the table and 2 new columns
alter table Enrollments add(Fees numeric(6,2), AdmissionNo int);

-- Modify a column data type
alter table Enrollments modify Fees int;

-- Rename a column
alter table Enrollments rename column AdmissionNo to Admission;

-- Drop a column
alter table Enrollments drop column Fees;

-- Rename the table
alter table Enrollments rename to StudentEnrollmentDetails;

-- Task 4: Alter the Students Table
-- Add a column 'PhoneNumber' to store student contact numbers.

-- Write your SQL query below Codespace:
alter table StudentInfo add(PhoneNumber numeric(10));

DESC StudentInfo; -- [[ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]]

/* 'USN', 'varchar(20)', 'NO', 'PRI', NULL, ''
'FirstName', 'varchar(20)', 'YES', '', NULL, ''
'LastName', 'varchar(20)', 'YES', '', NULL, ''
'Email', 'varchar(50)', 'YES', 'UNI', NULL, ''
'DOB', 'date', 'YES', '', NULL, ''
'Gender', 'varchar(2)', 'YES', '', NULL, ''
'PhoneNumber', 'decimal(10,0)', 'YES', '', NULL, '' */


-- Task 5: Modify the Courses Table
-- Change the data type of the 'Credits' column to DECIMAL.

-- Write your SQL query below Codespace:
alter table CourseDetails modify Credits decimal;

-- Task 6: Drop Tables

SHOW TABLES; -- Before dropping the table

/*'coursedetails'
'studentenrollmentdetails'
'studentinfo'*/

-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:
drop table CourseDetails;
drop table StudentEnrollmentDetails;

SHOW TABLES; -- After dropping the table Enrollement and Course
-- 'studentinfo'

-- End of Lab Experiment 01
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01