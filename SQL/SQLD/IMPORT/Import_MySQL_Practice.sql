TRUNCATE TABLE deliveryinfo;
DROP TABLE deliveryinfo;

CREATE TABLE deliveryinfo (
deliveryid int,
customerid int,
deliverydate datetime,
deliverycost int);

SELECT * FROM deliveryinfo;

-- Type this code into MySQL Client window and execute
LOAD DATA LOCAL
INFILE 'C:\Users\Seung Jae Han\Dropbox\Statistics\SQL\Practice\SQLD\주문번호.csv'
INTO TABLE deliveryinfo
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(deliveryid, customerid, deliverydate, deliverycost);

  
/*Strangely enough, executing the SQL code above keeps on spitting out the error (Error Code: 1148. The used command is not allowed with 
this MySQL version), at least for MySQL Workbench 8.0.18. There are multiple solutions offered online for this problem 
(https://stackoverflow.com/questions/10762239/mysql-enable-load-data-local-infile), but none of them seem to work universally ever since 
the problem has been raised for MySQL Workbench 8.0.12 (https://bugs.mysql.com/bug.php?id=91891). Hence, I highly recommend that you use 
Table Data Import Wizard, which is intrduced in github.com/henry7646/coding-practice/SQL/SQLD/IMPORT/How to Import CSV File into MySQL.md*/  
    
