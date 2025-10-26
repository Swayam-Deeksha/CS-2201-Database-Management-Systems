Create database LibraryManagement;
Use LibraryManagement;

Create table Books (
BookID int primary key,
Title varchar(200),
Author varchar(100),
Genre varchar(50),
AvailableCopies int);

Create table Members (
MemberID int primary key,
MemberName varchar(100),
Email varchar(100),
JoinDate date);

Create table IssueRecord (
IssueID int primary key,
MemberID int,
BookID int,
IssueDate date,
ReturnDate date,
Foreign Key(MemberID) references Members(MemberID),
Foreign key(BookID) references Books(BookID));

Insert into Books values
(101, 'Great Gatsby', 'Scott Fitzgerald', 'Fiction', 2),
(102, 'The Alchemist', 'Paulo Coelho', 'Philosophy', 3),
(103, 'Harry Potter and the Deathly Hallows', 'J.K Rowling', 'Fantasy', 1),
(104, 'Clean Code', 'Robert C. Martin', 'Programming', 3);

Insert into Members values
(1, 'ALice', 'alice@gmail.com', '2023-08-19'),
(2, 'Bobby', 'bobby@rediff.com', '2024-09-18'),
(3, 'Martin', 'martin@yahoo.com', '2021-06-25');

Insert into IssueRecord values
(1001, 2, 103, '2025-09-18', null),
(1003, 1, 104, '2025-10-19', null),
(1004, 3, 102, '2025-10-01', '2025-10-23'),
(1002, 1, 103, '2025-10-21', null),
(1005, 2, 101, '2025-06-10', '2025-07-02');

Select m.MemberName, count(ir.IssueID) as TotalIssuedBooks
from Members m inner join IssueRecord ir on m.MemberID = ir.MemberID
Group by m.MemberID;
/* # MemberName, TotalIssuedBooks
'ALice', '2'
'Bobby', '2'
'Martin', '1' */

Select ir.IssueId, m.MemberName, b.Title as BookTitle,
ir.IssueDate, ir.ReturnDate from IssueRecord ir
inner join Members m on ir.MemberID = m.MemberId
inner join Books b on ir.BookID = b.BookID;
/* # IssueId, MemberName, BookTitle, IssueDate, ReturnDate
'1002', 'ALice', 'Harry Potter and the Deathly Hallows', '2025-10-21', NULL
'1003', 'ALice', 'Clean Code', '2025-10-19', NULL
'1001', 'Bobby', 'Harry Potter and the Deathly Hallows', '2025-09-18', NULL
'1005', 'Bobby', 'Great Gatsby', '2025-06-10', '2025-07-02'
'1004', 'Martin', 'The Alchemist', '2025-10-01', '2025-10-23' */

Select m.MemberName, b.Title, ir.IssueDate, 
datediff(curdate(), ir.IssueDate) as DaysIssued
from IssueRecord ir join Members m on ir.MemberID = m.MemberID
join Books b on ir.BookID = b.BookId 
where ir.ReturnDate is null and datediff(curdate(), ir.IssueDate) > 14;
/* # MemberName, Title, IssueDate, DaysIssued
'Bobby', 'Harry Potter and the Deathly Hallows', '2025-09-18', '37'*/

Delimiter //
Create procedure UpdateBookAvailabilty (
in pBookID int,
in pAction varchar(10))
Begin
if pAction = 'issue' then update Books 
set AvailableCopies = AvailableCopies - 1
where BookID = pBookID and AvailableCopies > 0;
elseif pAction = 'return' then update Books
set AvailableCopies = AvailableCopies + 1
where BookID = pBookID;
End if;
End //
Delimiter ;

Call UpdateBookAvailabilty(3, 'issue');
Call UpdateBookAvailabilty(2, 'return');