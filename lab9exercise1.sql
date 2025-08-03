CREATE DATABASE IF NOT EXISTS BirdFamilie;
USE BirdFamilie;
DROP TABLE IF EXISTS BirdName;
DROP TABLE IF EXISTS Family;
DROP TABLE IF EXISTS Redlist;

CREATE TABLE Redlist (
RedlistID INT PRIMARY KEY AUTO_INCREMENT,
ThreatName VARCHAR(100) NOT NULL,
DutchName VARCHAR(100)

);

CREATE TABLE Family (
FamilyID INT PRIMARY KEY AUTO_INCREMENT,
CommonName VARCHAR(100),
ScientificName VARCHAR(100)

);


CREATE TABLE BirdName (
BirdID INT PRIMARY KEY AUTO_INCREMENT,
CommonName VARCHAR(100) UNIQUE,
ScientificName VARCHAR(100) NULL,
RedlistID INT DEFAULT 4,
FamilyID INT NULL,
CONSTRAINT fk_redlist FOREIGN KEY (RedlistID) REFERENCES Redlist(RedlistID),
CONSTRAINT fk_family FOREIGN KEY (FamilyID) REFERENCES Family(FamilyID)
);



CREATE OR REPLACE VIEW view01 AS SELECT r.ThreatName AS Threat,
f.CommonName AS Family,
b.CommonName AS Bird 
FROM BirdName b JOIN Redlist r ON r.RedlistID = b.RedListID 
LEFT JOIN Family f on f.FamilyID = b.FamilyID
WHERE r.ThreatName != 'Least Concern'
ORDER BY r.ThreatName ASC, f.CommonName ASC;



CREATE OR REPLACE VIEW  view02 AS
SELECT r.ThreatName AS THREAT,COUNT(*) AS Count
FROM BirdName b
JOIN Redlist r on b.RedlistID = r.RedlistID
GROUP BY r.ThreatName
ORDER BY COUNT DESC;


CREATE OR REPLACE VIEW view03 AS 
SELECT r.ThreatName AS THREAT,
f.CommonName AS Family,
COUNT(*) AS NUmberOfBirds
FROM BirdName b
JOIN Redlist r on r.RedlistID = b.RedlistID
LEFT JOIN Family f on f.FamilyID = b.FamilyID
WHERE r.ThreatName != 'Least Concern'
GROUP BY r.ThreatName,f.CommonName
ORDER BY Threat ASC, Family ASC;




