select orderid,employeeid 
from tblorders;

# ex 2:
select productnumber, productname, priceperunit,
concat(stock,' pieces') as 'Stock',
concat(priceperunit * stock) as 'Stock value'
from tblproducts;




# ex 3
select customerid, name, type
from tblcustomers
where city = 'Tienen';



