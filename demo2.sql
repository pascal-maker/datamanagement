SELECT ProductNumber,ProductName,PricePerUnit,PricePerUnit*1.33 from tblproducts;
SELECT ProductNumber,ProductName,PricePerUnit,PricePerUnit*1.33 AS SellingPrice from tblproducts;
SELECT ProductNumber,ProductName,PricePerUnit, PricePerunit*1.33 AS 'Selling Price' from tblproducts;
SELECT ProductNumber,ProductName,PricePerUnit,concat(PricePerUnit *1.33,'€') AS 'Selling Price' from tblproducts;
SELECT ProductNumber,ProductName,PricePerUnit FROM tblproducts WHERE PricePerUnit < 25;
SELECT Name,Address,Zipcpde FROM tblcustomers WHERE  balance != 0;
SELECT Name,City,Type from tblcustomers WHERE Type = 'P' or Type = 'R';
SELECT Name,City,Type FROM tblcustomers WHERE TYPE = 'p' AND Balance<> 0;
SELECT Name,Note FROM tblcustomers WHERE Note is not null;
SELECT LastName,BirthDate from tblemployees WHERE birthdate >= '1960-01-01' AND birthdate <= '1965-01-01';
SELECT BirthDate from tblemployees  WHERE BirthDate BETWEEN '1960-01-01' AND '1965-01-01';
SELECT * FROM tblcustomers where name like '%Van%';
SELECT * FROM tblcustomers WHERE NAME like '_ander';
SELECT * FROM tblcustomers WHERE Name LIKE 'V%N';
SELECT * FROM my_table WHERE my_column LIKE '%_example%';
SELECT FirstName,Zipcode,Wage,City from tblemployees WHERE Zipcode  = 3000 or Zipcode = 2800;
SELECT FirstName,Zipcode,Wage,City FROM tblemployees  WHERE Zipcode  IN (3000,2800);
SELECT FirstName,Zipcode,Wage,City FROM tblemployees WHERE Zipcode IN ( SELECT Zipcode FROM tblZipcodes WHERE Zipcode = 3000 or Zipcode = 2800);
SELECT FirstName,ZipCode FROM tblemployees WHERE EXISTS (SELECT Zipcode  from tblZipcodes  WHERE Zipcode = 3500 or Zipcode = 2900);
SELECT * FROM tbl WHERE field REGEXP 'expresion';
SELECT * FROM tbl WHERE field REGEXP BINARY 'expression';
SELECT * FROM Dictionary WHERE Word LIKE'a%' OR Word LIKE 'b%' OR Word  LIKE 'c%';
SELECT * FROM Dictionary WHERE Word REGEXP '^[a|b|c]';
SELECT * FROM tblcustomers WHERE name REGEXP '^j';
SELECT * FROM tblcustomers WHERE name REGEXP '^[jm]';
SELECT * from tblcustomers WHERE name REGEXP 'MAri[a-o]';
#SELECT * FROM tblcustomers WHERE CAST (name AS BINARY) REGEXP BINARY '^J';
SELECT ProductName,nederlandsenaam,priceperunit from tblproducts ORDER BY productname;
SELECT name,address,zipcode,city,balance from tblcustomers WHERE balance > 0 ORDER By balance DESC;
SELECT lastname,firstname,city from tblemployees order by lastname asc,firstname;
SELECT productname,priceperunit from tblproducts  order by priceperunit desc limit 5;
SELECT DISTINCT city from tblcustomers order by city;
SELECT sum(balance) as 'Som' FROM tblcustomers;
SELECT max(birthdate) AS 'Youngest' , min(birthdate)  AS 'Oldest' from tblemployees;
SELECT COUNT(*) from tblcustomers;
SELECT COUNT(*) AS NumberOfEmployees from tblcustomers;
SELECT COUNT(city)  AS NumberOfCities from tblcustomers;
SELECT COUNT(DISTINCT  city) AS NumberOfCities from tblcustomers;
SELECT AVG(wage) FROM tblemployees;
SELECT UCASE(name) AS NaamCustomer,LCASE(address) AS AdressCustomer from tblcustomers;
SELECT SUBSTRING(name,5) AS NaamCustomer,name  FROM tblcustomers;
SELECT LITRIM(name) AS NaamCustomer , name from tblcustomer;
select priceperunit,format(priceperunit,2) from tblproducts;
SELECT lastname,firstname,employed,CAST(employed AS date) from tblemployees;
SELECT DATE_ADD(expirationdate, INTERVAL 1 DAY) ,expirationdate from tblOrders;
SELECT '2016-10-12' + interval  1 day ;
SELECT '2016-13-12' + interval  1 day;
SELECT NOW();
SELECT DATEDIFF(Now(),employed) from tblemployees;
SELECT DATE_FORMAT(employed,'%W %M %Y') FROM tblemployees;
SELECT lastname,DAYNAME(employed) from tblemployees ORDER BY FIELD(DAYNAME(employed),'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');
SELECT lastname,TIMESTAMPDIFF(year,birthdate,Now()) as `Age` FROM tblemployees order by `Age` desc;
SELECT IFNULL(priceperunit,0) * 0.9 AS Promotion FROM tblproducts;
SELECT * FROM tblorders WHERE ISNULL(deliverydate);
SELECT * FROM tblcustomers WHERE RegistrationNumber IS NOT NULL;
 SELECT SUM(Sales) FROM Store_Information WHERE Store_Name IN ( SELECT Store_Name FROM GEOGRAPHY WHERE Region_Name = 'West');
 SELECT SUM(SAles) FROM Store_Information WHERE EXISTS ( SELECT *  FROM Geography  WHERE Region_Name = 'West');







