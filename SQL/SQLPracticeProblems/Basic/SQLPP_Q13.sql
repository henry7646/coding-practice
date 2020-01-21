SELECT orderid,productid,unitprice,quantity,
totalprice=unitprice*quantity
FROM orderdetails;