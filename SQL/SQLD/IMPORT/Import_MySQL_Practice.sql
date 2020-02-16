CREATE TABLE deliveryinfo (
deliveryid int,
customerid int,
deliverydate datetime,
deliverycost int);

SELECT * FROM deliveryinfo;

LOAD DATA LOCAL
INFILE 'C:\Users\Seung Jae Han\Dropbox\Statistics\SQL\Practice\SQLD\주문번호.csv'
INTO TABLE deliveryinfo
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(deliveryid, customerid, deliverydate, deliverycost);