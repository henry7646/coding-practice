SELECT orderid,customerid,shipcountry
FROM orders
WHERE shipcountry IN ('Brazil','Mexico','Argentina','Venezuela');