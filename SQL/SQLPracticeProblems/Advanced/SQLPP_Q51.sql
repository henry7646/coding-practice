WITH orders2016 AS
(SELECT customers.customerid, customers.companyname, totalorderamount = SUM(orderdetails.unitprice * orderdetails.quantity)
FROM customers, orders, orderdetails
WHERE customers.customerid = orders.customerid
AND orders.orderid = orderdetails.orderid
AND YEAR(orders.orderdate) = 2016
GROUP BY customers.customerid, customers.companyname)

SELECT a.customerid, a.companyname, a.totalorderamount, b.customergroupname
FROM orders2016 a JOIN customergroupthresholds b
ON a.totalorderamount BETWEEN b.rangebottom AND b.rangetop
ORDER BY customerid;

/*Remember the line 'ON a.totalorderamount BETWEEN b.rangebottom AND b.rangetop': you can join two tables not only with the equation but also
with the BETWEEN clause*/