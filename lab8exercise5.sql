DROP DATABASE IF EXISTS architect;
CREATE DATABASE architect;
USE architect;

-- architect table
CREATE TABLE Architect ( 
    ArchitectID INT PRIMARY KEY AUTO_INCREMENT,
    NameArcihitect VARCHAR(10),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15)
);

-- Customer table (Composite PK)
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
   Customer_Name VARCHAR(100),
   Customer_Email VARCHAR(100),
   Customer_Phone VARCHAR(15)
   
    
);

-- Projecttable
CREATE TABLE project (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ArchitectID INT,
    CustomerID INT,
    Project_Name VARCHAR(100),
    Budget INT ,
    EstimatedHours INT,
    WorkedHours INT,
    StartDate DATE,
	FOREIGN KEY (ArchitectID) REFERENCES Architect(ArchitectID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
    
    
);

