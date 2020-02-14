/*How to change the language setting for the SQL Developer - https://puttico.tistory.com/128 */
create table olympic_medal_winners (   
  olympic_year int,  
  sport        varchar2( 30 ),  
  gender       varchar2( 1 ),  
  event        varchar2( 128 ),  
  medal        varchar2( 10 ),  
  noc          varchar2( 3 ),  
  athlete      varchar2( 128 ) 
);

/*How to import an external csv file into Oracle DB as a table:
1) Manual - https://www.youtube.com/watch?v=vo9OUlWCnrY
https://www.youtube.com/watch?v=IZ6W_I6fBG4
https://www.youtube.com/watch?v=yxTly4GSZ9E
2) Simple (w/h Oracle SQL Developer) - https://docs.oracle.com/database/121/ADMQS/GUID-7068681A-DC4C-4E09-AC95-6A5590203818.htm#ADMQS0826*/
SELECT * FROM olympic_medal_winners;

-- -----------------------------------------------------------------------------
/*How to use PIVOT to change rows of interest to columns: https://blogs.oracle.com/sql/how-to-convert-rows-to-columns-and-back-again-with-sql-aka-pivot-and-unpivot*/
/*Objective: We would like to get the number of gold medals(Gold), silver medals(Silver), and bronze medals(Bronze) for each country.
The first column will be a list of countries, and the proceeding columns will each be numbers of gold, silver, and bronze medals.*/
/*Step 1: Generate the columns for the number of each type of medal*/
SELECT * FROM olympic_medal_winners
PIVOT (
COUNT(*) FOR medal IN ('Gold' gold, 'Silver' silver, 'Bronze' bronze)
)
ORDER BY noc;
/*Warning - when designating each value in the column of the original table as the
new column, remember that you must be case-sensitive*/

/*Step 2: Designate which columns you will show and categorize the number of medals by
(noc, medal) using the inline view, instead of allowing the implicit group by,
which shows the number of each type of column for each athelete*/
SELECT * FROM
(SELECT noc, medal FROM olympic_medal_winners)
PIVOT (COUNT(*) FOR medal IN ('Gold' gold, 'Silver' silver, 'Bronze' bronze))
ORDER BY 2 DESC, 3 DESC, 4 DESC;

/*Step 3: In case of sports like tennis and badminton, there are multiple rows for the
same event, since the medals are listed per athlete, not per event. To overcome
this problem, we need to count the number of each type of medal per event as follows*/
CREATE TABLE olympic_medal_table AS
SELECT * FROM
(SELECT noc, medal, sport, gender, event FROM olympic_medal_winners)
PIVOT (COUNT(DISTINCT sport||'#'||event||'#'||gender) FOR medal
IN ('Gold' gold, 'Silver' silver, 'Bronze' bronze))
ORDER BY 2 DESC, 3 DESC, 4 DESC;

-- -----------------------------------------------------------------------------
/*How to use UNPIVOT to change columns of interest to rows: https://blogs.oracle.com/sql/how-to-convert-rows-to-columns-and-back-again-with-sql-aka-pivot-and-unpivot*/
SELECT * FROM olympic_medal_table;

SELECT * FROM olympic_medal_table
UNPIVOT (medal_count FOR medal IN
(gold AS 'Gold', silver AS 'Silver', bronze AS 'Bronze'))
ORDER BY noc;

-- ----------------------------------------------------------------------------
/*How to make transpose of the given table with PIVOT & UNPIVOT: https://blogs.oracle.com/sql/how-to-convert-rows-to-columns-and-back-again-with-sql-aka-pivot-and-unpivot*/
/*Step 1: Create the table of interest*/
CREATE TABLE olympic_medal_sport AS
SELECT * FROM
(SELECT noc,sport FROM olympic_medal_winners)
PIVOT
(COUNT(*) FOR sport IN ('Athletics' ATH, 'Artistic Gymnastics' GYM, 'Cycling Track' CYC, 'Boxing' BOX, 'Sailing' SAI))
WHERE noc IN ('BRA', 'CHN', 'DEN', 'ESP', 'ETH', 'GRE')
ORDER BY noc;

/*Step 2: Unpivot the given table by column*/
SELECT * FROM olympic_medal_sport;
SELECT * FROM olympic_medal_sport
UNPIVOT
(medal FOR sport IN (ath, gym, cyc, box, sai))

/*Step 3: Pivot the given table by row*/
PIVOT
(SUM(medal) FOR noc IN ('BRA' bra, 'CHN' chn, 'DEN' den, 'ESP' esp, 'ETH' eth, 'GRE' gre));

/*Brief Self-Practice: https://youtu.be/OtSUxy206Gw (The clip itself is on
UNPIVOT: only the sample table in use is the same*/
/*Step 1: Create the sample table for the practice*/
CREATE TABLE sales(
salesagent varchar2(5),
india number(10),
us number(10),
uk number(10));

INSERT INTO sales (salesagent, india, us, uk)
VALUES ('David', 960, 520, 360);
INSERT INTO sales (salesagent, india, us, uk)
VALUES ('John', 970, 540, 800);

SELECT * FROM sales;

/*Step 2: Unpivot the sample table by column*/
SELECT * FROM sales
UNPIVOT (amount FOR country IN (india AS 'India', us AS 'US', uk AS 'UK'))

/*Step 3: Pivot the result by row (of the original sample table)*/
PIVOT (SUM(amount) FOR salesagent IN ('David' David, 'John' John));
