/*Reference: https://stackoverflow.com/questions/10195451/sql-inner-join-with-3-tables */
SELECT e.employeeid,e.lastname,o.orderid,p.productname,d.quantity
FROM employees AS e INNER JOIN orders AS o
ON e.employeeid = o.employeeid
INNER JOIN orderdetails AS d
ON o.orderid = d.orderid
INNER JOIN products AS p
ON d.productid = p.productid;

/*Remember how to inner join more than 2 tables: take particular attention on how to make aliases and write ON clauses*/