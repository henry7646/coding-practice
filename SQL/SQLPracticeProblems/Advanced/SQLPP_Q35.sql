SELECT employeeid, orderid, orderdate
FROM orders
WHERE orderdate = EOMONTH(orderdate)
ORDER BY employeeid, orderid;

/*EOMONTH(datetime variable): returns the datetime of the very end of each month*/
