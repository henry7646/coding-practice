# Caveat:
This instruction assumes that  
- The csv file that you would like to import into MySQL is already saved in your computer.
- The table you would like to import the csv file into is already saved in your MySQL (In order to import the csv file into MySQL, you must have the table to map the csv file with in MySQL).
- You are using MySQL Workbench to edit and execute SQL codes (If you do not have MySQL Workbench App in your computer, you can download it here (I highly recommend that you download it right after downloading MySQL, since it is much better to edit the SQL codes with the GUI like MySQL Workbench than to edit them with the command window): https://www.mysql.com/products/workbench/)  
  
----
# 1. Hard coding in the MySQL Workbench command pallette  
https://www.mysqltutorial.org/import-csv-file-mysql-table/  
  
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
