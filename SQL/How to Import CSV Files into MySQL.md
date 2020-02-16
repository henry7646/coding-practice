# Caveat:
This instruction assumes that  
- The csv file that you would like to import into MySQL is already saved in your computer.
- The table you would like to import the csv file into is already saved in your MySQL (In order to import the csv file into MySQL, you must have the table to map the csv file with in MySQL).
- You are using MySQL Workbench to edit and execute SQL codes (If you do not have MySQL Workbench App in your computer, you can download it here (I highly recommend that you download it right after downloading MySQL, since it is much better to edit the SQL codes with the GUI like MySQL Workbench than to edit them with the command window): https://www.mysql.com/products/workbench/)  
  
----
# 1. LOAD DATA in the MySQL Client window  
https://www.mysqltutorial.org/import-csv-file-mysql-table/  
  
Strangely enough, **executing the SQL code below keeps on spitting out the error** (*Error Code: 1148. The used command is not allowed with this MySQL version*), at least for **MySQL Workbench 8.0.18**. There are multiple solutions offered online for this problem (https://stackoverflow.com/questions/10762239/mysql-enable-load-data-local-infile), but **none of them seem to work universally ever since the problem has been raised for MySQL Workbench 8.0.12** (https://bugs.mysql.com/bug.php?id=91891). Hence, I **highly recommend that you use Table Data Import Wizard**, which I will introduce to you soon.  
  
**Revision (2020-02-17 04:45:52 KST)**: After (1) running the code *SET GLOBAL local_infile=1;* in MySQL Workbench, (2) visiting [Navigator] > [Administration] > Wrench icon next to [INSTANCE] > [MySQL Connections] > Connection in which the table to import the csv file is > [Connection] > [Advanced], and (3) typing *OPT_LOCAL_INFILE=1* into [Others], type the code below into the MySQL Client window and then execute:  
  
LOAD DATA LOCAL  
INFILE '[csv file's directory]'  
INTO TABLE '[table name]'  
FIELDS TERMINATED BY ','  
IGNORE 1 ROWS  
([table column 1],[table column 2],....);  
  
**CAVEAT**: *IGNORE 1 ROWS* is necessary when the first row of the csv file is the header.  
  
----
# 2. Using Table Data Import Wizard in the MySQL Workbench Navigator
https://youtu.be/vzYFZXI43hM  
  
(1) From the Navigator, right-click the table into which you are going to import the csv file.  
(2) Select [Table Data Import Wizard] Menu.  
(3) Click [Browse] and select the csv file to import into MySQL.  
(4) Click [Next].  
(5) (Optional) Select [Truncate table before import] Menu **if you want to eliminate all the data in the table before importing the csv file into it**.  
(6) Click [Next].  
(7) Select [Source Column]s to import from the csv file, and then match them with [Dest Column]s of the table to import the csv file into.  
(8) Click [Next].  
(9) Click [Next].  
(10) Click [Finish].
