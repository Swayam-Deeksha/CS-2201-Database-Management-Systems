Create database HotelDB;
Use HotelDB;

Create table Guests (
GuestID int primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(20));

Create table Rooms (
RoomID int primary key,
RoomType Varchar(50),
PricePerNight decimal(10, 2),
IsAvailable bit);

Create table Bookings (
BookingID int primary key,
GuestID int,
RoomID int,
CheckIn date,
CheckOut date,
TotalAmount decimal(10,2),
Status varchar(20),
Foreign Key(GuestID) references Guests(GuestID),
Foreign Key(RoomID) references Rooms(RoomID));

INSERT INTO Guests VALUES
(1, 'Ravi Kumar', 'ravi.kumar@example.com', '9876543210'),
(2, 'Anita Desai', 'anita.desai@example.com', '9123456789'),
(3, 'Karan Mehta', 'karan.mehta@example.com', '9988776655');

INSERT INTO Rooms VALUES
(101, 'Deluxe', 3500.00, 1),
(102, 'Standard', 2500.00, 1),
(103, 'Suite', 5000.00, 1);

INSERT INTO Bookings (BookingID, GuestID, RoomID, CheckIn, CheckOut, TotalAmount, Status)
VALUES
(1001, 1, 101, '2025-10-20', '2025-10-23', 10500.00, 'Confirmed'),
(1002, 2, 102, '2025-10-21', '2025-10-22', 2500.00, 'Confirmed'),
(1003, 3, 103, '2025-10-22', '2025-10-25', 15000.00, 'Pending');

SELECT
    r.RoomType,
    SUM(b.TotalAmount) AS TotalRevenue
FROM Rooms r
JOIN Bookings b ON r.RoomID = b.RoomID
WHERE b.Status = 'Confirmed'
GROUP BY r.RoomType;
/* # RoomType, TotalRevenue
'Deluxe', '10500.00'
'Standard', '2500.00' */

SELECT
    b.BookingID,
    g.Name,
    DATEDIFF(b.CheckOut, b.CheckIn) AS NightsBooked
FROM Bookings b
JOIN Guests g ON b.GuestID = g.GuestID;
/* # BookingID, Name, NightsBooked
'1001', 'Ravi Kumar', '3'
'1002', 'Anita Desai', '1'
'1003', 'Karan Mehta', '3' */

SELECT
    g.Name,
    g.Email,
    r.RoomType,
    b.CheckIn,
    b.CheckOut,
    b.TotalAmount,
    b.Status
FROM Guests g
JOIN Bookings b ON g.GuestID = b.GuestID
JOIN Rooms r ON b.RoomID = r.RoomID;
/* # Name, Email, RoomType, CheckIn, CheckOut, TotalAmount, Status
'Ravi Kumar', 'ravi.kumar@example.com', 'Deluxe', '2025-10-20', '2025-10-23', '10500.00', 'Confirmed'
'Anita Desai', 'anita.desai@example.com', 'Standard', '2025-10-21', '2025-10-22', '2500.00', 'Confirmed'
'Karan Mehta', 'karan.mehta@example.com', 'Suite', '2025-10-22', '2025-10-25', '15000.00', 'Pending' */

DELIMITER //
CREATE PROCEDURE InsertRoomBooking (
    IN p_BookingID INT,
    IN p_GuestID INT,
    IN p_RoomID INT,
    IN p_CheckIn DATE,
    IN p_CheckOut DATE,
    IN p_Status VARCHAR(20)
)
BEGIN
    DECLARE nights INT;
    DECLARE rate DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    -- Calculate number of nights
    SET nights = DATEDIFF(p_CheckOut, p_CheckIn);

    -- Get room rate
    SELECT PricePerNight INTO rate FROM Rooms WHERE RoomID = p_RoomID;

    -- Calculate total amount
    SET total = rate * nights;

    -- Insert booking
    INSERT INTO Bookings (BookingID, GuestID, RoomID, CheckIn, CheckOut, TotalAmount, Status)
    VALUES (p_BookingID, p_GuestID, p_RoomID, p_CheckIn, p_CheckOut, total, p_Status);

    -- Update room availability
    UPDATE Rooms SET IsAvailable = 0 WHERE RoomID = p_RoomID;
END //
DELIMITER ;

Call InsertRoomBooking (1004, 2, 101, '2025-10-28', '2025-10-30', 'Confirmed');

DELIMITER //
CREATE PROCEDURE UpdateRoomBookingStatus (
    IN p_BookingID INT,
    IN p_NewStatus VARCHAR(20)
)
BEGIN
    UPDATE Bookings
    SET Status = p_NewStatus
    WHERE BookingID = p_BookingID;
END //
DELIMITER ;

Call UpdateRoomBookingStatus (1003, 'Confirmed');