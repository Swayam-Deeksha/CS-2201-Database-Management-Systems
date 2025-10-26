Create database BankingDB;
Use BankingDB;

Create table Customers (
CustomerID int primary key,
Name varchar(100),
Email varchar(100),
Phone varchar(15),
CreatedDate date);

Create table Accounts (
AccountID int primary key,
CustomerID int,
AccountType varchar(50),
Balance decimal(12, 2),
CreatedDate date,
Foreign Key(CustomerID) references Customers(CustomerID));

Create table Transactions (
TransactionID int primary key,
AccountID int,
TransactionDate date,
Amount decimal(12, 2),
TransactionType varchar(10),
Description text,
Foreign Key(AccountID) references Accounts(AccountID));

Insert into Customers values
(1, 'Arush', 'arush@gmail.com', '9785645452', '2021-01-16'),
(2, 'Bhumi', 'bhumi@rediff.com', '8769529542', '2023-05-19'),
(3, 'Charvi', 'charvi@yahoo.com', '7854964526', '2020-05-10');

Insert into Accounts values
(101, 1, 'Savings', 90000.00, '2025-09-15'),
(102, 3, 'Salaried', 97515.26, '2025-07-26'),
(103, 2, 'Savings', 87500.00, '2025-10-02');

Insert into Transactions values
(1001, 102, '2025-10-04', 1500.00, 'debit', 'Groceries'),
(1002, 101, '2025-10-05', 750.00, 'debit', 'Electricity'),
(1003, 102, '2025-10-10', 60000.00, 'credit', 'Salary'),
(1004, 103, '2025-10-11', 10000.00, 'credit', 'Pocket Money');

Select AccountID, Sum(Amount) as TotalCredit
from Transactions
where TransactionType = 'credit' group by AccountID;
/* # AccountID, TotalCredit
'102', '60000.00'
'103', '10000.00' */

Select c.Name, max(t.Amount) as MaxTxn, min(t.Amount) as MinTxn
from Customers c inner join Accounts a on c.CustomerID = a.CustomerID
inner join Transactions t on a.AccountID = t.AccountID
group by c.Name;
/* # Name, MaxTxn, MinTxn
'Arush', '750.00', '750.00'
'Bhumi', '10000.00', '10000.00'
'Charvi', '60000.00', '1500.00' */

Select * from Transactions where TransactionDate between
'2025-10-01' and '2025-10-31';
/* # TransactionID, AccountID, TransactionDate, Amount, TransactionType, Description
'1001', '102', '2025-10-04', '1500.00', 'debit', 'Groceries'
'1002', '101', '2025-10-05', '750.00', 'debit', 'Electricity'
'1003', '102', '2025-10-10', '60000.00', 'credit', 'Salary'
'1004', '103', '2025-10-11', '10000.00', 'credit', 'Pocket Money' */

Select c.Name, a.AccountID, a.AccountType, a.Balance
from Customers c Right join Accounts a on c.CustomerID = a.CustomerID;
/* # Name, AccountID, AccountType, Balance
'Arush', '101', 'Savings', '90000.00'
'Charvi', '102', 'Salaried', '97515.26'
'Bhumi', '103', 'Savings', '87500.00' */

Delimiter //
Create procedure InsertTransaction (
in p_TransactionID int,
in p_AccountID int,
in p_Amount decimal(12, 2),
in p_Type varchar(10),
in p_Description text)
Begin
Insert into Transactions (TransactionID, AccountID, TransactionDate,
Amount, TransactionType, Description) values
(p_TransactionID, p_AccountID, Current_Date(), p_Amount, p_Type, p_Description);
If p_Type = 'credit' then
update Accounts set Balance = Balance + p_Amount where AccountID = p_AccountID;
else
update Accounts set Balance = Balance - p_Amount where AccountID = p_AccountID;
End if;
End //
Delimiter ;

Call InsertTransaction (1006, 102, 750.0, 'debit', 'ATM Withdrawal');

Delimiter //
Create procedure UpdateTransactionDescription (
in p_TransactionID int,
in p_NewDescription text)
begin
Update Transactions set Description = p_NewDescription where TransactionID = p_TransactionID;
End //
Delimiter ;

Call UpdateTransactionDescription (1002, 'Rent');