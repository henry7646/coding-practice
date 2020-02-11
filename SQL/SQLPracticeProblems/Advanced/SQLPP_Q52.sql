SELECT DISTINCT country
FROM suppliers
UNION
SELECT DISTINCT country
FROM customers;

/*Remember that join is not the only way to combine two or more tables: review the UNION operator (SQL IN 10 MINUTES-SAMS TEACH YOURSELF, 137)*/