USE artemis;
SELECT LastName,FirstName, IF(Car=1, ' has a  company car','does  not have a  company car') AS 'Carstatus' from tblemployees ORDER BY LastName;
SELECT CustomerNumber,Deliverydate,ShippingCost, if(IsnUll(Deliverydate),'Not been delivered yet',Deliverydate) AS 'Delivery Status' , if(Isnull(ShippingCost),'Not been delivered yet',ShippingCost) AS 'ShippingcostStatus' from tblorders;



