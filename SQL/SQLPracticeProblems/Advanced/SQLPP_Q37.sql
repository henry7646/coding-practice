SELECT TOP(2) PERCENT orderid
FROM orders
ORDER BY NEWID();