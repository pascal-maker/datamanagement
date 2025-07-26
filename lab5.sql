use artemis;
SET SQL_SAFE_UPDATES = 0;


#Exercise1


/*UPDATE step1 SELECT QUERY*/
select oi.orderid,oi.quantity, 5+ oi.quantity AS 'ProductAddition'from tblorderinformation oi
WHERE oi.orderid = 11078;

/*UPDATE step2 UPDATE QUERY*/
UPDATE tblorderinformation oi
JOIN tblorders o ON    oi.orderid = o.orderid
SET oi.quantity = 5 + oi.quantity
WHERE oi.orderid =  11078;

#Exercise2
 /*UPDATE step1 SELECT QUERY*/
select c.customerid,c.name,c.balance,CONCAT('€',ROUND(1.1* c.balance,1)) AS 'Balance increase with 10 percent' from tblcustomers c
WHERE c.balance > 1000;
/*UPDATE step2 UPDATE QUERY*/
UPDATE tblcustomers c
SET c.balance  = (1.1 * c.balance) 
WHERE c.balance > 1000;

#Exercise3
 /*UPDATE step1 SELECT QUERY*/
select c.name,c.address, c.city , c.zipcode from tblcustomers c
where c.name ="Vandeput";  
/*UPDATE step2 UPDATE QUERY*/
UPDATE tblcustomers c
set c.address = "Zandloperstraat 9 " ,c.city = "Mariakerke" ,c.zipcode = 9030
where c.name ="Vandeput";  

#Exercise4
SELECT ADDTIME('2023-10-24 11:12:00','24:00:00');

UPDATE tblorders 
SET ExpirationDate = DATE_ADD(DeliveryDate,INTERVAL ROUND(RAND()*4)+1 DAY)
WHERE DATEDIFF(DeliveryDate,ExpirationDate)>10;

#Exercise5
SELECT c.CustomerId,c.Name from tblcustomers c 
LEFT JOIN tblorders o ON c.CustomerID = o.CustomerNUMBER
WHERE o.OrderID IS NULL;

#Exercise6
/*DELETE from tblcustomers*/

DELETE FROM tblcustomers
WHERE CustomerId = 48;

#alerniefoefening6beter

DELETE c  from tblcustomers c
LEFT JOIN tblorders o ON c.CustomerID = o.CustomerNUMBER
WHERE o.OrderID IS NULL;

#Exercise7
SELECT o.CustomerNumber,COUNT(o.OrderID) AS OrderCount
from tblorders o
GROUP BY o.CustomerNumber
ORDER BY OrderCount ASC
LIMIT 1;

#Exercise8en10
SELECT * FROM tblorders WHERE CustomerNumber = 210;

DELETE FROM tblorderinformation
WHERE OrderID IN (
 SELECT OrderId from tblorders WHERE CustomerNumber = 210);
 
DELETE FROM tblorders WHERE CustomerNumber = 210;

DELETE FROM tblcustomers WHERE CustomerId = 210;
 #Exercise11
 INSERT INTO tblcustomers(Name,Address,Zipcode,City,RegistrationNumber,Type,Balance,Note) VALUES('Howest','Graaf Karel de Goedelaan 5',8500,'Kortrijk',
 102-213-123,NULL,0.0,NULL);
 
 #Exercise12
 /*Create new table to store productsnumber 6r*/
#CREATE TABLE tblMeat
#SELECT * from tblproducts  WHERE CategoryNumber = 6;

#Exercise13
DELETE FROM tblMeat WHERE stock IS NULL;
#Exercise14


INSERT INTO tblemployees (LastName,Car)
VALUES('Musabyimana',0);

SELECT * from tblemployees;

#Exercise15
INSERT INTO tblorders 

 (CustomerNumber,EmployeeId,ShipperId,OrderDate)
 Values(
 (SELECT CustomerId from tblcustomers WHERE NAME LIKE 'Howest%' LIMIT 1),
 (SELECT EmployeeId from tblemployees WHERE LastNAME LIKE 'Musabyimana%' LIMIT 1),2,
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
 



