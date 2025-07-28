
SELECT ProductNumber,ProductName,PricePerUnit,Stock,PricePerUnit, concat(Stock ,'pieces'),concat (PricePerUnit*Stock,'€') AS 'Stockvalue' from tblproducts;
#Exercise2
SELECT ProductNumber,ProductName,PricePerUnit AS 'Purchaseprice', concat (PricePerUnit * 1.15) AS 'SellingPrice', concat((PricePerUnit * 1.15) - PricePerUnit,'€') AS 'Profit'
from tblproducts;
#Exercise3
select CustomerId,Name,Type from tblcustomers WHERE City = "Tienen";
#Exercise4
select ProductName from tblproducts WHERE CategoryNumber = 1;
#Exercise5
select Name from tblcustomers where City = "Genk" and Zipcode = 3600;
#Exercise6
select Name from tblcustomers where City = "Leuven" and Zipcode = 3000;
#Exercise7
select Name,City,Type from tblcustomers where Type = 'P' And Balance > 0  And City = "Tienen";
#Exercise8
select Name,City from tblcustomers where City = "Leuven" OR City = "Herent";
#Exercise9
select Name,Address,Type,City,Zipcode, concat (Zipcode, '' ,City) AS City from  tblcustomers where Type = 'T' OR Type = 'W';
#Exercise10
select EmployeeID, LastName,FirstName,BirthDate , concat (LastName, '',FirstName) AS Fullname from tblemployees where BirthDate  <= '1950-01-01';
