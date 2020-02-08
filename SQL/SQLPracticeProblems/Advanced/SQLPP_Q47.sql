WITH totalorders AS
(SELECT orders.employeeid, employees.lastname, allorders = count(orders.orderid)
FROM orders LEFT OUTER JOIN employees
ON orders.employeeid = employees.employeeid
GROUP BY orders.employeeid, employees.lastname),

delayedorders AS
(SELECT a.employeeid, a.lastname, lateorders = count(b.orderid)
FROM employees AS a INNER JOIN orders AS b
ON a.employeeid = b.employeeid
WHERE b.shippeddate >= b.requireddate
GROUP BY a.employeeid, a.lastname),

totalanddelayedorders AS
(SELECT totalorders.employeeid, totalorders.lastname, totalorders.allorders,
ISNULL(delayedorders.lateorders,0) AS lateorders, CONVERT(float,ISNULL(delayedorders.lateorders,0))/totalorders.allorders AS percentlateorders
FROM totalorders LEFT OUTER JOIN delayedorders
ON totalorders.employeeid = delayedorders.employeeid)

SELECT employeeid, lastname,allorders, lateorders, CONVERT(decimal(2,2),percentlateorders) AS percentlateorders
FROM totalanddelayedorders
ORDER BY employeeid;

/*줄번호 표시하기
(1)도구->옵션->일반->표시->줄번호
(2)Ctrl+G*/
/*decimal/numeric (data type):
decimal/numeric(p,s)란 전체 숫자는 p, 소숫점 아래 s자리까지 있는 숫자를 의미한다*/
/*View/CTE 내에서는 ORDER BY가 불가능하다*/