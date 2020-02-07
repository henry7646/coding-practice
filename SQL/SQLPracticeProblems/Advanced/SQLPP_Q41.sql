SELECT orderid, orderdate, requireddate, shippeddate
FROM orders
WHERE datediff(second,requireddate,shippeddate) >= 0
ORDER BY orderid;
/*Remember: If the shipped date is later than or EQUAL to the required date, the order is late - it is a common sense that the order
that has been shipped at the same time with the required date is alreday late.*/