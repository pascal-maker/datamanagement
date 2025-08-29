-- ----------------------------------------------------
-- Reset the database (delete if exists, then recreate)
-- ----------------------------------------------------
DROP DATABASE IF EXISTS sportsclub;
CREATE DATABASE sportsclub;
USE sportsclub;

-- ----------------------------------------------------
-- Members table: stores all member information
-- ----------------------------------------------------
CREATE TABLE Members ( 
    MemberID INT PRIMARY KEY AUTO_INCREMENT,   -- surrogate PK
    MembershipNumber VARCHAR(10),              -- business key (M001, M002...)
    membership_name VARCHAR(100),              -- full name of member
    Address VARCHAR(100),
    Zipcode INT,
    City VARCHAR(100),
    PhoneNumber VARCHAR(15)
);

-- ----------------------------------------------------
-- Disciplines table: stores info about each running discipline
-- + records (world, EU, Belgian)
-- ----------------------------------------------------
CREATE TABLE Disciplines (
    DisciplineID INT PRIMARY KEY AUTO_INCREMENT,
    Distance  VARCHAR(50),                     -- e.g. 100m, Marathon
    Type  VARCHAR(50),                         -- e.g. Sprint, Long Distance
    WorldRecord TIME(2),                       -- store times with hundredths precision
    EuropeanRecord TIME(2),
    BelgianRecord TIME(2)
);

-- ----------------------------------------------------
-- Results table: junction table connecting Members and Disciplines
-- Composite PK = (MemberID, DisciplineID, Date)
-- ensures one member can only have one result per discipline per date
-- ----------------------------------------------------
CREATE TABLE Results (
    MemberID INT,
    DisciplineID INT,
    Date DATE,
    Location VARCHAR(100),
    AchievedTime TIME,
    PRIMARY KEY (MemberID, DisciplineID, Date),   -- composite PK
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (DisciplineID) REFERENCES Disciplines(DisciplineID)
);

-- ----------------------------------------------------
-- Insert Members
-- Emma Jones = M001, Ghent
-- Liam Smith = M002, Bruges
-- ----------------------------------------------------
INSERT INTO Members (MembershipNumber, membership_name, Address, Zipcode, City, PhoneNumber)
VALUES
 ('M001', 'Emma Jones', '123 Maple St', 90001, 'Ghent', '0493123456'),
 ('M002', 'Liam Smith', '456 Oak St', 90002, 'Bruges', '0493765432');

-- ----------------------------------------------------
-- Insert Disciplines
-- Example 1: 100m Sprint with record times
-- Example 2: Marathon with record times
-- Using TIME(2) format for precision
-- ----------------------------------------------------
INSERT INTO Disciplines (Distance, Type, WorldRecord, EuropeanRecord, BelgianRecord) 
VALUES 
('100m', 'Sprint', '00:00:09.63', '00:00:09.80', '00:00:11.04'),
('Marathon', 'Long Distance', '02:00:00.35', '02:03:00.35', '02:03:00.35');

-- ----------------------------------------------------
-- Insert Results
-- Emma Jones ran 100m on 21/06/2023 in Brussels, 15.12 sec
-- Liam Smith ran Marathon on 13/04/2023 in Brussels, 3h36m12s
-- ----------------------------------------------------
INSERT INTO Results (MemberID, DisciplineID, Date, Location, AchievedTime) 
VALUES 
(1, 1, '2023-06-21', 'Brussels King Baudouin Stadium', '00:00:15.12'),
(2, 2, '2023-04-13', 'Brussels Marathon', '03:36:12');

/*
Why 3 tables? 
→ Members (who), Disciplines (what), Results (who ran what & when).

Why composite PK in Results? 
→ Avoid duplicate results for the same member, discipline, and date.

Why TIME(2)? 
→ Needed for fractional seconds in athletics (e.g., 9.63s).

Why foreign keys? 
→ To enforce that results always link to existing members and disciplines.
*/
