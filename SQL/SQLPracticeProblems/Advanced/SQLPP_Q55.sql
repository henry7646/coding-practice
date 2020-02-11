WITH minimumorderid AS
(SELECT shipcountry, orderid = min(orders.orderid)
FROM orders
GROUP BY shipcountry)

SELECT shipcountry, customerid, orderid, orderdate = CAST(orders.orderdate AS DATE)
FROM orders
WHERE shipcountry IN (SELECT shipcountry FROM minimumorderid) AND orderid IN (SELECT orderid FROM minimumorderid) 
ORDER BY shipcountry;

/*Another way to get the smallest orderid for each country is to use row_number(), which is one of the window functions:
it is particularly useful when the value you are trying to sort and select is NOT unique per row*/
/*ROW_NUMBER DEMO*/
SELECT ROW_NUMBER()
OVER (ORDER BY orderid)
FROM orders;

/*Solving the same question with ROW_NUMBER*/
WITH orderidrank AS
(SELECT shipcountry, customerid, orderid, orderdate = convert(date,orderdate), rankbycountry = ROW_NUMBER()
OVER (PARTITION BY shipcountry
ORDER BY shipcountry,orderid)
FROM orders)

SELECT shipcountry, customerid, orderid, orderdate
FROM orderidrank
WHERE orderidrank.rankbycountry = 1;

/*Basic structure of ROW_NUMBER function:
ROW_NUMBER()
OVER(PARTITION BY a
ORDER BY a,b)
FROM table_name*/