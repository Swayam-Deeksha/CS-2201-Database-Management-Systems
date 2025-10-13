-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 02: Program 02 - Implementation of DML Commands in SQL ( INSERT , SELECT, UPDATE and DELETE )
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
'root@localhost', 'SwayamDeeksha', '8.4.6', '2025-09-01 11:28:10';

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Scenario: You are managing a database for a library with two tables: Books and Members.
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Task 01: Create Tables [ Check the below mentioned Instructions:
-- Create the Books and Members tables with the specified structure.
-- Books Table and Member Table : 
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task with the Instructed Column in the session 
create database Library;
use Library;

create table Books (
BookID varchar(10) Primary Key,
BookName varchar(30),
AuthorName varchar(20),
PublishedYear decimal(4),
TotalCopies int,
AvailableCopies int);

create table Members (
MemberID varchar(10) Primary Key,
MemberName varchar(50),
MembershipType varchar(30),
JoiningDate date);

-- Paste the Output below for the given command ( DESC TableName;) 

Desc Books;

/* 'BookID', 'varchar(10)', 'NO', 'PRI', NULL, ''
'BookName', 'varchar(30)', 'YES', '', NULL, ''
'AuthorName', 'varchar(20)', 'YES', '', NULL, ''
'PublishedYear', 'decimal(4,0)', 'YES', '', NULL, ''
'TotalCopies', 'int', 'YES', '', NULL, ''
'AvailableCopies', 'int', 'YES', '', NULL, '' */


Desc Members;

/* 'MemberID', 'varchar(10)', 'NO', 'PRI', NULL, ''
'MemberName', 'varchar(50)', 'YES', '', NULL, ''
'MembershipType', 'varchar(30)', 'YES', '', NULL, ''
'JoiningDate', 'date', 'YES', '', NULL, '' */


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 02: Insert a New Book
-- Instructions: Insert a book titled "1984_The Black Swan" by George Orwell (published in 1949) with 04 available copies and 10 Total copies. 
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

insert into Books values (101, "1984_The Black Swan", "George Orwell", 1949, 10, 04);
insert into Books values (102, "The Catcher in the Rye", "J D Salinger", 1945, 10, 05);
insert into Books values (103, "The Alchemist", "Paulo Coelho", 1988, 10, 02);
insert into Books values (104, "The Great Gatsby", "F Scott Fitzgerald", 1925, 10, 08);
insert into Books values (105, "The Godfather", "Mario Puzo", 1969, 10, 07);

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

select * from Books;

/* '101', '1984_The Black Swan', 'George Orwell', '1949', '10', '4'
'102', 'The Catcher in the Rye', 'J D Salinger', '1945', '10', '5'
'103', 'The Alchemist', 'Paulo Coelho', '1988', '10', '2'
'104', 'The Great Gatsby', 'F Scott Fitzgerald', '1925', '10', '8'
'105', 'The Godfather', 'Mario Puzo', '1969', '10', '7' */

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 03: Add New Members
-- Instructions: Insert two members: David Lee (Platinum, joined 2024-04-15) and Emma Wilson (Silver, joined 2024-05-22).
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

insert into Members values (1, "David Lee", "Platinum", '2024-04-15');
insert into Members values (2, "Emma Wilson", "Silver", '2024-05-22');
insert into Members values (3, "Jun Moon", "Gold", '2024-03-02');
insert into Members values (4, "Sarah Song", "Platinum", '2024-01-29');
insert into Members values (5, "Jack Hunt", "Diamond", '2024-06-01');

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

select * from Members;

/* '1', 'David Lee', 'Platinum', '2024-04-15'
'2', 'Emma Wilson', 'Silver', '2024-05-22'
'3', 'Jun Moon', 'Gold', '2024-03-02'
'4', 'Sarah Song', 'Platinum', '2024-01-29'
'5', 'Jack Hunt', 'Diamond', '2024-06-01' */

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 04: Update Book Details 
-- Instructions: The library acquired 2 additional copies of "1984_The Black Swan". Update the Books table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

alter table Books add(PublishedLocation varchar(40));
update Books set PublishedLocation = "Bangalore";

update Books set TotalCopies = TotalCopies + 2 where BookName = "1984_The Black Swan";

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

select * from Books;

/* '101', '1984_The Black Swan', 'George Orwell', '1949', '12', '4', 'Bangalore'
'102', 'The Catcher in the Rye', 'J D Salinger', '1945', '10', '5', 'Bangalore'
'103', 'The Alchemist', 'Paulo Coelho', '1988', '10', '2', 'Bangalore'
'104', 'The Great Gatsby', 'F Scott Fitzgerald', '1925', '10', '8', 'Bangalore'
'105', 'The Godfather', 'Mario Puzo', '1969', '10', '7', 'Bangalore' */


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 05: Modify a Member's Information
-- Instructions: Update a member's membership type. Emma Wilson has upgraded her membership from 'Silver' to 'Gold'.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

update Members set MembershipType = "Gold" where MemberName = 'Emma Wilson';

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

select * from Members;

/* '1', 'David Lee', 'Platinum', '2024-04-15'
'2', 'Emma Wilson', 'Gold', '2024-05-22'
'3', 'Jun Moon', 'Gold', '2024-03-02'
'4', 'Sarah Song', 'Platinum', '2024-01-29'
'5', 'Jack Hunt', 'Diamond', '2024-06-01' */


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 06: Remove a Member
-- Instructions: Delete David Lee’s record from the Members table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

delete from Members where MemberName = 'David Lee'; 

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

select * from Members;

/*'2', 'Emma Wilson', 'Gold', '2024-05-22'
'3', 'Jun Moon', 'Gold', '2024-03-02'
'4', 'Sarah Song', 'Platinum', '2024-01-29'
'5', 'Jack Hunt', 'Diamond', '2024-06-01' */

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 09: Borrowing Table 
-- Instructions: Create a Borrowing table with foreign keys referencing Books and Members.
-- Subtask 1: Borrow a Book
-- Scenario:Emma Wilson (member_id = 2) borrows the book "The Catcher in the Rye" (book_id = 102) on 2024-06-01. Insert this record into the Borrowing table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

create table BorrowingTable (
SlNo varchar(100) Primary Key,
MemberID varchar(10),
MemberName varchar(50),
BookID varchar(10),
BookName varchar(30),
BorrowedDate date,
Foreign Key(MemberID) references Members(MemberID),
Foreign Key(BookID) references Books(BookID));

insert into BorrowingTable values (1, 2, "Emma Wilson", 102, "The Catcher in the Rye", '2024-06-01');

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

select * from BorrowingTable;

-- '1', '2', 'Emma Wilson', '102', 'The Catcher in the Rye', '2024-06-01'


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 10: Find the name of Borrower who book = 102 [ Advance and Optional ]
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

select MemberName from BorrowingTable where BookID = '102';

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).

# MemberName
-- 'Emma Wilson'

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Final Task 00: ER Diagram - Instructions:
-- Draw an ER diagram for the library database. Additional Upload the scanned copy of the created ER Daigram in the Google Classroom.



-- END of the Task -- 