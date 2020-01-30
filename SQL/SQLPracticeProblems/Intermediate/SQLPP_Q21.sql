SELECT country, city, totalcustomers = COUNT(customerid)
FROM customers
GROUP BY country, city
ORDER BY country, city;