Create database CinemaDB;
Use CinemaDB;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100),
    Genre VARCHAR(50),
    Duration INT -- in minutes
);

CREATE TABLE Shows (
    ShowID INT PRIMARY KEY,
    MovieID INT,
    ShowTime DATETIME,
    ScreenNumber INT,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    ShowID INT,
    Tickets INT,
    BookingTime DATETIME,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID)
);

INSERT INTO Customers (CustomerID, Name, Email, Phone)
VALUES
(1, 'Amit Joshi', 'amit.joshi@example.com', '9876543210'),
(2, 'Priya Nair', 'priya.nair@example.com', '9123456789'),
(3, 'Rahul Verma', 'rahul.verma@example.com', '9988776655');

INSERT INTO Movies (MovieID, Title, Genre, Duration)
VALUES
(101, 'The Quantum Heist', 'Sci-Fi', 130),
(102, 'Love in Monsoon', 'Romance', 115),
(103, 'Chasing Shadows', 'Thriller', 125);

INSERT INTO Shows (ShowID, MovieID, ShowTime, ScreenNumber)
VALUES
(201, 101, '2025-10-28 18:00:00', 1),
(202, 102, '2025-10-28 20:00:00', 2),
(203, 103, '2025-10-29 17:30:00', 1);

INSERT INTO Bookings (BookingID, CustomerID, ShowID, Tickets, BookingTime, Status)
VALUES
(301, 1, 201, 2, '2025-10-26 15:00:00', 'Confirmed'),
(302, 2, 202, 3, '2025-10-26 16:30:00', 'Confirmed'),
(303, 3, 203, 1, '2025-10-27 10:00:00', 'Pending');

SELECT
    c.Name AS CustomerName,
    c.Email,
    m.Title AS MovieTitle,
    s.ShowTime,
    b.Tickets,
    b.Status
FROM Bookings b
JOIN Customers c ON b.CustomerID = c.CustomerID
JOIN Shows s ON b.ShowID = s.ShowID
JOIN Movies m ON s.MovieID = m.MovieID;
/* # CustomerName, Email, MovieTitle, ShowTime, Tickets, Status
'Amit Joshi', 'amit.joshi@example.com', 'The Quantum Heist', '2025-10-28 18:00:00', '2', 'Confirmed'
'Priya Nair', 'priya.nair@example.com', 'Love in Monsoon', '2025-10-28 20:00:00', '3', 'Confirmed'
'Rahul Verma', 'rahul.verma@example.com', 'Chasing Shadows', '2025-10-29 17:30:00', '1', 'Pending' */

SELECT
    m.Title AS MovieTitle,
    SUM(b.Tickets) AS TotalTickets
FROM Movies m
JOIN Shows s ON m.MovieID = s.MovieID
JOIN Bookings b ON s.ShowID = b.ShowID
WHERE b.Status = 'Confirmed'
GROUP BY m.MovieID, m.Title;
/* # MovieTitle, TotalTickets
'The Quantum Heist', '2'
'Love in Monsoon', '3' */

DELIMITER //
CREATE PROCEDURE InsertBooking (
    IN p_BookingID INT,
    IN p_CustomerID INT,
    IN p_ShowID INT,
    IN p_Tickets INT,
    IN p_BookingTime DATETIME,
    IN p_Status VARCHAR(20)
)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, ShowID, Tickets, BookingTime, Status)
    VALUES (p_BookingID, p_CustomerID, p_ShowID, p_Tickets, p_BookingTime, p_Status);
END //
DELIMITER ;

Call InsertBooking (304, 2, 203, 2, '2025-10-27 18:00:00', 'Confirmed');

DELIMITER //
CREATE PROCEDURE UpdateBookingStatus (
    IN p_BookingID INT,
    IN p_NewStatus VARCHAR(20)
)
BEGIN
    UPDATE Bookings
    SET Status = p_NewStatus
    WHERE BookingID = p_BookingID;
END //
DELIMITER ;

Call UpdateBookingStatus (303, 'Confirmed');