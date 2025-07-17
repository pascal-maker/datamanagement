  use artemis;
  select CustomerId,Name,Address,City,Zipcode, concat (Zipcode,'', City) AS 'Zipcode&City' from tblcustomers;
  select CustomerId,Name,Address,City,Zipcode, concat(Zipcode,'',City) AS 'Zipcode&City'from tblcustomers where Balance >= 150 AND Balance <= 300 ORDER BY Balance DESC;
  select LastName,FirstName,BirthDate from tblemployees where Month (BirthDate)  BETWEEN  07 AND 08;
  select LastName,FirstName,BirthDate from tblemployees where Month (BirthDate)   NOT BETWEEN  07 AND 08;
  select LastName,FirstName,BirthDate from tblemployees where BirthDate > '1960-01-01' AND  BirthDate < '1966-01-27' ORDER BY BirthDate;
  select Name,City from tblcustomers where City = "Leuven" OR City = "Herent" OR City = "Kessel-Lo" OR City = "Heverlee";
select Name,City from tblcustomers where City  NOT IN ('Leuven','Herent','Kessel-Lo','Heverlee');
select NederlandseNaam,ProductName,CategoryNumber,concat(NederlandseNaam,(ProductName),CategoryNumber)from tblproducts  where CategoryNumber = 1 OR CategoryNumber = 2 OR CategoryNumber = 3 OR CategoryNumber = 4  OR CategoryNumber = 8  ORDER BY CategoryNumber AND NederlandseNaam;
select NederlandseNaam,ProductName,CategoryNumber ,concat(NederlandseNaam,(ProductName),CategoryNumber)from tblproducts  where  ProductName LIKE '%Louisiana%'AND (CategoryNumber = 1 OR CategoryNumber = 2 OR CategoryNumber = 3 OR CategoryNumber = 4  OR CategoryNumber = 8)  ORDER BY CategoryNumber,
 NederlandseNaam;
select ProductName,QuantityPerUnit from tblproducts where QuantityPerUnit  LIKE "%bottles%" or  QuantityPerUnit LIKE "%boxes%"  or QuantityPerUnit LIKE "%bottle";
select ProductName,QuantityPerUnit,PricePerUnit from tblproducts where PricePerUnit >= 0 AND PricePerUnit <= 32  AND QuantityPerUnit  LIKE "%bottles%" or  QuantityPerUnit 
LIKE "%boxes%"  or QuantityPerUnit LIKE "%bottle" ORDER BY PricePerUnit DESC;
select Name ,City , concat (Name, 'from',City) from  tblcustomers  where Name LIKE "%Vander%";
select Name ,City , concat (Name, 'from',City) from  tblcustomers  where Name LIKE 'Vander%t';
select Name ,City , Address, concat (Name, 'from',City) from  tblcustomers  where Address LIKE "%dorp%";
select Company from tblsuppliers where Company LIKE "%an%"  or Company LIKE "%foot%";
select ProductName from tblproducts where ProductName  regexp '^chef' AND ProductName regexp 'mix$';
select ProductName FROM tblproducts WHERE BINARY   ProductName  LIKE '%c%' AND BINARY ProductName NOT LIKE '%C%' ORDER  BY ProductName;
SELECT ProductName 
FROM tblproducts 
WHERE 
    (
        (BINARY ProductName LIKE '%c%')
        OR 
        (BINARY ProductName LIKE '%y%')
        OR 
        (BINARY ProductName LIKE '%B%')
    )
    AND BINARY ProductName NOT LIKE '%C%'
    AND BINARY ProductName NOT LIKE '%Y%'
ORDER BY ProductName;

select Name,Balance  from tblcustomers WHERE LENGTH(CAST(Balance AS CHAR)) = 4;
select TaxPercentage from tbltaxrate WHERE TaxPercentage REGEXP '^[0-9]+\\.[0-9]{2}$';
select TaxPercentage from tbltaxrate WHERE TaxPercentage NOT REGEXP '^[0-9]+\\.[0-9]{2}$';
select Name,City,Type from tblcustomers where Type = 'T' OR Type = 'W'  ORDER BY Type  ASC ;
select Name,City,Type from tblcustomers where Type = 'T' OR Type = 'W'  ORDER BY (Type = 'T') DESC,    NAME ASC ;
SELECT BALANCE as '€ Debts', CustomerId,City from tblcustomers WHERE Balance IS NOT NULL AND Balance != 0 ORDER BY Balance DESC;
select  concat ( FirstName,LastName) as Name,BirthDate  from tblemployees  ORDER BY BirthDate  ASC;
select FirstName,LastName,City , Employed from tblemployees where Employed LIKE '%1993%';
select Name,City from tblcustomers  where City LIKE '%Leuven%' ORDER BY Name ASC;
select FirstName,LastName ,City, Gender from tblemployees where City LIKE '%Leuven%' AND Gender = 2;
select FirstName,LastName ,City, Gender from tblemployees where City  NOT LIKE '%Leuven%' '%Kessel-lo%' '%Herent%'  AND Gender = 1;
select Name,Balance,CustomerId from tblcustomers where Balance > 175  ORDER BY Name ASC;
select CustomerId,Name from tblcustomers where Name regexp '^Van';
select JobTitle, UPPER(City) AS City, UPPER(LastName) AS LastName from tblemployees WHERE  Jobtitle = 'Representative' AND City not in ('Leuven','Kessel-lo','Herent','Genk');
select ProductName,Stock,OnOrder,Shop,(Shop - ( Stock - OnOrder)) AS Shortage from tblproducts WHERE ( Stock - OnOrder) < Shop ORDER BY Shortage DESC;
select Company,Country from tblsuppliers where Country NOT In ('spain' ,'United Kingdom')   ORDER BY Company AND Country ASC LIMIT 5 ;
select DISTINCT Country from tblsuppliers  ORDER BY Country ASC;
select sum(balance) as Balance, count(RegistrationNumber) as NumberOfCustomers from tblcustomers where RegistrationNumber is not null; 
SELECT COUNT(OrderId) AS Orders FROM tblorders WHERE OrderDate >= '2006-08-06 ' AND   OrderDate < '2006-08-07';
SELECT AVG(PricePerUnit *1.1) as AveragePriceWithIncrease from tblproducts;
SELECT JoBTitle = "Representative" from tblemployees where Employed  <= '1993-01-01';
SELECT COUNT(*) AS NUMberOfRepresentatives from tblemployees WHERE JobTitle = 'Representative' AND Employed <= '1993-01-01';
SELECT YEAR(MAX(BirthDate)) - YEAR(MIN(BirthDate))  AS agegapemployee  from tblemployees WHERE City Like '%Leuven%';
SELECT COUNT(OrderId) AS Orders from tblorders WHERE OrderDate >= '2005-01-01' AND OrderDate < '2005-12-31';
















 

  
