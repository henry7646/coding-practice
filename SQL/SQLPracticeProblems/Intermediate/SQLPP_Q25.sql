-- Various Types of JOIN
/*Reference: https://server-engineer.tistory.com/306 */
/*Equijoin: Combine two tables only where key values equal to each other*/
SELECT DISTINCT productid FROM products
ORDER BY productid;
SELECT DISTINCT productid FROM orderdetails
ORDER BY productid;

SELECT * FROM orderdetails a,products b
WHERE a.productid = b.productid;

/*Left outerjoin: Combine two tables even if key values aren't exactly equal to each other (keep variables null for rows whose key values are missing from the right side of the WHERE statement*/
SELECT * FROM orderdetails a LEFT OUTER JOIN products b
ON a.productid = b.productid;

/*Right outerjoin: Combine two tables even if key values aren't exactly equal to each other (keep variables null for rows whose key values are missing from the left side of the WHERE statement*/
SELECT * FROM orderdetails a RIGHT OUTER JOIN products b
ON a.productid = b.productid;

-- SQLPP Q25
/*SELECT TOP 3 * FROM [table]
ORDER BY [column2];
selects only rows from table containing top 3 values of column2*/
SELECT TOP 3 shipcountry,AVG(freight) AS averagefreight FROM orders
GROUP BY shipcountry
ORDER BY averagefreight DESC;
