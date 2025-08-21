USE artemis;

#Exercise01
SELECT p.ProductName,c.CategoryName from tblproducts AS p INNER JOIN tblcategories AS c ON p.CategoryNumber = c.CategoryNumber;
#Exercise02
select o.OrderID as 'Order Id' , c.Name as 'Name' from tblcustomers c join tblorders o 
on c.CustomerId = o.customernumber;
#Exercise03
SELECT p.ProductName as 'Product Name' ,s.Company as 'Company' from tblsuppliers s join tblproducts p
on s.SupplierId =  p.SupplierNumber;
#Exercise04
SELECT c.CategoryName AS 'Category Name',p.ProductName AS 'Product Name' , p.Stock - p.OnOrder AS 'Decifit' FROM tblcategories c JOIN tblproducts p ON c.CategoryNumber = p.CategoryNumber WHERE p.Stock < p.OnOrder ORDER BY c.CategoryName;
#Exercise05
SELECT e.EmployeeID,
       CONCAT(ROUND(SUM((oi.Quantity * p.PricePerUnit) - 
                        (oi.Discount * oi.Quantity * p.PricePerUnit)), 1), ' €') 
          AS TotalSales
FROM tblemployees e
JOIN tblorders o 
   ON e.EmployeeID = o.EmployeeID
JOIN tblorderinformation oi 
   ON o.OrderId = oi.OrderId
JOIN tblproducts p 
   ON oi.ProductNumber = p.ProductNumber
GROUP BY e.EmployeeID;
#Exercise6

select s.Country as 'Country' , s.Company as 'Company', count(p.ProductNumber) AS 'Number of products'  from tblsuppliers s   join tblproducts  p 
on p.SupplierNumber = s.SupplierId GROUP BY s.Country, s.Company order by s.Country;

#Exercise7
SELECT c.CategoryName AS 'CategoryName' , count(DISTINCT s.SupplierId) AS UniqueSuppliers from tblcategories c
 JOIN tblproducts p on c.CategoryNumber = p.CategoryNumber JOIN tblsuppliers s  on p.SupplierNumber = s.SupplierId  
 GROUP BY  c.CategoryName ORDER BY UniqueSuppliers  DESC;
 #Exercise8
 select t.Taxcode AS 'TaxCode' , t.TaxPercentage AS 'TaxPercentage'  from tbltaxrate t left join  tblproducts p  on t.taxcode = p.taxcode where p.taxcode is null;
 
 #Exercise9
 SELECT p.ProductName AS 'Product', 
       o.Quantity AS 'Quantity'
FROM tblproducts p 
LEFT JOIN tblorderinformation o 
   ON p.ProductNumber = o.ProductNumber
WHERE o.OrderID IS NULL
ORDER BY p.ProductName ASC;

												  
#Exercise10
 SELECT 
    CONCAT(ROUND(SUM((oi.Quantity * p.PricePerUnit) -  
                     (oi.Discount * oi.Quantity * p.PricePerUnit)),1), '€')  AS Revenue  
FROM tblemployees e 
LEFT JOIN tblorders o 
   ON e.EmployeeID = o.EmployeeID  
LEFT JOIN tblorderinformation oi 
   ON o.OrderId = oi.OrderId   
LEFT JOIN tblproducts p 
   ON oi.ProductNumber = p.ProductNumber 
GROUP BY e.LastName 
ORDER BY SUM((oi.Quantity * p.PricePerUnit) -  
             (oi.Discount * oi.Quantity * p.PricePerUnit)) DESC;
             
#Exercise11
SELECT ProductName,
       PricePerUnit,
       Stock,
       PricePerUnit * Stock AS 'Stock Value'
FROM tblproducts
WHERE PricePerUnit * Stock > (SELECT MIN(Wage) FROM tblemployees);
#Exercise12
SELECT Name,City,Zipcode,Address from tblcustomers 
 WHERE Name in  (select LastName from tblemployees);
 
 #Exercise13
 SELECT CustomerId,Name,Address,Zipcode,City , RegistrationNumber  FROM tblcustomers WHERE CustomerId IN (SELECT
 CustomerNumber from tblorders  WHERE YEAR(OrderDate) = 2006 AND DATEDIFF(DeliveryDate,OrderDate) < 30);
  #Exercise13alternative
  SELECT DISTINCT c.CustomerId,
       c.Name,
       c.Address,
       c.Zipcode,
       c.City,
       c.RegistrationNumber
FROM tblcustomers c
JOIN tblorders o 
   ON c.CustomerId = o.CustomerNumber
WHERE YEAR(o.OrderDate) = 2006
  AND DATEDIFF(o.DeliveryDate, o.OrderDate) < 30;

  #Exercise14
  SELECT 
    p.ProductNumber,
    SUM((oi.Quantity * p.PricePerUnit) * (1 - oi.Discount)) AS DiscountedPrice
FROM tblorders o
JOIN tblorderinformation oi 
    ON o.OrderId = oi.OrderId
JOIN tblproducts p 
    ON oi.ProductNumber = p.ProductNumber
WHERE oi.Discount >= 0.25
GROUP BY p.ProductNumber;

#Exercise15

SELECT  CONCAT(e.LastName, " ", e.FirstName) as 'Name' FROM tblorders o RIGHT JOIN
 tblemployees e on o.EmployeeID = e.EmployeeID WHERE o.EmployeeID IS NULL 

 ORDER BY e.LastName ASC;
 
 #exercise15alternative
 SELECT CONCAT(e.LastName, " ", e.FirstName) AS 'Name'
FROM tblemployees e
LEFT JOIN tblorders o 
    ON e.EmployeeID = o.EmployeeID
WHERE o.EmployeeID IS NULL
ORDER BY e.LastName ASC;

#exercise16
SELECT e.LastName,DATE(e.Employed) AS MonthOfEmployment
from tblemployees e WHERE e.Employed BETWEEN (SELECT MIN(Employed) from tblemployees
 WHERE LastName  IN ('Smets','Daponte')) AND 
 (SELECT MAX(Employed) from tblemployees WHERE LastName IN ('Smets','Daponte')) 
 ORDER BY MonthOfEmployment DESC;

 #Exercise17
SELECT c.company AS 'company', 
       c.last_name AS 'last_name',
       c.first_name AS 'first_name',
       c.address AS 'address',
       c.city AS 'city' 
FROM customers c
LEFT JOIN orders o 
       ON c.id = o.customer_id 
WHERE o.id IS NULL;

#Exercise19
SELECT os.id AS id, 
       os.status_name AS status_name
FROM orders_status os
LEFT JOIN orders o 
       ON os.id = o.status_id
WHERE o.id IS NULL;

#Exercise17

# Exercise17
SELECT c.company AS company,
       c.last_name AS last_name,
       c.first_name AS first_name,
       c.address AS address,
       c.city AS city
FROM customers c
LEFT JOIN orders o
       ON c.id = o.customer_id
WHERE o.id IS NULL;

# Exercise19
SELECT os.id AS id,
       os.status_name AS status_name
FROM orders_status os
LEFT JOIN orders o
       ON os.id = o.status_id
WHERE o.id IS NULL;

#Exercise20
SELECT CONCAT(c.last_name, '', c.first_name) AS ContactName, 
       c.city, 
       c.address AS Address, 
       'Customer' AS TableName 
FROM customers c 

UNION 

SELECT CONCAT(e.last_name, '', e.first_name) AS ContactName, 
       e.city, 
       e.address AS Address, 
       'Employees' AS TableName 
FROM employees e

ORDER BY city;

#Exercise21
SELECT COALESCE(p.privilege_name, 'No privilege') AS 'Privilege',
       COUNT(*) AS 'Assigned'
FROM employees e
LEFT JOIN employee_privileges ep
    ON e.id = ep.employee_id
LEFT JOIN privileges p
    ON ep.privilege_id = p.id
GROUP BY COALESCE(p.privilege_name, 'No privilege');




SELECT 
    o.id AS order_id, 
    DATE_FORMAT(o.order_date, "%Y-%m") AS order_month,
    FORMAT(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2, 'en_US') AS revenue
FROM orders o
JOIN order_details od 
    ON o.id = od.order_id
WHERE o.id >= 78
GROUP BY o.id, order_month
ORDER BY order_month, revenue DESC;

 
