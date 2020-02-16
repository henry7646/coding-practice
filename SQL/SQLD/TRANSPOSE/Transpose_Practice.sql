SELECT * FROM sales;

SELECT * FROM sales
UNPIVOT(salesamount FOR country IN (india AS 'India', us  AS 'US', uk  AS 'UK'))
PIVOT(SUM(salesamount) FOR salesagent IN ('David' david, 'John' john));