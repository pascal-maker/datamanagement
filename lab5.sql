use artemis;
SET SQL_SAFE_UPDATES = 0;


#Exercise1


UPDATE tblorderinformation
SET Quantity = Quantity + 5
WHERE OrderID = 11078;


#Exercise02
UPDATE tblcustomers
SET Balance  = Balance *1.10
WHERE Balance > 1000;
#Exercise3
UPDATE tblcustomers
SET Address  = 'Zandloperstraat 9',
City = 'Mariakerke',
Zipcode = '9030'
WHERE Name =  'Vandeput'; 

#Exercise4
UPDATE tblOrders
SET ExpirationDate = DATE_ADD(DeliveryDate, INTERVAL FLOOR(1 + (RAND()*5)) DAY)
WHERE DATEDIFF(ExpirationDate, DeliveryDate) < -10;

#Exercise5
SELECT c.CustomerId,c.Name from tblcustomers c 
LEFT JOIN tblorders o ON c.CustomerID = o.CustomerNUMBER
WHERE o.OrderID IS NULL;

# We use LEFT JOIN because we want all customers (even if they have no orders)
# The "left" refers to tblcustomers in the SQL query — not the diagram
# This helps us find customers where no matching order exists (OrderID IS NULL)
#Exercise6
/*DELETE from tblcustomers*/


#Exercise6
 DELETE from tblcustomers
 WHERE CustomerId = 290;
 


#Exercise7
SELECT o.CustomerNumber,COUNT(o.OrderID) AS OrderCount
from tblorders o
GROUP BY o.CustomerNumber
ORDER BY OrderCount ASC
LIMIT 1;
# Exercise07
# ✅ Zoek de klant met het laagste aantal bestellingen
# - GROUP BY per klant (CustomerNumber)
# - COUNT(*) telt het aantal bestellingen per klant
# - ORDER BY ASC → klant met minst bestellingen komt bovenaan
# - LIMIT 1 → toon enkel die ene klant

#Exercise8en10
-- #Exercise11: Volledige verwijdering van klant 183 en bijhorende gegevens

-- Stap 1: Verwijder eerst de orderregels (order lines) die gekoppeld zijn aan klant 183
-- Dit is nodig omdat tblorderinformation een FOREIGN KEY bevat naar tblorders
-- En je geen orders kunt verwijderen zolang daar nog orderregels aan vasthangen
DELETE oi
FROM tblorderinformation oi
JOIN tblorders o ON oi.OrderID = o.OrderID
WHERE o.CustomerNumber = 183;

-- Stap 2: Verwijder daarna de orders van klant 183
-- Nu dat er geen orderregels meer bestaan, kunnen de orders veilig verwijderd worden
DELETE FROM tblorders
WHERE CustomerNumber = 183;

-- Stap 3: Verwijder tenslotte de klant zelf
-- Nu dat er geen orders meer aan klant 183 hangen, kan ook deze rij uit tblcustomers verwijderd worden
DELETE FROM tblcustomers
WHERE CustomerID = 183;

 #Exercise11
INSERT INTO tblcustomers
(Name,Address,Zipcode,City,RegistrationNumber)
VALUES('Howest',' Graaf Karel de Goedelaan 5','8500','Kortrijk',' VAT 102-213-123');

 
 #Exercise12
 /*Create new table to store productsnumber 6r*/
#CREATE TABLE tblMeat
#SELECT * from tblproducts  WHERE CategoryNumber = 6;

#Exercise13
DELETE FROM tblMeat WHERE stock IS NULL;
#Exercise14


#Exercise14
INSERT INTO tblemployees (LastName,FirstName,Address,Car)
VALUES('Musabyimana','Pascal','Gerard Willemotlaan 30',1);

SELECT LastName,FirstName,Address,1
from tblemployees;


INSERT INTO tblorders 
    (CustomerNumber, EmployeeID, ShipperID, OrderDate)
VALUES (
    -- Subquery 1: zoek de ID van de klant waarvan de naam begint met 'Howest'
    (SELECT CustomerID 
     FROM tblcustomers 
     WHERE Name LIKE 'Howest%' 
     LIMIT 1),

    -- Subquery 2: zoek de ID van de medewerker waarvan de achternaam begint met 'Musabyimana'
    (SELECT EmployeeID 
     FROM tblemployees 
     WHERE LastName LIKE 'Musabyimana%' 
     LIMIT 1),

    -- Verzendmethode (ShipperID), hier handmatig gekozen als '2'
    2,

    -- Huidige datum als orderdatum
    CURDATE()
);
 
 #Exercise16
 CREATE VIEW vwFruits  AS
 SELECT p.*, c.CategoryName as 'Name'
 FROM tblproducts p
 JOIN tblcategories c on p.CategoryNumber = c.CategoryNumber
 WHERE c.CategoryName= 'Fruit';
 
 
 
 
 
 
DROP VIEW IF EXISTS vwFRuits;
CREATE VIEW vwFruits AS 
SELECT p.*,c.CategoryName AS 'NAME'
from tblproducs p
JOIN tblcategories c on p.CategoryNumber = c.CategoryNumber
WHERE c.CategoryName = 'Fruit';
 



