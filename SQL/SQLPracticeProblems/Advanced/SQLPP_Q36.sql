SELECT TOP 10 orderid, count(productid) AS totalorderdetails
FROM orderdetails
GROUP BY orderid
ORDER BY totalorderdetails DESC;