#oefening1
SELECT CustomerId, Name, Address, CONCAT(zipcode, city) AS 'Zipcode & City'
FROM tblcustomers;
-- ➝ Haalt klantgegevens op (ID, naam, adres) en plakt postcode + stad samen.

#oefening2
SELECT CustomerId, Name, Address, CONCAT(zipcode, city) AS 'Zipcode & City'
FROM tblcustomers
WHERE Balance BETWEEN 150 AND 300;
-- ➝ Zelfde als oefening1, maar toont alleen klanten met een balans tussen 150 en 300.

#oefening3
SELECT BirthDate
FROM tblemployees
WHERE MONTH(BirthDate) BETWEEN 07 AND 08;
-- ➝ Toont geboortedata van werknemers geboren in juli of augustus.

#oefening4
SELECT BirthDate
FROM tblemployees
WHERE MONTH(BirthDate) NOT BETWEEN 07 AND 08;
-- ➝ Toont geboortedata van werknemers geboren in andere maanden.

#Exercise05
SELECT BirthDate
FROM tblemployees
WHERE BirthDate BETWEEN '1960-01-01' AND '1966-01-27';
-- ➝ Toont werknemers geboren tussen 1 jan 1960 en 27 jan 1966.

#Exercise06
SELECT CustomerId, Name, City
FROM tblcustomers
WHERE City = 'Leuven' OR City = 'Herent' OR City = 'Kessel-Lo' OR City = 'Heverlee';
-- ➝ Haalt klanten op die wonen in Leuven, Herent, Kessel-Lo of Heverlee.

#Exercise07
SELECT CustomerId, Name, City
FROM tblcustomers
WHERE City != 'Leuven' AND City != 'Herent' AND City != 'Kessel-Lo' AND City != 'Heverlee';
-- ➝ Haalt klanten op die NIET uit Leuven, Herent, Kessel-Lo of Heverlee komen.

#Exercise08
SELECT CONCAT(NederlandseNaam, '(', ProductName, ') ') AS `Naam (Product)`, CategoryNumber
FROM tblproducts
WHERE CategoryNumber IN (1,2,3,4,8)
ORDER BY CategoryNumber, NederlandseNaam;
-- ➝ Combineert Nederlandse en Engelse productnaam voor geselecteerde categorieën.

#Exercise09
SELECT ProductName
FROM tblproducts
WHERE ProductName LIKE '%Louisiana%';
-- ➝ Zoekt producten met "Louisiana" in de naam.

#Exercise10
SELECT QuantityPerUnit
FROM tblproducts
WHERE QuantityPerUnit LIKE '%Boxes%'
   OR QuantityPerUnit LIKE '%Bottles%'
   OR QuantityPerUnit LIKE '%Bottle%';
-- ➝ Toont producten waarvan de verpakking "boxes" of "bottle(s)" bevat.

#Exercise11
SELECT ProductName, QuantityPerUnit, PricePerUnit
FROM tblproducts
WHERE PricePerUnit < 32
ORDER BY PricePerUnit DESC;
-- ➝ Geeft producten goedkoper dan 32, gesorteerd van duur naar goedkoop.

#Exercise12
SELECT CONCAT(Name, ' from ', City) AS 'Customer Name'
FROM tblcustomers
WHERE Name LIKE '%Vander%';
-- ➝ Toont klantnaam + stad, enkel klanten met "Vander" in hun naam.

#Exercise13
SELECT Name
FROM tblcustomers
WHERE NAME LIKE 'Vander%t';
-- ➝ Klantennamen die beginnen met "Vander" en eindigen op "t".

#Exercise14
SELECT Name AS 'Customer name', Address
FROM tblcustomers
WHERE Address LIKE '%Dorp%';
-- ➝ Toont klanten die in een adres met "Dorp" wonen.

#Exercise15
SELECT Company
FROM tblsuppliers
WHERE Company LIKE '%foot%' OR Company LIKE '%an%';
-- ➝ Toont leveranciers met "foot" of "an" in hun bedrijfsnaam.

#Exercise16
SELECT ProductName
FROM tblproducts
WHERE ProductName REGEXP '^chef' AND ProductName REGEXP 'mix$';
-- ➝ Zoekt producten waarvan de naam begint met "chef" en eindigt op "mix".

#Exercise17
-- Kies de kolom met productnamen
SELECT ProductName
-- Uit de tabel met producten
FROM tblproducts
-- Filter: case-sensitive (utf8mb4_bin) regexp die een kleine 'c' ergens in de naam zoekt
WHERE ProductName COLLATE utf8mb4_bin REGEXP 'c'
-- Sorteer alfabetisch op productnaam
ORDER BY ProductName;
-- ➝ Case-sensitive: toont producten met een kleine letter "c" in de naam.

#Exercise18
-- Kies de kolom met productnamen
SELECT ProductName
-- Uit de tabel met producten
FROM tblproducts
-- Filter: case-sensitive regexp voor één van drie tekens: 'c', 'y' of hoofdletter 'B'
WHERE ProductName COLLATE utf8mb4_bin REGEXP 'c'
   OR ProductName COLLATE utf8mb4_bin REGEXP 'y'
   OR ProductName COLLATE utf8mb4_bin REGEXP 'B'
-- Sorteer alfabetisch op productnaam
ORDER BY ProductName;
-- ➝ Case-sensitive: toont producten die 'c', 'y' of 'B' bevatten.

#Exercise19
-- Toon zowel het saldo als de naam, zodat de context duidelijk is
SELECT Balance, Name
-- Uit de klantentabel
FROM tblcustomers
-- Filter: behandelt Balance als tekst (collatie) en matcht exact 4 niet-spatie tekens
-- Opmerking: dit test de TEXTUELE lengte van Balance, niet de numerieke waarde
WHERE Balance COLLATE utf8mb4_bin REGEXP '^[^\s]{4}$';
-- ➝ Klanten waarvan Balance exact 4 tekens lang is (zonder spaties).

#Exercise20
-- Selecteer het belastingpercentage
SELECT TaxPercentage
-- Uit de btw-tabel
FROM tbltaxrate
-- Filter: tekstpatroon '0.xx' met exact twee cijfers na de punt
WHERE TaxPercentage COLLATE utf8mb4_bin REGEXP '^0\\.[0-9]{2}$';
-- ➝ Toont belastingpercentages in de vorm 0.xx (bvb. 0.05).

#Exercise21
SELECT City, Name, Type
FROM tblcustomers
WHERE Type IN ('T','W')
ORDER BY Type, Name;
-- ➝ Klanten met type T of W, alfabetisch gesorteerd per type en naam.

#Exercise22
SELECT City, Name, Type
FROM tblcustomers
WHERE Type IN ('T','W')
ORDER BY Type = 'T' DESC, Name;
-- ➝ Zelfde klanten, maar sorteert eerst Type T boven W.

#Exercise23
SELECT CONCAT(Balance ,' €') AS 'Debts', CustomerId, City
FROM tblcustomers
ORDER BY Balance DESC;
-- ➝ Toont schulden van klanten (met € erbij), gesorteerd van hoog naar laag.

#Exercise24
SELECT CONCAT(LastName, ' ', FirstName) AS 'Name', BirthDate
FROM tblemployees
ORDER BY BirthDate ASC;
-- ➝ Volledige naam + geboortedatum, gesorteerd van oudste naar jongste.

#Exercise25
SELECT LastName, FirstName, City, Employed
FROM tblemployees
WHERE Employed BETWEEN "1993-01-01" AND "1993-12-12"
ORDER BY Employed DESC;
-- ➝ Werknemers die in 1993 in dienst kwamen.

#Exercise26
SELECT Name, City
FROM tblcustomers
WHERE City = "Leuven"
ORDER BY Name ASC;
-- ➝ Alle klanten uit Leuven.

#Exercise27
SELECT LastName, FirstName, City, Gender
FROM tblemployees
WHERE City = "Leuven";
-- ➝ Werknemers die in Leuven wonen.

#Exercise28
SELECT LastName, FirstName, City, Gender
FROM tblemployees
WHERE City NOT IN ("Leuven","Kessel-lo","Herent") AND Gender = 1;
-- ➝ Mannen (Gender=1) die NIET in Leuven, Kessel-Lo of Herent wonen.

#Exercise29
SELECT CustomerID, Name, Balance
FROM tblcustomers
WHERE Balance > 175
ORDER BY Name ASC;
-- ➝ Klanten met saldo > 175, gesorteerd op naam.

#Exercise30
SELECT CustomerID, Name
FROM tblcustomers
WHERE Name REGEXP '^Van'
ORDER BY Name ASC;
-- ➝ Klanten waarvan de naam begint met "Van".

#Exercise31
SELECT UPPER(LastName) AS LastName,
       UPPER(City) AS City,
       JobTitle
FROM tblemployees
WHERE City NOT IN ("Leuven","Herent","Peer","Genk")
  AND Jobtitle = 'Representative';
-- ➝ Representatives buiten Leuven, Herent, Peer en Genk.
--   Namen en steden worden in hoofdletters weergegeven.

#Exercise32
SELECT ProductName, Stock, OnOrder, Shop,
       (Shop - (Stock - OnOrder)) AS Shortage
FROM tblproducts
WHERE (Stock - OnOrder) < Shop
ORDER BY Shortage DESC;
-- ➝ Berekent tekorten in voorraad. 
--   Shortage = benodigde voorraad - beschikbare voorraad.

#Exercise33
SELECT CONCAT(Company, ' from ', Country) AS 'Company And Country'
FROM tblsuppliers
WHERE Country NOT IN ('Spain','United Kingdom')
LIMIT 5;
-- ➝ Toont leveranciers met land, behalve Spanje en VK. Beperkt tot 5 rijen.

#Exercise34
SELECT DISTINCT Country
FROM tblsuppliers
ORDER BY Country ASC;
-- ➝ Geeft unieke landen van leveranciers, alfabetisch.

#Exercise35
SELECT SUM(balance) AS Balance,
       COUNT(RegistrationNumber) AS NumberOfCustomers
FROM tblcustomers
WHERE RegistrationNumber IS NOT NULL;
-- ➝ Totale balans en aantal klanten met registratienummer.

#Exercise36
SELECT CustomerNumber, OrderDate
FROM tblorders
WHERE OrderDate >= '2006-08-06' AND OrderDate < '2006-08-07';
-- ➝ Orders geplaatst op exact 6 augustus 2006.

#Exercise37
SELECT AVG(PricePerUnit * 1.10) AS Increase
FROM tblproducts;
-- ➝ Berekent gemiddelde prijs per product als alle prijzen met 10% stijgen.

#Exercise38
SELECT COUNT(*) AS NumberOfRepresentatives
FROM tblemployees
WHERE JobTitle = 'Representative'
  AND Employed <= '1993-01-01';
-- ➝ Telt alle vertegenwoordigers die al vóór 1993 in dienst waren.

#Exercise39
SELECT City, YEAR(MAX(BirthDate)) - YEAR(MIN(BirthDate))
FROM tblemployees
WHERE City = "Leuven";
-- ➝ Verschil in geboortejaar tussen jongste en oudste werknemer in Leuven.

#Exercise40
SELECT YEAR(OrderDate) AS OrderYear,
       COUNT(OrderID) AS NumberOfOrders
FROM tblorders
WHERE YEAR(OrderDate) = 2005
GROUP BY YEAR(OrderDate);
-- ➝ Telt alle orders per jaar, maar gefilterd enkel op jaar 2005.










 

  
