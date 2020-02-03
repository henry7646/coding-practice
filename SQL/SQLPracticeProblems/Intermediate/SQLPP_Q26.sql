SELECT TOP 3 shipcountry, averagefreight = AVG(freight)
FROM orders
WHERE year(orderdate) = 2015
GROUP BY shipcountry
ORDER BY averagefreight DESC;