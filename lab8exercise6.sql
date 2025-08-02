DROP DATABASE IF EXISTS hairdresser;
CREATE DATABASE hairdresser;
USE hairdresser;

-- Table :Customers
CREATE TABLE Customer(
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(100)
);

-- Table Appointements
CREATE TABLE Appointment(
AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
CustomerID INT,
AppointmentDate DATETIME,
FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);

CREATE TABLE Treatment (
TreatmentID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR(100),
Duration time
);

CREATE TABLE Product 
( ProductID INT PRIMARY KEY AUTO_INCREMENT,
Name VARCHAR (100)
);





CREATE TABLE Appointment_Treatment (
AppointmentID INT,
TreatmentID INT,
PRIMARY KEY (AppointmentID,TreatmentID),
FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID) ON DELETE CASCADE,
FOREIGN KEY (TreatmentID) REFERENCES Treatment(TreatmentID)
);

CREATE TABLE Treatment_Product (
TreatmentID INT,
ProductID INT,
PRIMARY KEY (TreatmentID,ProductID),
FOREIGN KEY ( TreatmentID) REFERENCES  Treatment(TreatmentID) ON DELETE CASCADE,
FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);




