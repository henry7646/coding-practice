SELECT a.employeeid, a.lastname, totallateorders = count(b.orderid)
FROM employees AS a INNER JOIN orders AS b
ON a.employeeid = b.employeeid
WHERE b.shippeddate >= b.requireddate
GROUP BY a.employeeid, a.lastname
ORDER BY totallateorders DESC;