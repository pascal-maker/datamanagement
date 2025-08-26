USE artemis;
USE adventureworks2014;

-- Zorgt dat je GROUP BY queries flexibeler kan gebruiken
SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

#Exercise01
SELECT LastName, FirstName,
       IF(Car = 1, "has a company car", "Does not have a company car")
FROM tblemployees
ORDER BY LastName ASC;
-- ➝ Toont de achternaam, voornaam en of de werknemer een bedrijfswagen heeft (Car=1).

#Exercise02
SELECT 
  CustomerNumber,
  IF(DeliveryDate IS NULL, 'Not been delivered yet', DeliveryDate) AS DeliveryDate,
  IF(DeliveryDate IS NULL, 'Not been delivered yet', ShippingCost) AS ShippingCost
FROM tblOrders;
--   verschijnt er "Has not been delivered yet".

#Exercise03
SELECT CategoryNumber,
       CONCAT(COUNT(ProductNumber),
              IF(COUNT(ProductNumber) = 1, ' product', ' products')) AS CategoryNumber
FROM tblproducts
WHERE PricePerUnit > 50
GROUP BY CategoryNumber;
-- ➝ Telt het aantal producten per categorie die meer dan 50 kosten.
--   Voegt dynamisch "product" of "products" toe, afhankelijk van de telling.

#Exercise04
SELECT City,
       COUNT(CustomerId) AS `Number of customers`
FROM tblcustomers
GROUP BY City
ORDER BY `Number of customers` DESC;
-- ➝ Telt klanten per stad en sorteert van groot naar klein.

#Exercise05
SELECT City,
       COUNT(CustomerId) AS `Number of customers`
FROM tblcustomers
GROUP BY City
HAVING `Number of customers` > 3
ORDER BY `Number of customers` DESC;
-- ➝ Zelfde als Exercise04, maar filtert enkel steden met meer dan 3 klanten.

#Exercise06
SELECT COUNT(EmployeeID) AS `Number Of Employees`, Jobtitle
FROM tblemployees
GROUP BY Jobtitle;
-- ➝ Toont per functietitel hoeveel werknemers er zijn.

#Exercise07
SELECT IF(Gender=1, 'Man', 'Vrouw') AS Gender,
       COUNT(EmployeeID) AS `Number Of Employees`,
       Jobtitle
FROM tblemployees
GROUP BY Jobtitle
ORDER BY Jobtitle ASC;
-- ➝ Geeft aantal werknemers per functie én toont geslacht.
--   Let op: nu groepeert dit enkel per Jobtitle, dus man/vrouw wordt niet apart geteld.
--   Voor correcte telling moet je ook GROUP BY Gender toevoegen.

#Exercise08
SELECT COUNT(CustomerId), RegistrationNumber
FROM tblcustomers
WHERE RegistrationNumber IS NULL;
-- ➝ Telt klanten zonder registratienummer.

#Exercise09
SELECT CategoryNumber,
       COUNT(ProductNumber) AS `Number of Products`,
       CONCAT(ROUND(SUM(Stock*PricePerUnit),2),'€') AS `Stock Value`
FROM tblproducts
GROUP BY CategoryNumber;
-- ➝ Toont per categorie het aantal producten en totale voorraadwaarde.

#Exercise10
SELECT SupplierNumber, CategoryNumber,
       CONCAT(COUNT(ProductNumber),' Pieces') AS `Number of Products`,
       CONCAT(ROUND(SUM(Stock*PricePerUnit),2),'€') AS `Stock Value`
FROM tblproducts
WHERE SupplierNumber = 4
GROUP BY CategoryNumber
ORDER BY CategoryNumber ASC;
-- ➝ Toont per categorie de producten en waarde, maar enkel voor leverancier 4.

#Exercise11
SELECT SupplierNumber, CategoryNumber,
       CONCAT(COUNT(ProductNumber),' Pieces') AS `Number of Products`,
       CONCAT(ROUND(SUM(Stock*PricePerUnit),2),'€') AS `Stock Value`
FROM tblproducts
WHERE SupplierNumber = 4
GROUP BY CategoryNumber, SupplierNumber
HAVING SUM(Stock*PricePerUnit) > 1000;
-- ➝ Zelfde als Exercise10, maar filtert categorieën met voorraadwaarde > 1000.

# Toon de gemiddelde levertijd per jaar
SELECT 
    YEAR(DeliveryDate) AS Year,   # Haal het jaartal uit de leverdatum
    CONCAT(
        ROUND(AVG(DATEDIFF(DeliveryDate, OrderDate)), 0),  # Bereken gemiddelde levertijd in dagen, afgerond
        ' days'                                            # Voeg de tekst "days" toe voor leesbaarheid
    ) AS AverageDeliveryTime
FROM tblorders
GROUP BY YEAR(DeliveryDate)    # Groepeer alle orders per leverjaar
ORDER BY Year;                 # Sorteer chronologisch per jaar


#Exercise12
SELECT YEAR(DeliveryDate) AS Year,
       CONCAT(ROUND(AVG(DATEDIFF(DeliveryDate, OrderDate)), 0), ' days') AS AverageDeliveryTime
FROM tblorders
GROUP BY YEAR(DeliveryDate)
ORDER BY Year;
-- ➝ Berekent de gemiddelde levertijd (in dagen) per jaar.

#Exercise13
SELECT FirstName, MiddleName, LastName, BusinessEntityID
FROM Person
WHERE (MiddleName LIKE 'J%' AND LastName LIKE "%Alexander%")
   OR (MiddleName LIKE 'J%' AND LastName LIKE "%Zhang%");
-- ➝ Haalt personen op met een middle name die met J begint én achternaam Alexander of Zhang.

#Exercise14
SELECT ProductID, Name, Size, Color
FROM Product
WHERE Color IS NULL OR Size IS NULL;
-- ➝ Toont producten zonder kleur of maat.

#Exercise15
SELECT 'Product INFO ' AS Info,
       COUNT(ProductID) AS `Number of Products`,
       ROUND(AVG(SIZE),0) AS `Average Size`
FROM Product
WHERE Color IS NOT NULL
  AND Size IS NOT NULL
  AND Size NOT IN ('M','XL','L','S');
-- ➝ Toont aantal producten en gemiddelde maat (numeriek), excl. standaard maten.

#Exercise16
SELECT FirstName,MiddleName,
LastName from Person WHERE LastName REGEXP  '^V' OR  LastName REGEXP'^W'
ORDER BY LastName DESC;
-- ➝ Toont namen van personen waarvan achternaam begint met V of W.

#Exercise17
SELECT CONCAT_WS(' ', BusinessEntityID, FirstName, MiddleName, LastName) AS FullName
FROM Person
WHERE LastName REGEXP '^[VW]'
ORDER BY BusinessEntityID ASC;
-- ➝ Zelfde als Exercise16, maar voegt ook ID toe en sorteert op ID.

#Exercise18
SELECT DISTINCT FirstName
FROM Person
WHERE FirstName = REVERSE(FirstName);
-- ➝ Zoekt palindroom voornamen (bvb. "Anna", "Bob").

#Exercise19
SELECT LOCATE("@",EmailAddress)   FROM ProductReview;
SELECT SUBSTRING(EmailAddress,Locate('@',EmailAddress) + 1 )AS DomainName FROM ProductReview;
# Stap 1: Vind de positie van het @-teken in het e-mailadres
SELECT LOCATE('@', EmailAddress) 
FROM ProductReview;
# Voorbeeld: 'john.doe@gmail.com' → resultaat = 9

# Stap 2: Pak alles NA het @-teken
SELECT SUBSTRING(EmailAddress, LOCATE('@', EmailAddress) + 1) AS DomainName
FROM ProductReview;
# Voorbeeld: 'john.doe@gmail.com' → resultaat = 'gmail.com'


-- ➝ Haalt domeinnaam uit e-mailadres.



#Exercise20
SELECT DISTINCT Jobtitle
FROM employee
ORDER BY Jobtitle ASC;
-- ➝ Toont alle unieke jobtitels alfabetisch.

#Exercise21
SELECT FirstName
FROM Person
WHERE FirstName LIKE '%K%';
-- ➝ Toont alle voornamen die een K bevatten.

#Exercise22
SELECT count(SalesOrderID) as Orders, SalesPersonID, AVG(TotalDue) 
AS AvgOrderValue from salesorderheader
GROUP BY SalesPersonID 
HAVING Orders > 50
 ORDER BY SalesPersonID ASC;
-- ➝ Gemiddelde orderwaarde per verkoper met minstens 50 orders.

#Exercise23
SELECT YEAR(OrderDate) AS Year,
       QUARTER(OrderDate) AS Quarter,
       COUNT(SalesOrderNumber) AS TotalOrders
FROM SalesOrderHeader
GROUP BY Year, Quarter
ORDER BY 1,2;
-- ➝ Telt aantal orders per jaar en kwartaal.

#Exercise24
SELECT MONTH(OrderDate) AS Maand,
       COUNT(*) AS TotalOrders
FROM SalesOrderHeader
GROUP BY MONTH(OrderDate)
ORDER BY Maand;
-- ➝ Telt aantal orders per maand.

#Exercise25
#Exercise25
SELECT CustomerID,YEAR(OrderDate) ,  sum(TotalDue) AS 'Total Amount' from salesorderheader
GROUP BY CustomerID ,YEAR(OrderDate)
ORDER By CustomerID ASC;
-- ➝ Toont per klant en per jaar de totale bestelwaarde.
