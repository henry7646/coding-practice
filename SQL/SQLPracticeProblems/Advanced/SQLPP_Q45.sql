WITH totalorders AS
(SELECT orders.employeeid, employees.lastname, allorders = count(orders.orderid)
FROM orders LEFT OUTER JOIN employees
ON orders.employeeid = employees.employeeid
GROUP BY orders.employeeid, employees.lastname),

delayedorders AS
(SELECT a.employeeid, a.lastname, lateorders = count(b.orderid)
FROM employees AS a INNER JOIN orders AS b
ON a.employeeid = b.employeeid
WHERE b.shippeddate >= b.requireddate
GROUP BY a.employeeid, a.lastname)

SELECT totalorders.employeeid, totalorders.lastname, totalorders.allorders, ISNULL(delayedorders.lateorders,0) AS lateorders
FROM totalorders LEFT OUTER JOIN delayedorders
ON totalorders.employeeid = delayedorders.employeeid
ORDER BY totalorders.employeeid;

/*NVL function (Oracle DB) <-> ISNULL function (SQL Server)*/