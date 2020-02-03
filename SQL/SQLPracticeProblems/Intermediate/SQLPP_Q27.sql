/*ANS: orderid = '10806' is missing from the code with WHERE orderdate BETWEEN '2015-01-01' AND '2015-12-31'*/
SELECT TOP 3 shipcountry, averagefreight = AVG(freight)
FROM orders
WHERE orderdate BETWEEN '2015-01-01' AND '2015-12-31'
GROUP BY shipcountry
ORDER BY averagefreight DESC;

SELECT orderid,shipcountry,freight,orderdate
FROM orders
WHERE shipcountry IN ('Austria','Switzerland','France','Sweden') 
AND CONVERT(DATE,orderdate) BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY shipcountry,orderdate;

SELECT orderid,shipcountry,freight,orderdate
FROM orders
WHERE shipcountry IN ('Austria','Switzerland','France','Sweden') 
AND orderdate BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY shipcountry,orderdate;

