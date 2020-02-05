SELECT DISTINCT a.customerid, b.customerid
FROM customers AS a LEFT OUTER JOIN orders AS b
ON a.customerid = b.customerid
WHERE a.customerid NOT IN
(SELECT DISTINCT customerid
FROM orders
WHERE employeeid = 4);

/*Very Difficult: Must take time to figure out (1)which tables to join together
and (2) how to get rid of every customer who has ordered from employeeid = 4 AT LEAST ONCE*/