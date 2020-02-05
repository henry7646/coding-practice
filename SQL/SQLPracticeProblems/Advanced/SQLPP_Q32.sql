SELECT customers.customerid, customers.companyname, orders.orderid, totalorderamount = SUM(orderdetails.unitprice * orderdetails.quantity)
FROM customers, orders, orderdetails
WHERE customers.customerid = orders.customerid
AND orders.orderid = orderdetails.orderid
AND YEAR(orders.orderdate) = 2016
GROUP BY customers.customerid, customers.companyname, orders.orderid
HAVING SUM(orderdetails.unitprice * orderdetails.quantity) >= 10000
ORDER BY totalorderamount DESC;

/*Very difficult: Must keep in mind that a single order can contain multiple items within: in other words, there can be multiple product ids for the single order id
(common sense - anyone can order multiple items at once*/
/*Except for the aggregated field, every single columns included in the SELECT statement must also be included in GROUP BY clause*/
/*WHERE clause comes before GROUP BY clause, followed by HAVING condition. ORDER BY always comes last in the whole SQL statement*/
/*Conditional statements involving aggregate fields cannot be included in WHERE clause: it must be included in HAVING condition*/