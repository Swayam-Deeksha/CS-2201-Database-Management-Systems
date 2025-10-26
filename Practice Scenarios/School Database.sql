Create database SchoolDB;
Use SchoolDB;

Create table Classes (
ClassID int primary key,
ClassName varchar(50));

Create table Students (
StudentID int primary key,
StudentName varchar(100),
ClassID int,
Foreign Key(ClassID) references Classes(ClassID));

Create table Marks (
MarkID int primary key,
StudentID int,
Subject varchar(50),
Marks int,
Foreign Key(StudentID) references Students(StudentID));

Insert into Classes values
(1, 'Mathematics'), (2, 'Science'), (3, 'Social');

Insert into Students values
(101, 'Alice', 1), (102, 'Bobby', 2), (103, 'Charlie', 1),
(104, 'Diana', 3);

Insert into Marks values
(1001, 101, 'Algebra', 85), (1002, 102, 'Physics', 95),
(1003, 103, 'Calculus', 90), (1004, 104, 'Economics', 92);

Select c.ClassName, s.StudentName, m.Subject, m.Marks
from Classes c inner join Students s on c.ClassID = s.ClassID
inner join Marks m on s.StudentID = m.StudentID
order by c.ClassName, s.StudentName;
/* # ClassName, StudentName, Subject, Marks
'Mathematics', 'Alice', 'Algebra', '85'
'Mathematics', 'Charlie', 'Calculus', '90'
'Science', 'Bobby', 'Physics', '95'
'Social', 'Diana', 'Economics', '92' */

Select c.ClassName, avg(m.Marks) as AverageMarks from Classes c
inner join Students s on c.ClassID = s.ClassID
inner join Marks m on s.StudentID = m.StudentID
group by c.ClassName;
/* # ClassName, AverageMarks
'Mathematics', '87.5000'
'Science', '95.0000'
'Social', '92.0000' */

Delimiter //
Create procedure AddStudent (
in p_StudentID int,
in p_StudentName varchar(100),
in p_ClassID int)
Begin
Insert into Students (StudentID, StudentName, ClassID)
values (p_StudentID, p_StudentName, p_ClassID);
End //
Delimiter ;

Call AddStudent (105, 'Edwin', 3);

Delimiter //
Create procedure UpdateStudentMarks (
in p_StudentID int,
in p_Subject varchar(50),
in p_NewMarks int)
Begin
Update Marks
set Marks = p_NewMarks
where StudentID = p_StudentID and Subject = p_Subject;
End //
Delimiter ;

Call UpdateStudentMarks (104, 'History', 87);