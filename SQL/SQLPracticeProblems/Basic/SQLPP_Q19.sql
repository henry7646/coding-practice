SELECT orderid,convert(date,orderdate) AS orderdate,companyname
FROM orders,shippers
WHERE orders.shipvia=shippers.shipperid AND orders.orderid < 10270
ORDER BY orders.orderid;

-- Do not make trivial mistakes such as putting '&' in the place of 'AND'
-- Need to review how to conduct various types of joins (Equijoin, Left Outer join, Right Outer join, etc.) soon