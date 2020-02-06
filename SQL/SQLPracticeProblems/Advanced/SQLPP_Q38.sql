SELECT DISTINCT orderid FROM orderdetails
WHERE quantity >=60
GROUP BY orderid, quantity
HAVING COUNT(quantity) = 2;