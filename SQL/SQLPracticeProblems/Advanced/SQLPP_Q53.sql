WITH suppliernation AS
(SELECT DISTINCT country
FROM suppliers),

customernation AS
(SELECT DISTINCT country
FROM customers)

SELECT suppliernation.country AS suppliercountry, customernation.country AS customercountry
FROM suppliernation FULL OUTER JOIN customernation
ON suppliernation.country = customernation.country;