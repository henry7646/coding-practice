SELECT customerid, companyname, region,
eqnull = 
CASE WHEN region IS NULL THEN 1
ELSE 0
END
FROM customers
ORDER BY eqnull, region, customerid;

-- Need to get familiar with generating the case variables: https://docs.microsoft.com/en-us/sql/t-sql/language-elements/case-transact-sql?view=sql-server-2017#examples