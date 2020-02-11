WITH orders2016 AS
(SELECT customers.customerid, customers.companyname, totalorderamount = SUM(orderdetails.unitprice * orderdetails.quantity)
FROM customers, orders, orderdetails
WHERE customers.customerid = orders.customerid
AND orders.orderid = orderdetails.orderid
AND YEAR(orders.orderdate) = 2016
GROUP BY customers.customerid, customers.companyname),

ordersgroup AS
(SELECT customerid, companyname, totalorderamount, customergroup =
CASE WHEN totalorderamount BETWEEN 0 AND 1000
THEN'Low'
WHEN totalorderamount > 1000 AND totalorderamount <= 5000
THEN 'Medium'
WHEN totalorderamount > 5000 AND totalorderamount <= 10000
THEN 'High'
ELSE 'Very High'
END
FROM orders2016)

SELECT customergroup, totalingroup = count(*), percentageingroup = CONVERT(float,count(*))/(SELECT count(*) FROM ordersgroup)
FROM ordersgroup
GROUP BY customergroup
ORDER BY totalingroup DESC;

/*Keep a close eye on the phrase 'percentageingroup = CONVERT(float,count(*))/(SELECT count(*) FROM ordersgroup).'
count(*) in the numerator does not get influenced by the GROUP BY clause but counts the number of rows from ordersgroup.*/