SELECT country
FROM customers
GROUP BY country;

-- Another Method (Not Using the GROUP BY Clause): Remember for the later convenience
SELECT DISTINCT country
FROM customers;

-- GROUP BY clause is necessary for operating the aggregate function from group to group later on.

-- HAVING clause, mostly paired with GROUP BY clause, is used to sort data based on the result obtained from aggregation. Meanwhile, WHERE clause
-- is used to sort data based on specific columns.

-- ORDER BY usually gets used together with the GROUP BY clause.
