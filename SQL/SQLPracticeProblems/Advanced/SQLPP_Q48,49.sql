SELECT customers.customerid, customers.companyname, totalorderamount = SUM(orderdetails.unitprice * orderdetails.quantity),
customergroup =
CASE WHEN SUM(orderdetails.unitprice * orderdetails.quantity) BETWEEN 0 AND 1000
THEN'Low'
WHEN SUM(orderdetails.unitprice * orderdetails.quantity) > 1000 AND SUM(orderdetails.unitprice * orderdetails.quantity) <= 5000
THEN 'Medium'
WHEN SUM(orderdetails.unitprice * orderdetails.quantity) > 5000 AND SUM(orderdetails.unitprice * orderdetails.quantity) <= 10000
THEN 'High'
ELSE 'Very High'
END
FROM customers, orders, orderdetails
WHERE customers.customerid = orders.customerid
AND orders.orderid = orderdetails.orderid
AND YEAR(orders.orderdate) = 2016
GROUP BY customers.customerid, customers.companyname
ORDER BY customerid;

/*Alternative: Create the CTE, and then derive the categorical (case) variable from that CTE - this avoids the inefficient, repetitive calculations within the single case variable
in the above SELECT statement*/
WITH orders2016 AS
(SELECT customers.customerid, customers.companyname, totalorderamount = SUM(orderdetails.unitprice * orderdetails.quantity)
FROM customers, orders, orderdetails
WHERE customers.customerid = orders.customerid
AND orders.orderid = orderdetails.orderid
AND YEAR(orders.orderdate) = 2016
GROUP BY customers.customerid, customers.companyname)

SELECT customerid, companyname, totalorderamount, customergroup =
CASE WHEN totalorderamount BETWEEN 0 AND 1000
THEN'Low'
WHEN totalorderamount > 1000 AND totalorderamount <= 5000
THEN 'Medium'
WHEN totalorderamount > 5000 AND totalorderamount <= 10000
THEN 'High'
ELSE 'Very High'
END
FROM orders2016
ORDER BY customerid;

/*Go back to SQLPP_Q24 to review how to make case variables*/