SELECT orderid,convert(date,orderdate) AS orderdate,companyname
FROM orders,shippers
WHERE orders.shipvia=shippers.shipperid AND orders.orderid < 10270
ORDER BY orders.orderid;

-- Do not make trivial mistakes such as putting '&' in the place of 'AND'