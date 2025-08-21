
USE northwind;
#Exercise01
-- Show each product together with its category
-- We join products and categories via CategoryNumber
SELECT p.ProductName, c.CategoryName 
FROM tblproducts AS p 
INNER JOIN tblcategories AS c 
    ON p.CategoryNumber = c.CategoryNumber;

#Exercise02
-- Show each order together with the customer who placed it
-- Join customers to orders via customer id
SELECT o.OrderID AS 'Order Id', c.Name AS 'Name' 
FROM tblcustomers c 
JOIN tblorders o 
    ON c.CustomerId = o.CustomerNumber;

#Exercise03
-- Show each product together with its supplier company
-- Join products and suppliers via SupplierId
SELECT p.ProductName AS 'Product Name', s.Company AS 'Company' 
FROM tblsuppliers s 
JOIN tblproducts p 
    ON s.SupplierId = p.SupplierNumber;

#Exercise04
-- Show categories and their products that are in deficit
-- (Stock smaller than OnOrder)
-- Calculate deficit = Stock - OnOrder
SELECT c.CategoryName AS 'Category Name',
       p.ProductName AS 'Product Name',
       p.Stock - p.OnOrder AS 'Deficit'
FROM tblcategories c 
JOIN tblproducts p 
    ON c.CategoryNumber = p.CategoryNumber 
WHERE p.Stock < p.OnOrder 
ORDER BY c.CategoryName;

#Exercise05
-- Show each employee’s total sales
-- Formula: sum(quantity*price - discount*quantity*price)
-- Group by employee
SELECT e.EmployeeID,
       CONCAT(ROUND(SUM((oi.Quantity * p.PricePerUnit) - 
                        (oi.Discount * oi.Quantity * p.PricePerUnit)), 1), ' €') AS TotalSales
FROM tblemployees e
JOIN tblorders o 
   ON e.EmployeeID = o.EmployeeID
JOIN tblorderinformation oi 
   ON o.OrderId = oi.OrderId
JOIN tblproducts p 
   ON oi.ProductNumber = p.ProductNumber
GROUP BY e.EmployeeID;

#Exercise06
-- Show number of products per supplier, grouped by country and company
SELECT s.Country AS 'Country',
       s.Company AS 'Company',
       COUNT(p.ProductNumber) AS 'Number of products'
FROM tblsuppliers s
JOIN tblproducts p 
    ON p.SupplierNumber = s.SupplierId
GROUP BY s.Country, s.Company 
ORDER BY s.Country;

#Exercise07
-- Show number of unique suppliers per category
-- DISTINCT makes sure we don’t double-count
SELECT c.CategoryName AS 'CategoryName',
       COUNT(DISTINCT s.SupplierId) AS UniqueSuppliers
FROM tblcategories c
JOIN tblproducts p 
    ON c.CategoryNumber = p.CategoryNumber
JOIN tblsuppliers s  
    ON p.SupplierNumber = s.SupplierId  
GROUP BY c.CategoryName 
ORDER BY UniqueSuppliers DESC;

#Exercise08
-- Show tax codes from tbltaxrate that are NOT used in products
-- LEFT JOIN + WHERE p.taxcode IS NULL = "orphans"
SELECT t.Taxcode AS 'TaxCode',
       t.TaxPercentage AS 'TaxPercentage'
FROM tbltaxrate t
LEFT JOIN tblproducts p 
    ON t.taxcode = p.taxcode
WHERE p.taxcode IS NULL;

#Exercise09
-- Show products that have never been ordered
-- LEFT JOIN + WHERE o.OrderID IS NULL
SELECT p.ProductName AS 'Product',
       o.Quantity AS 'Quantity'
FROM tblproducts p 
LEFT JOIN tblorderinformation o 
    ON p.ProductNumber = o.ProductNumber
WHERE o.OrderID IS NULL
ORDER BY p.ProductName ASC;

#Exercise10
-- Show revenue per employee (with discount applied)
-- Use LEFT JOIN so employees without sales still show
SELECT CONCAT(ROUND(SUM((oi.Quantity * p.PricePerUnit) -  
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
-- Show products where stock value (price * stock) 
-- is greater than the minimum wage of all employees
SELECT ProductName,
       PricePerUnit,
       Stock,
       PricePerUnit * Stock AS 'Stock Value'
FROM tblproducts
WHERE PricePerUnit * Stock > (SELECT MIN(Wage) FROM tblemployees);

#Exercise12
-- Show customers whose name matches any employee last name
-- Subquery returns all employee last names
SELECT Name, City, Zipcode, Address 
FROM tblcustomers 
WHERE Name IN (SELECT LastName FROM tblemployees);

#Exercise13
-- Show customers who placed orders in 2006 with delivery < 30 days
SELECT CustomerId, Name, Address, Zipcode, City, RegistrationNumber
FROM tblcustomers
WHERE CustomerId IN (
    SELECT CustomerNumber 
    FROM tblorders  
    WHERE YEAR(OrderDate) = 2006 
      AND DATEDIFF(DeliveryDate, OrderDate) < 30
);

#Exercise14
-- Show products that were ordered with discount >= 25%
-- Calculate the discounted total for those products
SELECT p.ProductNumber,
       SUM((oi.Quantity * p.PricePerUnit) * (1 - oi.Discount)) AS DiscountedPrice
FROM tblorders o
JOIN tblorderinformation oi 
    ON o.OrderId = oi.OrderId
JOIN tblproducts p 
    ON oi.ProductNumber = p.ProductNumber
WHERE oi.Discount >= 0.25
GROUP BY p.ProductNumber;

#Exercise15
-- Show employees who never handled any orders
-- Two equivalent versions (RIGHT JOIN vs LEFT JOIN)
SELECT CONCAT(e.LastName, " ", e.FirstName) AS 'Name'
FROM tblemployees e
LEFT JOIN tblorders o 
    ON e.EmployeeID = o.EmployeeID
WHERE o.EmployeeID IS NULL
ORDER BY e.LastName ASC;

#Exercise16
-- Show employees whose employment date is between
-- Smets and Daponte (min and max employment dates)
SELECT e.LastName,
       DATE(e.Employed) AS MonthOfEmployment
FROM tblemployees e 
WHERE e.Employed BETWEEN (
          SELECT MIN(Employed) 
          FROM tblemployees
          WHERE LastName IN ('Smets','Daponte')
      )
      AND 
      (
          SELECT MAX(Employed) 
          FROM tblemployees
          WHERE LastName IN ('Smets','Daponte')
      )
ORDER BY MonthOfEmployment DESC;

#Exercise17
-- Show customers who never placed any orders
SELECT c.company, c.last_name, c.first_name, c.address, c.city
FROM customers c
LEFT JOIN orders o 
    ON c.id = o.customer_id
WHERE o.id IS NULL;

#Exercise19
-- Show statuses from orders_status that are not used in any order
SELECT os.id, os.status_name
FROM orders_status os
LEFT JOIN orders o 
    ON os.id = o.status_id
WHERE o.id IS NULL;

#Exercise20
-- Merge customers and employees into one list
-- UNION makes one result set with same columns
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
-- Show how many employees have each privilege
-- COALESCE ensures 'No privilege' is shown instead of NULL
SELECT COALESCE(p.privilege_name, 'No privilege') AS 'Privilege',
       COUNT(*) AS 'Assigned'
FROM employees e
LEFT JOIN employee_privileges ep
    ON e.id = ep.employee_id
LEFT JOIN privileges p
    ON ep.privilege_id = p.id
GROUP BY COALESCE(p.privilege_name, 'No privilege');

#Exercise22
-- Show revenue per order (after discount), grouped by order + month
-- Format revenue with 2 decimals
SELECT o.id AS order_id, 
       DATE_FORMAT(o.order_date, "%Y-%m") AS order_month,
       FORMAT(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2, 'en_US') AS revenue
FROM orders o
JOIN order_details od 
    ON o.id = od.order_id
WHERE o.id >= 78
GROUP BY o.id, order_month
ORDER BY order_month, revenue DESC;

#Exercise23
-- Show revenue per order per product (with product name and quantity)
-- Group by order, product, and month
SELECT o.id AS order_id, 
       DATE_FORMAT(o.order_date, "%Y-%m") AS order_month,
       od.product_id,
       p.product_name,
       od.quantity,
       FORMAT(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2, 'en_US') AS revenue
FROM orders o
JOIN order_details od 
    ON o.id = od.order_id
JOIN products p 
    ON od.product_id = p.id
WHERE o.id >= 78
GROUP BY o.id, order_month, od.product_id, p.product_name, od.quantity
ORDER BY SUM(od.unit_price * od.quantity * (1 - od.discount)) DESC;


