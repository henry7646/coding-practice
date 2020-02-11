/*Window functions: https://www.sqlservertutorial.net/sql-server-window-functions/
LEAD function: https://www.sqlservertutorial.net/sql-server-window-functions/sql-server-lead-function/ */
WITH ord AS
(SELECT customerid, orderdate = CONVERT(DATE,orders.orderdate), nextorderdate =
CONVERT(DATE,LEAD(orderdate,1) OVER 
(PARTITION BY customerid
 ORDER BY orderdate))
 FROM orders)

SELECT customerid, orderdate, nextorderdate, daysbetweenorders = DATEDIFF(DAY,orderdate,nextorderdate)
FROM ord
WHERE DATEDIFF(DAY,orderdate,nextorderdate) BETWEEN 0 AND 5;