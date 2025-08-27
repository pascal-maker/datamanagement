
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

 #Exercise5lab4
 SELECT e.LastName AS `LastName`,
 CONCAT(ROUND(SUM((oi.quantity*p.PricePerUnit) - (oi.Discount*oi.Quantity*p.PricePerUnit)),1),'€') AS `Revenue`
 from tblemployees AS e JOIN tblorders AS o 
 ON e.EmployeeID = o.EmployeeID 
 JOIN tblorderinformation AS oi ON oi.OrderID = o.OrderID
 JOIN tblproducts AS p on oi.ProductNumber = p.ProductNumber
 GROUP BY `LastName`
ORDER BY `Revenue` DESC;

/*Omdat oi.Discount geen absoluut bedrag is, maar een procentuele korting op de volledige orderregel — dus je moet het bedrag berekenen waarop de korting slaat.
 * 💡 SQL Join Insight (Lab04 - Exercise 5)
 *
 * When doing joins like: Orders → OrderLines → Products,
 * the `PricePerUnit` is already included via the join:
 *   oi.ProductNumber = p.ProductNumber
 *
 * 👉 No need to match or filter `PricePerUnit` again —
 *    it’s already part of each row after the join.
 *
 * 🧮 Revenue per order line is calculated as:
 *    (Quantity × PricePerUnit) - (Discount × Quantity × PricePerUnit)
 *
 * 🔁 Use SUM(...) to get total revenue per employee:
 *    GROUP BY e.EmployeeID
 *het gata hier over many to many daarom dat we erst employeeid verbinden emt order id end an order id gaan verbindem aan deo order id van orinderomfation id toch
 * 🎯 Format the result using:
 *    ROUND(..., 1)  → round to 1 decimal
 *    CONCAT(..., '€') → add euro symbol to result
 */


#Exercise06
-- Show number of products per supplier, grouped by country and company
 #Exercise6lab4
 SELECT s.Country AS `Country`, S.Company AS `Company`,  CONCAT(COUNT(p.ProductNumber),'product',IF(COUNT(p.ProductNumber) = 1, '' , 's')
 )AS `Number of Products` from tblsuppliers AS s join tblproducts AS p ON
 s.SupplierId = p.SupplierNumber
 GROUP BY  `Country` ,`Company`
 ORDER BY `Country`,  `Company` ASC; 
-- This line creates a grammatically correct label like '1 product' or '3 products':
-- CONCAT(...) combines:
--   - COUNT(p.ProductNumber): the number of products per supplier
--   - ' product': the base word
--   - IF(COUNT(...) = 1, '', 's'): adds 's' only when the count is not 1 (for plural)
-- Final result: e.g., '1 product' or '5 products'

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
--we gaan hier gaan linken met  met products odmat products wel een link heeft met supplier via suoolieernumber heir si sorake van many to many.

#Exercise08
-- Show tax codes from tbltaxrate that are NOT used in products
-- LEFT JOIN + WHERE p.taxcode IS NULL = "orphans"
SELECT t.Taxcode AS 'TaxCode',
       t.TaxPercentage AS 'TaxPercentage'
FROM tbltaxrate t
LEFT JOIN tblproducts p 
    ON t.taxcode = p.taxcode
WHERE p.taxcode IS NULL;
-- Exercise08: Toon alle taxcodes uit tbltaxrate die NIET gebruikt worden in tblproducts
--
--  LEFT JOIN + IS NULL patroon (voor het vinden van 'wees'-records)
--
-- - LEFT JOIN zorgt ervoor dat alle taxcodes uit tbltaxrate zichtbaar blijven,
--   zelfs als ze niet gekoppeld zijn aan een product
-- - Als een taxcode niet gebruikt wordt in tblproducts, dan is p.taxcode NULL
-- - WHERE p.taxcode IS NULL filtert net die rijen eruit: de ongebruikte taxcodes
--
--  Handig om overbodige of vergeten taxcodes op te sporen

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
-- 💡 LEFT vs RIGHT JOIN uitleg:
-- 
-- Gebruik LEFT JOIN als je alle rijen uit de linkertabel wil behouden.
-- Gebruik RIGHT JOIN als je alle rijen uit de rechtertabel wil behouden.
-- 
-- Het principe blijft hetzelfde: je kiest de kant waarvan je *alles* wil zien.
-- 
-- Voorbeeld:
-- - Als je tblproducts links zet en je wil ook producten zonder bestellingen zien → LEFT JOIN
-- - Zet je tblproducts rechts en je wil nog steeds alle producten tonen → gebruik RIGHT JOIN
--
-- Dus: keuze van LEFT of RIGHT hangt af van welke kant je "volledig" wil tonen in het resultaat.


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
-- 💡 Waarom 3× LEFT JOIN?
-- 
-- LEFT JOIN tblorders:
--   → Toon ook werknemers zonder bestellingen
--
-- LEFT JOIN tblorderinformation:
--   → Houd bestellingen zonder orderregels zichtbaar (bv. nog niet ingevuld)
--
-- LEFT JOIN tblproducts:
--   → Zorg dat orderregels zonder geldig productnummer (fout of verwijderd) blijven meetellen
--
-- Als je INNER JOIN gebruikt op een van deze, riskeer je dat rijen wegvallen
-- waardoor de omzetberekening (SUM) onvolledig of fout wordt.

#Exercise11
-- Show products where stock value (price * stock) 
-- is greater than the minimum wage of all employees
SELECT ProductName,
       PricePerUnit,
       Stock,
       PricePerUnit * Stock AS 'Stock Value'
FROM tblproducts
WHERE PricePerUnit * Stock > (SELECT MIN(Wage) FROM tblemployees);

 #Exercise11lab4
 SELECT p.ProductName, p.PricePerUnit, p.Stock,CONCAT(PricePerUnit*Stock) AS `Stock Value` from tblproducts AS p join 
tblorderinformation  AS oi ON p.productNumber = oi.ProductNumber join tblorders AS o ON  oi.OrderID = o.OrderID JOIN tblemployees e
 ON e.EmployeeID = o.EmployeeID
 WHERE (p.PricePerUnit* p.Stock) > (SELECT MIN(Wage) FROM tblemployees);
 #geen `strock value` want where wordt eerst utgevoerd en
 #where zo stock value niet  herkennen

#Exercise12
-- Show customers whose name matches any employee last name
-- Subquery returns all employee last names
SELECT Name, City, Zipcode, Address 
FROM tblcustomers 
WHERE Name IN (SELECT LastName FROM tblemployees);

#Exercise13


SELECT CustomerId,Name,Address,Zipcode,City,RegistrationNumber 
from tblcustomers WHERE CustomerId  IN (SELECT CustomerNumber from tblorders
 WHERE YEAR(DeliveryDate) = 2006 AND DATEDIFF(DeliveryDate,OrderDate) < 30)
 ORDER BY CustomerId;
 
 #DAY(...) = day number of the month (1–31) → ❌ not suitable for comparing time gaps

#DATEDIFF(...) = total days between two dates → ✅ correct for checking delivery time
 


#Exercise14
-- Show products that were ordered with discount >= 25%
-- Calculate the discounted total for those products
SELECT DISTINCT
    p.ProductName, 
    p.PricePerUnit
FROM tblproducts p
JOIN tblorderinformation oi 
    ON p.ProductNumber = oi.ProductNumber
WHERE oi.Discount >= 0.25;
#je wilr geen dubbele waarden dus je gebrukt distinct

#Exercise15
-- Show employees who never handled any orders
-- Two equivalent versions (RIGHT JOIN vs LEFT JOIN)
SELECT CONCAT(e.LastName, " ", e.FirstName) AS 'Name'
FROM tblemployees e
LEFT JOIN tblorders o 
    ON e.EmployeeID = o.EmployeeID
WHERE o.EmployeeID IS NULL
ORDER BY e.LastName ASC;

#Exercise15alternatief
SELECT CONCAT(e.LastName, " ", e.FirstName) AS 'Name'
FROM tblemployees e
LEFT JOIN tblorders o 
    ON e.EmployeeID = o.EmployeeID
WHERE o.OrderID IS NULL

#Exercise16
-- Show employees whose employment date is between
-- Smets and Daponte (min and max employment dates)
SELECT 
    e.LastName,
    MONTH(e.Employed) AS MonthOfEmployment
FROM tblemployees e
WHERE e.Employed BETWEEN (
    SELECT MIN(Employed)
    FROM tblemployees
    WHERE LastName IN ('Smets', 'Daponte')
)
AND (
    SELECT MAX(Employed)
    FROM tblemployees
    WHERE LastName IN ('Smets', 'Daponte')
)
ORDER BY MonthOfEmployment DESC;
-- 💡 Uitleg bij de BETWEEN-subquery:
--
-- WHERE e.Employed BETWEEN (
--     SELECT MIN(Employed)
--     FROM tblemployees
--     WHERE LastName IN ('Smets', 'Daponte')
-- )
-- AND (
--     SELECT MAX(Employed)
--     FROM tblemployees
--     WHERE LastName IN ('Smets', 'Daponte')
-- )
--
-- ✅ Doel:
-- Toon alle werknemers die in dienst zijn genomen tussen de aanwervingsdatums
-- van 'Smets' en 'Daponte'
--
-- 🧠 Wat doet dit precies?
-- - De eerste subquery geeft de vroegste van de twee datums terug (MIN)
-- - De tweede subquery geeft de laatste van de twee datums terug (MAX)
-- - De hoofdquery controleert of e.Employed (aanwervingsdatum) daartussen ligt
--
-- 🔁 BETWEEN is inclusief → werknemers die exact op dezelfde datum zijn gestart als Smets of Daponte worden ook getoond


#Exercise17
-- Show customers who never placed any orders
SELECT c.company, c.last_name, c.first_name, c.address, c.city
FROM customers c
LEFT JOIN orders o 
    ON c.id = o.customer_id
WHERE o.id IS NULL;

-- 💡 Waarom je GEEN c.id IS NULL mag gebruiken in deze query:
--
-- We gebruiken hier een LEFT JOIN:
--   FROM customers c
--   LEFT JOIN orders o ON c.id = o.customer_id
--
-- Doel: toon klanten waarvoor GEEN overeenkomstige bestelling bestaat
--
-- ✅ Dus we doen: WHERE o.id IS NULL
--   → Dit betekent: "de klant heeft geen bestellingen" (de rechtertabel is NULL)
--
-- ❌ Maar c.id IS NULL werkt NIET:
--   - c.id is afkomstig uit de linkertabel (customers), en die bestaat altijd
--   - c.id is meestal een PRIMARY KEY en kan dus nooit NULL zijn
--   - Resultaat: de WHERE-clausule zou altijd FALSE zijn → je krijgt GEEN rijen terug
--
-- ✅ Samenvatting:
--   - Gebruik o.id IS NULL (of eventueel o.customer_id IS NULL) om klanten zonder orders te tonen
--   - Gebruik NOOIT c.id IS NULL in deze context

#Exercise18
SELECT c.id AS 'CustomerId' , c.country_region AS 'country_region' from customers c
WHERE (c.id,c.country_region) in
(SELECT o.customer_id,o.ship_country_region from orders o);

#Exercise19
-- Show statuses from orders_status that are not used in any order
SELECT os.id, os.status_name
FROM orders_status os
LEFT JOIN orders o 
    ON os.id = o.status_id
WHERE o.id IS NULL;
-- 💡 Waarom je HIER ook GEEN os.id IS NULL mag gebruiken:
--
-- Deze query zoekt naar statuswaarden uit orders_status die NIET gekoppeld zijn aan een bestelling
-- 
-- We gebruiken:
--   LEFT JOIN orders o ON os.id = o.status_id
--   WHERE o.id IS NULL
-- 
--  Dit werkt omdat:
--   - Bij LEFT JOIN worden ALLE rijen uit orders_status behouden
--   - Als een status niet gebruikt is, zijn alle kolommen van 'orders' NULL
--

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
-- 💡 Doel van deze query:
-- - Combineer klanten en werknemers in één lijst
-- - Toon naam, stad, adres
-- - Geef duidelijk aan of het om een 'Customer' of 'Employee' gaat
-- 
-- 🧠 Waarom UNION?
-- - We willen geen koppeling maken via een JOIN (er is geen gemeenschappelijk veld)
-- - We willen beide tabellen 'onder elkaar' tonen = verticale samenvoeging
-- - De kolommen moeten exact overeenkomen in aantal en datatype
--
-- 📝 Let op:
-- - CONCAT() plakt voornaam en achternaam samen met spatie
-- - Gebruik UNION ALL als je ook dubbele rijen wilt tonen
-- - ORDER BY mag je op het einde van de hele UNION gebruiken

#Exercise21
SELECT  count(e.id) AS `Number of empolyees without privileges`from employees e
left join employee_privileges ep on e.id = ep.employee_id
WHERE ep.privilege_id IS NULL

UNION

SELECT  count(e.id) AS `Number of empolyees with privileges`from employees e

JOIN employee_privileges ep 
ON e.id = ep.employee_id;

# Exercise 21 – Toon het aantal werknemers met en zonder privileges
#
# ✅ Doel:
# - Toon hoeveel werknemers een privilege hebben
# - Toon hoeveel werknemers GEEN privilege hebben
# - Zet beide resultaten samen in één overzicht
#
# ✅ Waarom gebruiken we UNION?
# - We doen twee aparte tellingen (met privilege / zonder privilege)
# - Beide SELECTs geven hetzelfde type output (1 label + 1 getal)
# - UNION voegt de resultaten onder elkaar samen tot één tabel
# - Dus: het is een verticale samenvoeging, géén vergelijking of koppeling
#
# ✅ Belangrijk:
# - Beide SELECTs moeten exact evenveel kolommen hebben
# - De kolommen moeten qua datatype overeenkomen (bv. tekst + getal)
# - We gebruiken labels zoals 'With Privileges' en 'Without Privileges' als tekstkolom


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
# Exercise 22
# 📊 Doel: Toon de totale omzet per bestelling (na korting), gegroepeerd per maand
# ---------------------------------------------------------------
# ✅ order_id          → ID van de bestelling
# ✅ order_month       → maand waarin de bestelling geplaatst is
# ✅ revenue           → totaalbedrag van de bestelling, na korting
# ---------------------------------------------------------------
# 📌 FORMAT(..., 2, 'en_US') → zorgt dat de omzet netjes als 'xx.xx' verschijnt
# 📌 GROUP BY o.id, order_month → groepeert per bestelling én per maand
# 📌 WHERE o.id >= 78 → filtert alleen recente of latere bestellingen
# 📌 ORDER BY → sorteert chronologisch en toont hoogste omzet eerst binnen de maand
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
ORDER BY  od.quantity DESC;


# FORMAT(SUM(od.unit_price * od.quantity * (1 - od.discount)), 2, 'en_US') AS revenue
#
# 💡 Wat doet dit?
# - unit_price * quantity         → berekent brutoprijs per orderregel
# - * (1 - discount)              → past korting toe → geeft nettoprijs
# - SUM(...)                      → telt alle nettoprijzen op per groep
# - FORMAT(..., 2, 'en_US')       → toont het bedrag netjes met 2 decimalen (bv. '34.00')
# - 'en_US'                       → gebruikt punt als decimaalteken
# - AS revenue                    → kolomnaam in de output
# Exercise 23
# 📊 Doel: Toon de omzet per product, per bestelling, per maand
# ---------------------------------------------------------------
# ✅ order_id          → ID van de bestelling
# ✅ order_month       → maand van bestelling
# ✅ product_id        → ID van het product
# ✅ product_name      → naam van het product
# ✅ quantity          → aantal verkochte stuks
# ✅ revenue           → totaalprijs na korting (per productregel)
# ---------------------------------------------------------------
# 📌 FORMAT(..., 2, 'en_US') → toont nette bedragen met 2 decimalen
# 📌 GROUP BY → groepeert op combinatie van order + maand + product
# 📌 ORDER BY quantity DESC → meest verkochte producten eerst
