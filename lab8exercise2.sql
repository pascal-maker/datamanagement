DROP DATABASE IF EXISTS patients;
CREATE DATABASE IF NOT EXISTS patients;
USE patients;

-- Patient table
CREATE TABLE IF NOT EXISTS Patient ( 
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    birthdate DATETIME
);

-- Doctor
CREATE TABLE IF NOT EXISTS Doctor ( 
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    DoctorName VARCHAR(100) NOT NULL,
    TypeOfDoctor VARCHAR (100)
);

CREATE TABLE IF NOT EXISTS Prescription ( 
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    DoctorID INT ,
    PatientID INT,
    Treatment VARCHAR(100) NOT NULL,
    NumberOfTurns INT,
    Frequency INT,
	FOREIGN KEY(DoctorID)  REFERENCES Doctor(DoctorID),
	FOREIGN KEY(PatientID)  REFERENCES Patient (PatientID)

    

    
);


-- Appointment table
CREATE TABLE IF NOT EXISTS Appointement ( 
    AppointementID INT PRIMARY KEY AUTO_INCREMENT,
    PrescriptionID INT,
    Appointement_date  DateTime NOT NULL,
    Appointment_time Time NOT NULL,
    Room VARCHAR(100) NOT NULL,
    FOREIGN KEY(PrescriptionID)  REFERENCES Prescription(PrescriptionID)
);








