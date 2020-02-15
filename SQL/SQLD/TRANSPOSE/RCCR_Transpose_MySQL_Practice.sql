/*In case of ORACLE DB and SQL SERVER, it is easy to pivot, unpivot, and transpose the given
table with the built-in functions (PIVOT, UNPIVOT). However, MySQL doesn't have the corresponding
functions for pivoting and unpivoting the given table. In this code, we will practice pivoting,
unpivoting, and transposing the table in MySQL and compare the method with that of ORACLE DB
and SQL SERVER. The reference is the following link: http://archive.oreilly.com/oreillyschool/courses/dba1/dba110.html*/

/*First, let us create the sample to practice pivoting and unpivoting with*/ 
CREATE TABLE salesanalysis (
region varchar(5),
quarter date,
units_sold int(5));

INSERT INTO salesanalysis(region, quarter, units_sold)
VALUES ('North', '2007-03-31', 15089);
INSERT INTO salesanalysis(region, quarter, units_sold)
VALUES ('North', '2007-06-30', 18795);
INSERT INTO salesanalysis(region, quarter, units_sold)
VALUES ('North', '2007-09-30', 19065);
INSERT INTO salesanalysis(region, quarter, units_sold)
VALUES ('North', '2007-12-31', 19987);
INSERT INTO salesanalysis(region, quarter, units_sold)
VALUES ('South', '2007-03-31', 20015);
INSERT INTO salesanalysis(region, quarter, units_sold)
VALUES ('South', '2007-06-30', 19806);
INSERT INTO salesanalysis(region, quarter, units_sold)
VALUES ('South', '2007-09-30', 21053);
INSERT INTO salesanalysis(region, quarter, units_sold)
VALUES ('South', '2007-12-31', 23068); 

SELECT * FROM salesanalysis;
-- ------------------------------------------------------------------------
/*1. Pivoting table: Let us pivot sqld.salesanalysis.units_sold by quarter.
For ORACLE DB and SQL SERVER, which already have PIVOT & UNPIVOT functions, you can
pivot units_sold by quarter as follows:
SELECT * FROM salesanalysis
PIVOT
(SUM(units_sold) FOR quarter IN ('2007-03-31' units_sold_2007_Q1, '2007-06-30' units_sold_2007_Q2, '2007-09-30' units_sold_2007_Q3, '2007-12-31' units_sold_2007_Q4))
ORDER BY region;
*/

/*Now, let us do the same with MySQL. First, generate the column which gives back units_sold of the region if the quarter is the given quarter (ex: 2007-Q1)
and 0 if not. Of course, CASE variable is the best way to make such columns. Then, sum up each column by region using SUM function*/
CREATE TABLE salesanalysisbyquarter AS
SELECT region,
SUM(CASE WHEN quarter='2007-03-31' THEN units_sold ELSE 0 END) AS '2007-Q1', -- In case of MySQL, you need to put quotation marks around the alias that starts with number or contains special character (-)
SUM(CASE WHEN quarter='2007-06-30' THEN units_sold ELSE 0 END) AS '2007-Q2',
SUM(CASE WHEN quarter='2007-09-30' THEN units_sold ELSE 0 END) AS '2007-Q3',
SUM(CASE WHEN quarter='2007-12-31' THEN units_sold ELSE 0 END) AS '2007-Q4'
FROM salesanalysis
GROUP BY region;

SELECT * FROM salesanalysisbyquarter;
-- ------------------------------------------------------------------------
/*2. Unpivoting table: Let us unpivot salesanalysisbyquarter back to salesanalysis by quarter.
For ORACLE DB and SQL SERVER, which already have PIVOT & UNPIVOT functions, you can
unpivot units_sold by quarter as follows:
SELECT * FROM salesanalysisbyquarter
UNPIVOT
(units_sold FOR quarter IN (units_sold_2007-Q1 '2007-03-31', units_sold_2007_Q2 '2007-06-30', units_sold_2007_Q3 '2007-09-30', units_sold_2007_Q4 '2007-12-31'));
*/
/*Now, let us do the same with MySQL.
Step 1: Create separate tables (unpivoted), each with different quarters (2007-Q1 ~ 2007-Q4). Of course, all of them must contain
the common column by which you are going to unpivot the table (quarter)
Step 2: Join all those tables with UNION*/
SELECT region,
'2007-03-31' AS quarter,
`2007-Q1` AS units_sold -- When selecting the column starting with number or containing special characters (ex:-), you must surround it with back apostrophes(`)
FROM salesanalysisbyquarter
UNION
SELECT region,
'2007-06-30' AS quarter,
`2007-Q2` AS units_sold -- When selecting the column starting with number or containing special characters (ex:-), you must surround it with back apostrophes(`)
FROM salesanalysisbyquarter
UNION
SELECT region,
'2007-09-30' AS quarter,
`2007-Q3` AS units_sold -- When selecting the column starting with number or containing special characters (ex:-), you must surround it with back apostrophes(`)
FROM salesanalysisbyquarter
UNION
SELECT region,
'2007-12-31' AS quarter,
`2007-Q4` AS units_sold -- When selecting the column starting with number or containing special characters (ex:-), you must surround it with back apostrophes(`)
FROM salesanalysisbyquarter;
-- ------------------------------------------------------------------------
/*3. Transposing table: Transposing salesanalysis does not make sense, since each column of the transpose of sales analysis contains
data of different types. Therefore, we will bring olympic_medal_sport from ORACLE DB for the corresponding practice for transpose.
First, export olympic_medal_sport as csv file. Then, import olympic_medal_sport.csv into MySQL according to the followuing tutorial:
https://youtu.be/vzYFZXI43hM?t=235 */
CREATE TABLE olympic_medal_sport (
noc varchar(3),
ath int,
gym int,
cyc int,
box int,
sai int);

SELECT * FROM olympic_medal_sport;

/*Step 1: Unpivot the table by ath, gym, cyc, box, and sai*/
CREATE VIEW olympic_medal_sport_unpivot AS
SELECT noc,
'ath' AS sport,
ath AS medal
FROM olympic_medal_sport
UNION
SELECT noc,
'gym' AS sport,
gym AS medal
FROM olympic_medal_sport
UNION
SELECT noc,
'cyc' AS sport,
cyc AS medal
FROM olympic_medal_sport
UNION
SELECT noc,
'box' AS sport,
box AS medal
FROM olympic_medal_sport
UNION
SELECT noc,
'sai' AS sport,
sai AS medal
FROM olympic_medal_sport;

/*Step 2: Pivot the result by noc*/
SELECT sport,
SUM(CASE WHEN noc='BRA' THEN medal ELSE 0 END) AS bra,
SUM(CASE WHEN noc='CHN' THEN medal ELSE 0 END) AS chn,
SUM(CASE WHEN noc='DEN' THEN medal ELSE 0 END) AS den,
SUM(CASE WHEN noc='ESP' THEN medal ELSE 0 END) AS esp,
SUM(CASE WHEN noc='ETH' THEN medal ELSE 0 END) AS eth,
SUM(CASE WHEN noc='GRE' THEN medal ELSE 0 END) AS gre
FROM olympic_medal_sport_unpivot
GROUP BY sport;