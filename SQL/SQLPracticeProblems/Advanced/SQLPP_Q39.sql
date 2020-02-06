SELECT * FROM orderdetails
WHERE orderid IN
(SELECT DISTINCT orderid FROM orderdetails
WHERE quantity >=60
GROUP BY orderid, quantity
HAVING COUNT(quantity) = 2);

/*Instead of plugging the subquery, you can use the technique called CTE (Common Table Expression): it works for MySQL and Oracle, too*/
WITH possiblywrongorders AS
(SELECT DISTINCT orderid FROM orderdetails
WHERE quantity >=60
GROUP BY orderid, quantity
HAVING COUNT(quantity) = 2)

SELECT * FROM orderdetails
WHERE orderid IN (SELECT * FROM possiblywrongorders);