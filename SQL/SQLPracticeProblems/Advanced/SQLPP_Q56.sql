SELECT initialorder.customerid, initialorderid = initialorder.orderid, initialorderdate = CONVERT(DATE,initialorder.orderdate), nextorderid = nextorder.orderid, nextorderdate = CONVERT(DATE,nextorder.orderdate), daysbetweenorders = DATEDIFF(DAY,initialorder.orderdate,nextorder.orderdate)
FROM orders initialorder JOIN orders nextorder
ON initialorder.customerid = nextorder.customerid
WHERE initialorder.orderid < nextorder.orderid
AND DATEDIFF(DAY,initialorder.orderdate,nextorder.orderdate) <= 5
ORDER BY customerid,initialorderid;

/*Joining a table to itself requires a lot of practice: repeat again and again and again*/