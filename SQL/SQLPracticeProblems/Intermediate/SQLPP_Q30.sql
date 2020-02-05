SELECT a.customerid,b.orderid
FROM customers AS a LEFT OUTER JOIN orders AS b
ON a.customerid = b.customerid
WHERE b.orderid IS NULL;