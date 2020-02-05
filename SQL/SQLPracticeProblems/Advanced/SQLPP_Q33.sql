SELECT customers.customerid, customers.companyname, totalorderamount = SUM(orderdetails.unitprice * orderdetails.quantity)
FROM customers, orders, orderdetails
WHERE customers.customerid = orders.customerid
AND orders.orderid = orderdetails.orderid
AND YEAR(orders.orderdate) = 2016
GROUP BY customers.customerid, customers.companyname
HAVING SUM(orderdetails.unitprice * orderdetails.quantity) >= 15000
ORDER BY totalorderamount DESC;

/*Notice that in this question, you are trying to figure out the total amount of order for each customer:
In the previous question (#32), you tried to figure out the total amount of order for each customer PER ORDER.
Obviously, the GROUP BY clause changes*/