USE artemis;
USE northwind;

SELECT p.ProductName as 'Product Name', c.CategoryName as ' Category Name' from tblproducts p JOIN tblcategories c ON p.CategoryNumber = c.CategoryNumber;
#ex2
select o.OrderID as 'Order Id ', c.Name as 'Name' from tblcustomers c join tblorders o  on c.CustomerId = o.customernumber;
#ex3

SELECT p.ProductName as 'Product Name' , s.Company as 'Company' from tblproducts p JOIN tblsuppliers s ON p.CategoryNumber = s.SupplierId;
#ex4
SELECT c.CategoryName AS 'Category Name', p.ProductName AS 'Product Name', p.Stock - p.OnOrder AS 'Decifit ' FROM tblcategories c JOIN tblproducts p  ON c.CategoryNumber = p.CategoryNumber WHERE p.Stock < p.OnOrder ORDER BY c.CategoryName;
#ex5
SELECT e.EmployeeID,Sum((oi.Quantity * p.PricePerUnit) -  (oi.Discount * oi.Quantity * p.PricePerUnit)) as TotalSales  FROM tblemployees e 
JOIN tblorders o ON e.EmployeeID = o.EmployeeID join tblorderinformation oi ON o.OrderId = oi.OrderId  JOIN tblproducts p 
ON oi.ProductNumber = p.ProductNumber GROUP BY e.EmployeeID;
#ex6
SELECT  s.Country AS 'Country', s.Company AS 'Company', count(p.ProductNumber) AS ' Number of Products' from tblsuppliers s JOIN tblproducts p
 ON p.SupplierNumber = s.SupplierId  GROUP BY s.Country, s.Company   ORDER BY S.Country,S.Company;
 #ex7
 SELECT c.CategoryName AS 'CategoryName' , count(DISTINCT s.SupplierId) AS UniqueSuppliers from tblcategories c
 JOIN tblproducts p on c.CategoryNumber = p.CategoryNumber JOIN tblsuppliers s  on p.SupplierNumber = s.SupplierId  
 GROUP BY  c.CategoryName ORDER BY UniqueSuppliers  DESC;
 #ex8

SELECT t.TaxCode ,T.TaxPercentage from tbltaxrate t left join tblproducts p on t.Taxcode = p.Taxcode where p.taxcode is null;

#ex9
SELECT p.ProductName AS 'ProductName' , 
o.OrderID as 'OrderId',
o.Quantity as 'Quantity'

from tblproducts p   
 LEFT JOIN tblorderinformation o on p.ProductNumber = o.ProductNumber
 WHERE o.OrderId IS NULL 
 ORDER BY p.ProductName ASC;
 
 #exercise10
 SELECT e.LastName,
 CONCAT(ROUND(Sum((oi.Quantity * p.PricePerUnit) -  (oi.Discount * oi.Quantity * p.PricePerUnit)),1), '€')  as Revenue  FROM tblemployees e 
 LEFT JOIN tblorders o ON e.EmployeeID = o.EmployeeID  left join tblorderinformation oi ON o.OrderId = oi.OrderId   LEFT JOIN tblproducts p 
ON oi.ProductNumber = p.ProductNumber GROUP BY e.LastName 
 ORDER BY Sum((oi.Quantity * p.PricePerUnit) -  (oi.Discount * oi.Quantity * p.PricePerUnit)) DESC;
 
 #exercise11
SELECT ProductName,PricePerUnit,Stock,PricePerUnit*Stock AS 'Stock Value' from  tblproducts WHERE PricePerUnit * Stock > (SELECT min(Wage) FROM tblemployees);

#Exercise12
SELECT Name,Address,Zipcode,City FROM tblcustomers WHERE Name IN (SELECT LastName FROM tblemployees);
 #Exercise13
 SELECT CustomerId,Name,Address,Zipcode,City , RegistrationNumber  FROM tblcustomers WHERE CustomerId IN (SELECT
 CustomerNumber from tblorders  WHERE YEAR(OrderDate) = 2006 AND DATEDIFF(DeliveryDate,OrderDate) < 30);
#Exercise14
SELECT p.ProductNumber,Sum((oi.Quantity * p.PricePerUnit) *  (1 - oi.Discount )) as DiscountedPrice  FROM tblorders o

 join tblorderinformation oi ON o.OrderId = oi.OrderId  JOIN tblproducts p ON 
oi.ProductNumber = p.ProductNumber WHERE oi.Discount >=0.25  GROUP BY p.ProductNumber;

#Exercise15
SELECT  CONCAT(e.LastName, " ", e.FirstName) as 'Name' FROM tblorders o RIGHT JOIN
 tblemployees e on o.EmployeeID = e.EmployeeID WHERE o.EmployeeID IS NULL 

 ORDER BY e.LastName ASC;



#exercise16
SELECT e.LastName ,DATE(e.Employed) as Monthofemployment  FROM tblemployees e WHERE e. Employed BETWEEN 
LEAST( 
(SELECT Employed from tblemployees WHERE LastName = 'Smets') ,

(SELECT Employed FROM tblemployees WHERE Lastname = 'Daponte')
) AND 
     GREATEST(
     (SELECT Employed from tblemployees WHERE LastName = 'Smets') ,

     (SELECT Employed FROM tblemployees WHERE Lastname = 'Daponte')

)

ORDER BY Monthofemployment DESC;

#exercise17 
SELECT c.company AS 'company', c.last_name AS 'last_name' ,c.first_name as 'first_name',c.address as 'address',c.city as 'city' from tblcustomers c
right join tblorders o on o.CustomerId = c.id WHERE o.CustomerId IS NULL;

#Exercise17
SELECT c.company AS 'company', c.last_name AS 'last_name' ,c.first_name as 'first_name',c.address as 'address',c.city as 'city' from customers c
left join orders o on c.Id = o.Customer_id WHERE o.Id IS NULL;

#Exercise18
SELECT c.id as 'CustomerId', c.country_region from customers c
WHERE c.ID IN (SELECT o.Customer_ID from orders o);



#Exercise19
select os.id as 'id',os.status_name as 'status_name'
from orders_status os # 2 keer klikken zodat table in zwart staat de welke je wil dysplay northwind hier
left join orders o
on os.id = o.status_id
where o.id is null;

#Exercise20
SELECT CONCAT( c.last_name, '',c.first_name) AS ContactName, c.city, c.address AS Address, 'Customer' AS TableName FROM customers c 
UNION 
SELECT CONCAT( e.last_name, '',e.first_name) AS ContactName, e.city, e.address AS Address, 'Employees' AS TableName FROM employees e
ORDER BY city;



#Exercise21
SELECT p.privilege_name as 'Privilege', count(*) as 'Assigned'
# Om alle rijen in de tabel privileges te tellen, ongeacht of de kolom privilege_name een waarde heeft of NULL is, kun je een eenvoudige query uitvoeren 
# met de COUNT(*) functie zonder de GROUP BY. Dit geeft het totale aantal rijen in de tabel weer.
# met de group by: hier dus: Voor elk unieke waarde in de kolom privilege_name wordt het aantal rijen geteld dat binnen die groep valt.

FROM employees e
LEFT JOIN employee_privileges ep
    ON e.id = ep.employee_id
LEFT JOIN privileges p
    ON ep.privilege_id = p.id
GROUP BY COALESCE( p.privilege_name,'No privilege');




#Exercise22
SELECT 
o.id AS order_id, 
DATE_FORMAT(o.order_date, "%Y-%m") AS order_month,
FORMAT(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2, 'en_US') AS revenue
FROM 
    orders o
JOIN 
    order_details od ON o.id = od.order_id
WHERE 
    o.id >= 78
GROUP BY 
    o.id, order_month
ORDER BY 
   order_month AND revenue DESC;
   
  
#Exercise23
SELECT 
o.id AS order_id, 
DATE_FORMAT(o.order_date, "%Y-%m") AS order_month,
od.product_id,
p.product_name,  -- Adjust to match the actual product name column in the products table
od.quantity,
FORMAT(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2, 'en_US') AS revenue
FROM 
    orders o
JOIN 
    order_details od ON o.id = od.order_id
JOIN 
    products p ON od.product_id = p.id  -- Adjust the join condition based on your schema
WHERE 
    o.id >= 78
GROUP BY 
    o.id, order_month, od.product_id, p.product_name, od.quantity
ORDER BY 
    od.quantity DESC;
