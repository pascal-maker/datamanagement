SELECT p.ProductNumber as 'Product Number',p.ProductName as 'Product Name', c.CategoryName;
SELECT t1.*,t2.* FROM Tablet1 INNER JOIN Table2 t2 ON t1.ID = t2.ID;
SELECT c.Name AS `Customer Name` ,p.nederlandsenaam as 'Product',
o.OrderDate as 'Ordered on' , i.Quantity AS 'Quantity', CONCAT(e.LastName, " " ,e.FirstName) as 'Name of Employee'
FROM tblemployees AS e JOIN tblOrders AS o on e.EmployeeID = o.EmployeeID
JOIN tblcustomers AS c ON c.CustomerId = o.CustomerNumber
JOIN tblorderinformation AS i on i.orderID = o.orderID JOIN tblproducts AS p on i.ProductNumber = p.ProductNumber ORDER By `Customer Name`;
SELECT t1.*,t2.* FROM Table1 t1 LEFT OUTER JOIN Table2 t2 on t1.ID = t2.ID;
SELECT * FROM tblproducts AS p LEFT JOIN tblOrderinformation AS o on p.ProductNumber = o.ProductNumber ORDER BY o.orderid ASC;
SELECT t1.*,t2.* FROM Table1 t1 RIGHT OUTER JOIN Table2 t2 on t1.ID = t2.ID ;
SELECT * FROM tblorders o RIGHT JOIN tblemployees e on o.EmployeeID = e.EmployeeID  ORDER BY o.orderid;
SELECT city FROM tblemployees UNION SELECT city FROM tblcustomers ORDER BY city;
SELECT *  FROM tblproducts p LEFT JOIN tblcategories  c on p.CategoryNumber = c.CategoryNumber UNION SELECT * FROM tblproducts p RIGHT JOIN tblcategories  c on p.CategoryNumber = c.CategoryNumber;
SELECT t1.*,t2.* FROM Table1 t1 CROSS JOIN Table2 t2;
SELECT * FROM tblproducts CROSS JOIN tblcategories;
SELECT * from tblproducts,tblcategories;
SELECT p.*,c.CategoryName as 'Category Name' FROM tblproducts p NATURAL JOIN tblcategories c;
SELECT p.ProductNumber as 'Product Number' ,p.nederlandsenaam  AS 'Product', o.orderID AS 'Order ID' , o.Quantity;
 
SELECT o.orderid AS 'ORDER ID', e.EmployeeID as 'Employee ID',CONCAT (e.LastName, " ",e.FirstName) as 'Name of Employee' , e.JobTitle FRom tblOrders o RIGHT JOIN tblemployees e on e.employeeID = e.employeeID WHERE o.EmployeeID is null;
SELECT Name,City from tblcustomers WHERE city in ( SELECT DISTINCT city FROM tblemployees);
SELECT Name,City FROM tblcustomers WHERE (city,zipcode) IN (SELECT city,zipcode from tblemployees);
SELECT ProductNumber , ProductName from tblproducts ORDER BY PricePerUnit  DESC LIMIT 1;
SELECT ProductNumber,ProductName from tblproducts WHERE PricePerUnit = ( SELECT max (PricePerUnit) FROM tblproducts);
SELECT LastName from tblemployees e WHERE NOT EXISTS ( SELECT * FROM tblorders o WHERE o.EmployeeID = e.EmployeeID);
SELECT o.orderID AS 'ORDER ID' , e.EmployeeID AS ' Employee ID',concat(e.Lastname "" ,e.FirstName) as  'Name of the Employee',e.Jobtitle from tblorders o right join tblemployees e  on o.EmployeeID  WHERE o.EmployeeID is null;
