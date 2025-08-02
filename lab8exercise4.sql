DROP DATABASE IF EXISTS sportsclub;
CREATE DATABASE sportsclub;
USE sportsclub;

-- Members table
CREATE TABLE Members ( 
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    MembershipNumber VARCHAR(10),
    membership_name VARCHAR(100),
    Address VARCHAR(100),
    Zipcode INT,
    City VARCHAR(100),
    PhoneNumber VARCHAR(15)
);

-- Disciplines table
CREATE TABLE Disciplines (
    DisciplineID INT PRIMARY KEY AUTO_INCREMENT,
    Distance  VARCHAR(50),
    Type  VARCHAR(50),
    WorldRecord TIME(2),
    EuropeanRecord TIME(2),
    BelgianRecord TIME(2)
);

-- Results table (Composite PK)
CREATE TABLE Results (
    MemberID INT,
    DisciplineID INT,
    Date DATE,
    Location VARCHAR(100),
    AchievedTime TIME,
    PRIMARY KEY (MemberID, DisciplineID, Date),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (DisciplineID) REFERENCES Disciplines(DisciplineID)
);

-- Insert into Members
INSERT INTO Members (MembershipNumber, membership_name, Address, Zipcode, City, PhoneNumber)
VALUES
 ('M001', 'Emma Jones', '123 Maple St', 90001, 'Ghent', '0493123456'),
 ('M002', 'Liam Smith', '456 Oak St', 90002, 'Bruges', '0493765432');

-- Insert into Disciplines
INSERT INTO Disciplines (Distance, Type, WorldRecord, EuropeanRecord, BelgianRecord) 
VALUES 
('100m', 'Sprint', '00:00:09.63', '00:00:09.80', '00:00:11.04'),
('Marathon', 'Long Distance', '02:00:00.35', '02:03:00.35', '02:03:00.35');

-- Insert into Results (need MemberID too!)
INSERT INTO Results (MemberID, DisciplineID, Date, Location, AchievedTime) 
VALUES 
(1, 1, '2023-06-21', 'Brussels King Baudouin Stadium', '00:00:15.12'),
(2, 2, '2023-04-13', 'Brussels Marathon', '03:36:12');
