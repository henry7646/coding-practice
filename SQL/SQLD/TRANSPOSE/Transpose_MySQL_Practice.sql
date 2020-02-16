-- Transpose the given table with MySQL
-- Step 1: Import the csv file as table into MySQL by right-clicking the corresponding table from Navigator and using Table Data Import Wizard.
CREATE TABLE sales (
salesagent varchar(5),
india int,
us int,
uk int);

SELECT * FROM sales;

-- Step 2: Unpivot the table by columns.
CREATE VIEW salesunpivot AS
SELECT salesagent,
'india' AS country,
india AS salesamount
FROM sales
UNION
SELECT salesagent,
'us' AS country,
us AS salesamount
FROM sales
UNION
SELECT salesagent,
'uK' AS country,
uk AS salesamount
FROM sales;

-- Step 3. Pivot the table by the first row. 
SELECT country,
SUM(CASE WHEN salesagent='David' THEN salesamount ELSE 0 END) AS david,
SUM(CASE WHEN salesagent='John' THEN salesamount ELSE 0 END) AS john
FROM salesunpivot
GROUP BY country;