Create Database CollegeDB;
Use CollegeDB;

Create table Students (
student_id int primary key,
student_name varchar(50),
gender varchar(10),
dob date,
city varchar(30));

Create table Courses (
course_id int primary key,
course_name varchar(50),
duration int, -- in months
fee decimal(10,2));

Create table Enrollments (
enrollment_id int primary key,
student_id int,
course_id int,
enrollment_date date,
grade char(2),
foreign key(student_id) references Students(student_id),
foreign key(course_id) references Courses(course_id));

Insert into Students values 
(1, 'Asha Rao', 'Female', '2003-04-12', 'Bangalore'),
(2, 'Rahul Kumar', 'Male', '2002-10-05', 'Mysore'),
(3, 'Sneha Patil', 'Female', '2003-07-22', 'Mangalore'),
(4, 'Rohit Sharma', 'Male', '2001-12-11', 'Hubli'),
(5, 'Neha Singh', 'Female', '2002-01-25', 'Udupi');

Insert into Courses values
(101, 'Computer Science', 6, 25000.00),
(102, 'Data Analytics', 4, 20000.00),
(103, 'Web Development', 3, 18000.00),
(104, 'AI and ML', 5, 30000.00),
(105, 'Cyber Security', 6, 28000.00);

Insert into Enrollments values
(1, 1, 101, '2024-06-10', 'A'),
(2, 2, 103, '2024-07-01', 'B'),
(3, 3, 104, '2024-06-15', 'A'),
(4, 4, 102, '2024-05-20', 'C'),
(5, 5, 105, '2024-07-05', 'B');

Select count(*) as Total_Students from Students;
/* # Total_Students
'5' */

Select Avg(fee) as Avg_Fee from Courses;
/* # Avg_Fee
'24200.000000' */

Select Max(fee) as Max_Fee, Min(fee) as Min_Fee from Courses;
/* # Max_Fee, Min_Fee
'30000.00', '18000.00' */

Select enrollment_id, student_id, 
year(enrollment_date) as year, month(enrollment_date) as month
From Enrollments;
/* # enrollment_id, student_id, year, month
'1', '1', 2024, '6'
'2', '2', 2024, '7'
'3', '3', 2024, '6'
'4', '4', 2024, '5'
'5', '5', 2024, '7' */

Select student_name, dob, timestampdiff(Year, dob, curdate()) as age
From Students where timestampdiff(year, dob, curdate()) > 21;
/* # student_name, dob, age
'Asha Rao', '2003-04-12', '22'
'Rahul Kumar', '2002-10-05', '23'
'Sneha Patil', '2003-07-22', '22'
'Rohit Sharma', '2001-12-11', '23'
'Neha Singh', '2002-01-25', '23' */

Select s.student_id, c.course_name, e.grade from Students s
inner join Enrollments e on s.student_id = e.student_id
inner join Courses c on e.course_id = c.course_id;
/* # student_id, course_name, grade
'1', 'Computer Science', 'A'
'2', 'Web Development', 'B'
'3', 'AI and ML', 'A'
'4', 'Data Analytics', 'C'
'5', 'Cyber Security', 'B' */

Select s.student_name, e.course_id, e.grade from Students s
left join Enrollments e on s.student_id = e.student_id;
/* # student_name, course_id, grade
'Asha Rao', '101', 'A'
'Rahul Kumar', '103', 'B'
'Sneha Patil', '104', 'A'
'Rohit Sharma', '102', 'C'
'Neha Singh', '105', 'B' */

Select c.course_name, e.student_id, e.grade from Courses c
Right join Enrollments e on c.course_id = e.course_id;
/* # course_name, student_id, grade
'Computer Science', '1', 'A'
'Web Development', '2', 'B'
'AI and ML', '3', 'A'
'Data Analytics', '4', 'C'
'Cyber Security', '5', 'B' */

Select c.course_name, Count(e.student_id) as Total_Students
from Courses c join Enrollments e on c.course_id = e.course_id
group by c.course_name order by Total_Students desc;
/* # course_name, Total_Students
'Computer Science', '1'
'Data Analytics', '1'
'Web Development', '1'
'AI and ML', '1'
'Cyber Security', '1' */

Select * from Courses order by fee Desc;
/* # course_id, course_name, duration, fee
'104', 'AI and ML', '5', '30000.00'
'105', 'Cyber Security', '6', '28000.00'
'101', 'Computer Science', '6', '25000.00'
'102', 'Data Analytics', '4', '20000.00'
'103', 'Web Development', '3', '18000.00' */

Delimiter //
Create Procedure InsertStudent (
In sid int,
in sname varchar(50),
in gender varchar(10),
in dob date,
in city varchar(30))
Begin
insert into Students values (sid, sname, gender, dob, city);
End //
Delimiter ;

Call InsertStudent(6, 'Kiran Das', 'Male', '2003-02-18', 'Belgaum');

Delimiter //
Create procedure UpdateCourseFee (
in cid int,
in new_fee decimal(10,2))
Begin
Update Courses Set fee = new_fee where course_id = cid;
End //
Delimiter ;

Call UpdateCourseFee(103, 19000.00);