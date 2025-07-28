SELECT ProductName,NederlandseNaam,PricePerUnit FROM tblProducts;
SELECT ProductName,NederlandseNaam,PricePerUnit,ProductNumber FROM tblProducts;
SELECT * FROM tblproducts;
SELECT ProductNumber,ProductName,PricePerUnit,PricePerUnit*1.33 from tblProducts;
SELECT ProductNumber,ProductName,PricePerUnit,concat(PricePerUnit * 1.33,"$") AS 'New price' from tblproducts;

SELECT name,Address,zipcode from tblcustomers WHERE city = 'Kortrijk';
SELECT name,note FROM  tblcustomers WHERE note is not null;
SELECT * from my_table ;  -- This is a comment
/* this is a multi-line comment */ SELECT * FROM my_table