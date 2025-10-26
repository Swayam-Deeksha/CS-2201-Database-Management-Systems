Create database FlightReservationDB;
Use FlightReservationDB;

Create table Passengers (
PassengerID int primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(20));

Create table Flights (
FlightID int primary key,
FlightNumber Varchar(20),
Origin varchar(50),
Destination varchar(50),
DepartureTime datetime,
ArrivalTime datetime);

Create table Bookings (
BookingID int primary key,
PassengerID int,
FlightID int,
BookingDate date,
SeatNumber varchar(10),
Status varchar(20),
Foreign Key(PassengerID) references Passengers(PassengerID),
Foreign Key(FlightID) references Flights(FlightID));

INSERT INTO Passengers (PassengerID, Name, Email, Phone)
VALUES
(101, 'Aarav Mehta', 'aarav.mehta@example.com', '9876543210'),
(102, 'Diya Sharma', 'diya.sharma@example.com', '9123456789'),
(103, 'Rohan Iyer', 'rohan.iyer@example.com', '9988776655'),
(104, 'Sneha Kapoor', 'sneha.kapoor@example.com', '9090909090');

INSERT INTO Flights (FlightID, FlightNumber, Origin, Destination, DepartureTime, ArrivalTime)
VALUES
(201, 'AI202', 'Delhi', 'Mumbai', '2025-11-01 08:00:00', '2025-11-01 10:00:00'),
(202, '6E305', 'Bengaluru', 'Hyderabad', '2025-11-02 14:30:00', '2025-11-02 16:00:00'),
(203, 'UK410', 'Chennai', 'Kolkata', '2025-11-03 06:45:00', '2025-11-03 09:30:00');

INSERT INTO Bookings (BookingID, PassengerID, FlightID, BookingDate, SeatNumber, Status)
VALUES
(1, 101, 201, '2025-10-25', '12A', 'Confirmed'),
(2, 102, 201, '2025-10-25', '12B', 'Confirmed'),
(3, 103, 202, '2025-10-26', '14C', 'Pending'),
(4, 104, 203, '2025-10-27', '15D', 'Confirmed'),
(5, 101, 202, '2025-10-28', '16E', 'Cancelled');

SELECT
    f.FlightID,
    f.FlightNumber,
    COUNT(b.BookingID) AS TotalPassengers
FROM Flights f
LEFT JOIN Bookings b ON f.FlightID = b.FlightID
GROUP BY f.FlightID, f.FlightNumber;
/* # FlightID, FlightNumber, TotalPassengers
'201', 'AI202', '2'
'202', '6E305', '2'
'203', 'UK410', '1' */

SELECT
    p.Name,
    p.Email,
    f.FlightNumber,
    f.Origin,
    f.Destination,
    f.DepartureTime,
    b.SeatNumber,
    b.Status
FROM Passengers p
JOIN Bookings b ON p.PassengerID = b.PassengerID
JOIN Flights f ON b.FlightID = f.FlightID;
/* # Name, Email, FlightNumber, Origin, Destination, DepartureTime, SeatNumber, Status
'Aarav Mehta', 'aarav.mehta@example.com', 'AI202', 'Delhi', 'Mumbai', '2025-11-01', '12A', 'Confirmed'
'Diya Sharma', 'diya.sharma@example.com', 'AI202', 'Delhi', 'Mumbai', '2025-11-01', '12B', 'Confirmed'
'Rohan Iyer', 'rohan.iyer@example.com', '6E305', 'Bengaluru', 'Hyderabad', '2025-11-02', '14C', 'Pending'
'Aarav Mehta', 'aarav.mehta@example.com', '6E305', 'Bengaluru', 'Hyderabad', '2025-11-02', '16E', 'Cancelled'
'Sneha Kapoor', 'sneha.kapoor@example.com', 'UK410', 'Chennai', 'Kolkata', '2025-11-03', '15D', 'Confirmed' */

Delimiter //
CREATE PROCEDURE InsertBooking (
    in i_BookingID INT,
    in i_PassengerID INT,
    in i_FlightID INT,
    in i_BookingDate DATETIME,
    in i_SeatNumber VARCHAR(10),
    in i_Status VARCHAR(20)
)
BEGIN
    INSERT INTO Bookings (BookingID, PassengerID, FlightID, BookingDate, SeatNumber, Status)
    VALUES (i_BookingID, i_PassengerID, i_FlightID, i_BookingDate, i_SeatNumber, i_Status);
END //
Delimiter ;

Call InsertBooking(6, 104, 202, '2025-10-26', '17A', 'Confirmed');

Delimiter //
CREATE PROCEDURE UpdateBookingStatus (
    i_BookingID INT,
    i_NewStatus VARCHAR(20)
)
BEGIN
    UPDATE Bookings
    SET Status = i_NewStatus
    WHERE BookingID = i_BookingID;
END //
Delimiter ;

Call UpdateBookingStatus (3, 'Confirmed');