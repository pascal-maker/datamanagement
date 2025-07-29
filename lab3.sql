USE artemis;
use adventureworks2014;

SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
#Exercise01
SELECT LastName,FirstName, IF(Car=1, ' has a  company car','does  not have a  company car') AS 'Carstatus' from tblemployees ORDER BY LastName;
#Exercise02
SELECT CustomerNumber,Deliverydate,ShippingCost, if(IsnUll(Deliverydate),'Not been delivered yet',Deliverydate) 
AS 'Delivery Status' , if(Isnull(ShippingCost),'Not been delivered yet',ShippingCost) AS 'ShippingcostStatus' from tblorders;
#Exercise03
SELECT CategoryNumber, concat(count(productnumber), if(count(productnumber) = 1,'product','products')) AS 'NUMBER OF PRODUCTS',Categorynumber 
from tblproducts WHERE PricePerUnit > 50   GROUP BY CategoryNumber;
#Exercise04
SELECT City,count(CustomerId) from tblcustomers GROUP BY CITY ORDER BY  CustomerId;
#Exercise05
SELECT City,count(CustomerId) AS NumberOfCustomers  from tblcustomers  GROUP BY  City HAVING count( CustomerId) > 3 ORDER BY  CustomerId desc;
#Exercise06
SELECT JobTitle,count(EmployeeID) from tblemployees GROUP BY JobTitle ORDER  BY JobTitle; 
#Exercise07
SELECT JobTitle,IF(Gender=1,'male','female') as 'gender', count(EmployeeId) as 'number of employees' from tblemployees group by JobTitle,Gender ORDER BY  JobTitle;
#Exercise08
SELECT Name,RegistrationNumber, 'Customer has no registration number' AS ' Registration Status' from tblcustomers   WHERE RegistrationNumber IS NULL;
#Exercise09
SELECT CategoryNumber,COUNT(ProductNumber) AS "Number of Products", SUM(Stock * PricePerUnit) As "Stock value in euro" from tblproducts GROUP BY CategoryNumber;
#Exercise10
SELECT CategoryNumber, COUNT(ProductNumber) AS "NUMBER of Products", CONCAT('€',FORMAT(SUM(Stock * PricePerUnit),2)) AS " Stock Value in euro" from tblproducts GROUP BY CategoryNumber;
SELECT CategoryNumber,SupplierNumber, COUNT(ProductNumber) AS "NUMBER of Products", CONCAT('€',FORMAT(SUM(Stock * PricePerUnit),2)) AS " Stock Value in euro" from tblproducts  WHERE SupplierNumber = 4 GROUP BY CategoryNumber,SupplierNumber;
#Exercise11
SELECT CategoryNumber,SupplierNumber, COUNT(ProductNumber) AS "NUMBER of Products", CONCAT('€',FORMAT(SUM(Stock * PricePerUnit),2)) AS " Stock Value in euro" from tblproducts  WHERE SupplierNumber = 4 GROUP BY CategoryNumber,SupplierNumber HAVING SUM( STOCK * PricePerUnit) > 1000;
#Exercise12
SELECT 
    YEAR(DeliveryDate) AS "Year",
    CONCAT(FORMAT(AVG(DATEDIFF(DeliveryDate, OrderDate)), 0), ' days') AS "Average Delivery Time"
FROM tblorders
GROUP BY YEAR(DeliveryDate)
ORDER BY YEAR(DeliveryDate);
#Exercise13
SELECT FirstName,MiddleName,LastName,BusinessEntityID from Person   WHERE  MiddleName  Like 'J%' AND LastName Like "%Alexander%"  OR  MiddleName Like 'J%' AND LastName Like "%Zhang%";
#Exercise14
SELECT ProductID,Name,Size,Color from Product WHERE Size IS NULL  OR Color IS NULL;
#Exercise15
SELECT 'product info' as '', count(ProductID) , round(avg(size),0) from Product  WHERE COLOR IS NOT NULL AND SIZE IS NOT NULL AND SIZE NOT IN ('M','L','XL','S');
#Exercise16
SELECT CONCAT_WS('',FirstName,MiddleName,LastName)  AS FullName from Person WHERE LastName REGEXP '^V' OR  LastName REGEXP  '^W' ORDER BY LastName DESC;
#Exercise17
SELECT CONCAT_WS(BusinessEntityID,' ',FirstName, IF(ISNULL(MiddleName),'',CONCAT(' ',MiddleName)),'',LastName) AS Name from Person WHERE CAST(LastName AS BINARY) REGEXP BINARY '^[VW]' ORDER BY BusinessEntityID ASC;
#Exercise18
SELECT DISTINCT FirstName  From Person  WHERE FirstName  = REVERSE (FirstName);
#Exercise19
SELECT SUBSTRING(EmailAddress,LOCATE('@',EmailAddress) + 1) AS DomainName FROM ProductReview;
#Exercis20
SELECT  DISTINCT Jobtitle from employee ORDER BY  Jobtitle ASC;
#Exercise21
SELECT FirstName from Person WHERE FirstName Like '%K%';
#Exercise22
SELECT SalesPersonID,AVG(TotalDue) AS AverageOrderValue from SalesOrderHeader WHERE SalesPersonId IS NOT NULL  GROUP BY SalesPersonID HAVING COUNT(SalesOrderID) > 50;
#Exercise23
SELECT YEAR(OrderDATE) AS YEAR , QUARTER(OrderDate) AS QUARTER, COUNT(SalesOrderNumber) AS TotalOrder FROM SalesOrderHeader GROUP BY YEAR(OrderDate), QUARTER(OrderDATE) ORDER BY YEAR ASC ,  QUARTER;
#Exercise24
SELECT MONTH(OrderDATE) AS MAAND , concat(count(TotalDue)) as TotalOrder from salesorderheader GROUP BY MONTH(OrderDate) ORDER BY MAAND ASC;
#Exercise25
SELECT CustomerID, YEAR(OrderDATE) AS JAAR , concat(sum(TotalDue)) as TotalOrder from Salesorderheader GROUP BY CustomerID ,YEAR(OrderDate) ORDER BY  CustomerID ASC;














