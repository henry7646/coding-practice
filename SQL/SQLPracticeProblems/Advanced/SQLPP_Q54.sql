WITH suppliernation AS
(SELECT country, totalsuppliers = count(*)
FROM suppliers
GROUP BY country),

customernation AS
(SELECT country, totalcustomers = count(*)
FROM customers
GROUP BY country)

SELECT country = ISNULL(suppliernation.country,customernation.country), totalsuppliers = ISNULL(suppliernation.totalsuppliers,0), totalcustomers = ISNULL(customernation.totalcustomers,0)
FROM suppliernation FULL OUTER JOIN customernation
ON suppliernation.country = customernation.country;

/*If you are going to include the joining key column without null values for FULL OUTER JOIN between tables A and B,
you must select the below:
ISNULL(A.joiningkeycolumn, B.joiningkeycolumn)
or
ISNULL(B.joiningkeycolumn, A.joiningkeycolumn)*/