-- Q1 Test Solutions
-- Database: salesdb
-- Tables: customers, products, sales, categories, employees

-- Query 1: Show all products that have ever been purchased by customers whose last name starts with 'ha' or 'Ha'
-- In addition to the product name, also display the quantity ordered. (#17)
SELECT DISTINCT p.Name AS ProductName, s.Quantity
FROM sales s
JOIN products p ON s.ProductID = p.ProductID
JOIN customers c ON s.CustomerID = c.CustomerID
WHERE c.LastName LIKE 'ha%' OR c.LastName LIKE 'Ha%'
ORDER BY p.Name;

-- Query 2: Create an overview of sales per category, namely for each category, display the number of units sold
-- Add " pieces" at the end of the number. ALL categories should be shown. The category with the highest number of products should be at the top. (#7)
SELECT c.Description AS Category, 
       CONCAT(COALESCE(SUM(s.Quantity), 0), ' pieces') AS UnitsSold
FROM categories c
LEFT JOIN products p ON c.CategoryID = p.CategoryID
LEFT JOIN sales s ON p.ProductID = s.ProductID
GROUP BY c.CategoryID, c.Description
ORDER BY SUM(s.Quantity) DESC;

-- Query 3: Display the quantities sold for sales made over the weekend (on either Saturday or Sunday), with each quantity followed by the word "pieces"
-- Show the salesid, quantities sold, and sale date in the format 'day/month/year'. Sort the results in descending order by sale date. (#285)
SELECT s.SalesID,
       CONCAT(s.Quantity, ' pieces') AS QuantitiesSold,
       DATE_FORMAT(s.SalesDate, '%d/%m/%Y') AS SaleDate
FROM sales s
WHERE DAYOFWEEK(s.SalesDate) IN (1, 7)  -- 1 = Sunday, 7 = Saturday
ORDER BY s.SalesDate DESC;

-- Query 4: Create an overview of sales between March 15, 2020, and April 30, 2020, inclusive
-- Group by product name and display the total sales for each product
-- Limit the results to products sold more than 100 times and sort the list in descending order by total sales. (#209)
SELECT p.Name AS ProductName,
       SUM(s.Quantity) AS TotalSales
FROM sales s
JOIN products p ON s.ProductID = p.ProductID
WHERE s.SalesDate BETWEEN '2020-03-15' AND '2020-04-30'
GROUP BY p.ProductID, p.Name
HAVING SUM(s.Quantity) > 100
ORDER BY TotalSales DESC;

-- Query 5: Add a new sales record with the following specifications:
-- 1. The employee must be the most recently added employee
-- 2. The customer must be the customer who has purchased the highest total quantity of products
-- 3. The product being sold is 'Racing Socks, L'
-- 4. The quantity is 2
-- 5. The sale date must be the current date
-- Use a single query to complete this query
INSERT INTO sales (SalesPersonID, CustomerID, ProductID, Quantity, SalesDate)
SELECT 
    (SELECT EmployeeID FROM employees ORDER BY EmployeeID DESC LIMIT 1) AS SalesPersonID,
    (SELECT CustomerID FROM (
        SELECT s.CustomerID, SUM(s.Quantity) as TotalQuantity
        FROM sales s
        GROUP BY s.CustomerID
        ORDER BY TotalQuantity DESC
        LIMIT 1
    ) AS top_customer) AS CustomerID,
    (SELECT ProductID FROM products WHERE Name = 'Racing Socks, L') AS ProductID,
    2 AS Quantity,
    CURDATE() AS SalesDate;
