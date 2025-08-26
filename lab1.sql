#Exercise1
SELECT ProductNumber,ProductName,PricePerUnit,Stock,PricePerUnit, concat(Stock ,'pieces'),concat (PricePerUnit*Stock,'€') AS 'Stockvalue' from tblproducts;
#Exercise2
SELECT ProductNumber,ProductName,PricePerUnit AS 'Purchaseprice', concat (PricePerUnit * 1.15) AS 'SellingPrice', concat((PricePerUnit * 1.15) - PricePerUnit,'€') AS 'Profit'
from tblproducts;
#Exercise3
select CustomerId,Name,Type from tblcustomers WHERE City = "Tienen";
#Exercise4
select ProductName from tblproducts WHERE CategoryNumber = 1;
#Exercise5
-- Toon klantnamen
select Name 
-- Uit de klantentabel
from tblcustomers 
-- Filter: klanten uit Genk met postcode 3600
where City = "Genk" and Zipcode = 3600;
#Exercise6
-- Toon klantnamen
select Name 
-- Uit de klantentabel
from tblcustomers 
-- Filter: klanten uit Leuven met postcode 3000
where City = "Leuven" and Zipcode = 3000;
#Exercise7
-- Toon naam, stad en type
select Name,City,Type 
-- Uit de klantentabel
from tblcustomers 
-- Filter: particulieren (P) met positieve balans die in Tienen wonen
where Type = 'P' And Balance > 0  And City = "Tienen";
#Exercise8
-- Toon klantnaam en stad
select Name,City 
-- Uit de klantentabel
from tblcustomers 
-- Filter: klanten uit Leuven of Herent
where City = "Leuven" OR City = "Herent";
#Exercise9
-- Toon naam, adres, type, stad, postcode en samengestelde weergave van postcode + stad
select Name,Address,Type,City,Zipcode, 
       concat (Zipcode, ' ' ,City) AS `Zipcode City` 
from  tblcustomers 
-- Filter: type T of W
where Type = 'T' OR Type = 'W';
#exercise8alternative
SELECT Name,Address,Type, concat (Zipcode, ' ' ,City) AS 'City' from tblcustomers 
WHERE Type IN ( 'T','W');

#Exercise9
select EmployeeID, LastName,FirstName,BirthDate , concat (LastName, '',FirstName) AS Fullname from tblemployees where BirthDate  <= '1950-01-01';
