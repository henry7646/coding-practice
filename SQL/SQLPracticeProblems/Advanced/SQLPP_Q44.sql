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

SELECT totalorders.employeeid, totalorders.lastname, totalorders.allorders, delayedorders.lateorders
FROM totalorders LEFT OUTER JOIN delayedorders
ON totalorders.employeeid = delayedorders.employeeid
ORDER BY totalorders.employeeid;

/*Must not try to make trivial, time-consuming mistakes with CTEs:
WITH (table name) AS (common table expression),
(table name 2) AS (common table expression 2),
......*/