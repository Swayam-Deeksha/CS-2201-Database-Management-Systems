Create database HospitalDB;
Use HospitalDB;

Create table Patients (
p_id int primary key,
p_name varchar(50),
dob date,
gender varchar(10));

Create table Doctors (
d_id int primary key,
d_name varchar(50),
Speciality varchar(50));

Create table Appointments (
a_id int primary key,
p_id int,
d_id int,
a_date date,
foreign key(p_id) references Patients(p_id),
foreign key(d_id) references Doctors(d_id));

Insert into Patients values 
(101, 'Ravi', '1985-06-15', 'Male'),
(102, 'Aditi', '1990-05-10', 'Female'),
(103, 'Suraj', '2000-09-15', 'Male'),
(104, 'Indu', '1998-08-17', 'Female'),
(105, 'Ram', '1983-03-27', 'Male');

Insert into Doctors Values
(1, 'Dr. Asha', 'Gynaecology'),
(2, 'Dr. Raju', 'Cardiology'),
(3, 'Dr. Leena', 'Opthalmology'),
(4, 'Dr. Rajeev', 'Neurology');

Insert into Appointments Values
(1001, 101, 2, '2025-10-26'),
(1002, 104, 1, '2025-10-28'),
(1003, 105, 3, '2025-10-25'),
(1004, 103, 2, '2025-10-26'),
(1005, 102, 4, '2025-10-23');

Select a.a_id, p.p_name as PatientName, d.d_name as DoctorName,
d.speciality, a.a_date from Appointments A inner join
Patients p on a.p_id = p.p_id inner join Doctors d on a.d_id = d.d_id;
/* # a_id, PatientName, DoctorName, speciality, a_date
'1002', 'Indu', 'Dr. Asha', 'Gynaecology', '2025-10-28'
'1001', 'Ravi', 'Dr. Raju', 'Cardiology', '2025-10-26'
'1004', 'Suraj', 'Dr. Raju', 'Cardiology', '2025-10-26'
'1003', 'Ram', 'Dr. Leena', 'Opthalmology', '2025-10-25'
'1005', 'Aditi', 'Dr. Rajeev', 'Neurology', '2025-10-23' */

Select d.d_id, d.d_name as DoctorName, count(distinct a.p_id)
as TotalPatients from Doctors d left join Appointments a
on d.d_id = a.d_id group by d.d_id, d.d_name;
/* # d_id, DoctorName, TotalPatients
'1', 'Dr. Asha', '1'
'2', 'Dr. Raju', '2'
'3', 'Dr. Leena', '1'
'4', 'Dr. Rajeev', '1' */

Delimiter //
Create procedure InsertAppointment (
in a_a_id int,
in a_p_id int,
in a_d_id int,
in a_a_date date)
Begin
insert into Appointments (a_id, p_id, d_id, a_date) values
(a_a_id, a_p_id, a_d_id, a_a_date);
End //
Delimiter ;

Call InsertAppointment (1006, 106, 4, '2025-10-23');

Delimiter //
Create procedure UpdateAppointmentDate (
in p_a_id int,
in p_a_date date)
Begin
Update Appointments set a_date = p_a_date
where a_id = p_a_id;
End //
Delimiter ;

Call UpdateAppointmentDate (1005, '2025-10-28');