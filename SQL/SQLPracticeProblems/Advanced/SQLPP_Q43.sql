WITH totalorders AS
(SELECT employeeid, allorders = count(orderid)
FROM orders
GROUP BY employeeid)

SELECT a.employeeid, a.lastname, c.allorders, lateorders = count(b.orderid)
FROM employees AS a, orders AS b, totalorders AS c
WHERE a.employeeid = b.employeeid 
AND b.employeeid = c.employeeid
AND b.shippeddate >= b.requireddate
GROUP BY a.employeeid, a.lastname, c.allorders
ORDER BY employeeid;