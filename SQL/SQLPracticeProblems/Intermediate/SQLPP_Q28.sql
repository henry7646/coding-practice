SELECT TOP 3 shipcountry, averagefreight = AVG(freight)
FROM orders
WHERE orderdate BETWEEN
(SELECT DATEADD(yyyy,-1,(SELECT MAX(orderdate) FROM orders)))
AND (SELECT MAX(orderdate) FROM orders)
GROUP BY shipcountry
ORDER BY averagefreight DESC;

/*Remember how to use DATEADD function*/
/*Do not simply put aggregate functions into WHERE clauses: always use subqueries inside WHERE clauses*/