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

SELECT totalorders.employeeid, totalorders.lastname, totalorders.allorders,
ISNULL(delayedorders.lateorders,0) AS lateorders, CONVERT(float,ISNULL(delayedorders.lateorders,0))/totalorders.allorders AS percentlateorders 
FROM totalorders LEFT OUTER JOIN delayedorders
ON totalorders.employeeid = delayedorders.employeeid
ORDER BY totalorders.employeeid;

/*IN MSSQL, dividing integer by integer gives back the floor of the decimal result.
In order to get the decimal result itself, the change in the data type is necessary:
<ex> SELECT CONVERT(FLOAT,A)/B
FROM C;*/