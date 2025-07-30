use salesdb;
#Exercise01
SELECT c.LastName,c.FirstName,s.Quantity FROM sales s JOIN customers c ON s.CUstomerID = c.CustomerID 
WHERE c.LastName Like 'HA%' OR c.LastName LIKE 'ha%';

#Exercise02
SELECT c.Description,CONCAT(COALESCE(SUM(s.Quantity),0),'pieces') AS UnitsSold FROM categories
 c LEFT JOIN products p on c.CategoryID = p.CategoryID LEFT JOIN sales s on p.ProductID = s.ProductID GROUP BY
 c.Description ORDER BY COALESCE(SUM(s.Quantity),0)DESC;
 
 #Exercise03
 SELECT s.SalesID,CONCAT(s.Quantity,'pieces') AS QuantitySold, DATE_FORMAT(s.SalesDate, '%d/%m/%Y') AS SaleDateFormatted FROM sales s WHERE DAYOFWEEK(s.SalesDATE) IN (1,7)
 ORDER BY s.SalesDate DESC;
 
#Exercise04
SELECT p.Name, SUM(s.Quantity) as TotalSALES from sales s JOIN products  p on s.ProductID = p.ProductId  
WHERE s.SalesDate BETWEEN '2020-03-15 ' AND '2020-04-30' GROUP BY p.Name HAVING SUM(s.Quantity) > 100 ORDER BY TotalSales DESC;

#Exercise05
INSERT INTO sales (SalesPersonID, CustomerID, ProductID, Quantity, SalesDate)
SELECT 
    (SELECT SalesPersonID FROM sales ORDER BY SalesPersonID DESC LIMIT 1),
    (SELECT c.CustomerID 
     FROM customers c 
     JOIN sales s ON c.CustomerID = s.CustomerID 
     GROUP BY c.CustomerID 
     ORDER BY SUM(s.Quantity) DESC 
     LIMIT 1),
    (SELECT ProductID FROM products WHERE Name = 'Racing Socks, L' LIMIT 1),
    2,
    CURDATE();
