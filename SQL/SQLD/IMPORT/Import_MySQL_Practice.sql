TRUNCATE TABLE deliveryinfo;
DROP TABLE deliveryinfo;

/*Caveat: If the row of the csv file to import is outside the range of -2^31(-2147483648) to 2^31-1(2147483647),
then you need to set its data type as bigint, not int - 
https://docs.microsoft.com/en-us/sql/t-sql/data-types/int-bigint-smallint-and-tinyint-transact-sql?view=sql-server-ver15*/
CREATE TABLE deliveryinfo (
deliveryid bigint,
customerid int,
deliverydate datetime,
deliverycost int);

SELECT * FROM deliveryinfo;

-- Type this code into MySQL Client window and execute
LOAD DATA LOCAL
INFILE '~\주문번호.csv'
INTO TABLE deliveryinfo
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(deliveryid, customerid, deliverydate, deliverycost);
