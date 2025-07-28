
  #Exercise01
  select CustomerId,Name,Address,City,Zipcode, concat (Zipcode,'', City) AS 'Zipcode&City' from tblcustomers;
  #Exercise2
  select CustomerId,Name,Address,City,Zipcode, concat(Zipcode,'',City) AS 'Zipcode&City'from tblcustomers where Balance >= 150 AND Balance <= 300 ORDER BY Balance DESC;
  #Exercise03
  select LastName,FirstName,BirthDate from tblemployees where Month (BirthDate)  BETWEEN  07 AND 08;
  #Exercise04
  select LastName,FirstName,BirthDate from tblemployees where Month (BirthDate)   NOT BETWEEN  07 AND 08;
  #Exercise05
  select LastName,FirstName,BirthDate from tblemployees where BirthDate > '1960-01-01' AND  BirthDate < '1966-01-27' ORDER BY BirthDate;
  #Exercise06
  select Name,City from tblcustomers where City = "Leuven" OR City = "Herent" OR City = "Kessel-Lo" OR City = "Heverlee";
  #Exercise07
select Name,City from tblcustomers where City  NOT IN ('Leuven','Herent','Kessel-Lo','Heverlee');
#Exercise08
select NederlandseNaam,ProductName,CategoryNumber,concat(NederlandseNaam,(ProductName),CategoryNumber)from tblproducts  where CategoryNumber = 1 OR CategoryNumber = 2 OR CategoryNumber = 3 OR CategoryNumber = 4  OR CategoryNumber = 8  ORDER BY CategoryNumber AND NederlandseNaam;
#Exercise09
select NederlandseNaam,ProductName,CategoryNumber ,concat(NederlandseNaam,(ProductName),CategoryNumber)from tblproducts 
 where  ProductName LIKE '%Louisiana%'AND (CategoryNumber = 1 OR CategoryNumber = 2 OR CategoryNumber = 3 OR CategoryNumber = 4  
 OR CategoryNumber = 8)  ORDER BY CategoryNumber,
 NederlandseNaam;
 #Exercise10
select ProductName,QuantityPerUnit from tblproducts where QuantityPerUnit  LIKE "%bottles%" or 
 QuantityPerUnit LIKE "%boxes%"  or QuantityPerUnit LIKE "%bottle";
 #Exercise11
select ProductName,QuantityPerUnit,PricePerUnit from tblproducts where PricePerUnit >= 0 AND PricePerUnit <= 32 
 AND QuantityPerUnit  LIKE "%bottles%" or  QuantityPerUnit 
LIKE "%boxes%"  or QuantityPerUnit LIKE "%bottle" ORDER BY PricePerUnit DESC;
#Exercise12
select Name ,City , concat (Name, 'from',City) from  tblcustomers  where Name LIKE "%Vander%";
#Exercise13
select Name ,City , concat (Name, 'from',City) from  tblcustomers  where Name LIKE 'Vander%t';
#Exercise14
select Name ,City , Address, concat (Name, 'from',City) from  tblcustomers  where Address LIKE "%dorp%";
#Exercise15
select Company from tblsuppliers where Company LIKE "%an%"  or Company LIKE "%foot%";
#Exercise16
select ProductName from tblproducts where ProductName  regexp '^chef' AND ProductName regexp 'mix$';
#Exercise17
select ProductName FROM tblproducts WHERE BINARY   ProductName  LIKE '%c%' AND BINARY ProductName NOT LIKE '%C%' ORDER  BY ProductName;
#Exercise17
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
#Exercise19
select Name,Balance  from tblcustomers WHERE LENGTH(CAST(Balance AS CHAR)) = 4;
#Exercise20
select TaxPercentage from tbltaxrate WHERE TaxPercentage REGEXP '^[0-9]+\\.[0-9]{2}$';
select TaxPercentage from tbltaxrate WHERE TaxPercentage NOT REGEXP '^[0-9]+\\.[0-9]{2}$';
#Exercise21
select Name,City,Type from tblcustomers where Type = 'T' OR Type = 'W'  ORDER BY Type  ASC ;
#Exercise22
select Name,City,Type from tblcustomers where Type = 'T' OR Type = 'W'  ORDER BY (Type = 'T') DESC,    NAME ASC ;
#Exercise23
SELECT BALANCE as '€ Debts', CustomerId,City from tblcustomers WHERE Balance IS NOT NULL AND Balance != 0 ORDER BY Balance DESC;
#Exercise24
select  concat ( FirstName,LastName) as Name,BirthDate  from tblemployees  ORDER BY BirthDate  ASC;
#Exercise25
select FirstName,LastName,City , Employed from tblemployees where Employed LIKE '%1993%';
#Exercise26
select Name,City from tblcustomers  where City LIKE '%Leuven%' ORDER BY Name ASC;
#Exercise27
select FirstName,LastName ,City, Gender from tblemployees where City LIKE '%Leuven%' AND Gender = 2;
#Exercise28
select FirstName,LastName ,City, Gender from tblemployees where City  NOT LIKE '%Leuven%' '%Kessel-lo%' '%Herent%'  AND Gender = 1;
#Exercise29
select Name,Balance,CustomerId from tblcustomers where Balance > 175  ORDER BY Name ASC;
#Exercise30
select CustomerId,Name from tblcustomers where Name regexp '^Van';
#Exercise31
select JobTitle, UPPER(City) AS City, UPPER(LastName) AS LastName from tblemployees WHERE  Jobtitle = 'Representative' AND
 City not in ('Leuven','Kessel-lo','Herent','Genk');
#Exercise32
select ProductName,Stock,OnOrder,Shop,(Shop - ( Stock - OnOrder)) AS Shortage from tblproducts WHERE 
( Stock - OnOrder) < Shop ORDER BY Shortage DESC;
#Exercise33
select Company,Country from tblsuppliers where Country NOT In ('spain' ,'United Kingdom')  
 ORDER BY Company AND Country ASC LIMIT 5 ;
 #Exercise34
select DISTINCT Country from tblsuppliers  ORDER BY Country ASC;
#Exercise35
select sum(balance) as Balance, count(RegistrationNumber) as NumberOfCustomers from tblcustomers 
where RegistrationNumber is not null; 
#Exercise36
SELECT COUNT(OrderId) AS Orders FROM tblorders WHERE OrderDate >= '2006-08-06 ' AND   OrderDate < '2006-08-07';
#Exercise37
SELECT AVG(PricePerUnit *1.1) as AveragePriceWithIncrease from tblproducts;
#Exercise38
SELECT JoBTitle = "Representative" from tblemployees where Employed  <= '1993-01-01';
#Exercise38
SELECT COUNT(*) AS NUMberOfRepresentatives from tblemployees WHERE JobTitle = 'Representative' AND Employed <= '1993-01-01';
#Exercise39
SELECT YEAR(MAX(BirthDate)) - YEAR(MIN(BirthDate))  AS agegapemployee  from tblemployees WHERE City Like '%Leuven%';
#Exercise40
SELECT COUNT(OrderId) AS Orders from tblorders WHERE OrderDate >= '2005-01-01' AND OrderDate < '2005-12-31';


















 

  
