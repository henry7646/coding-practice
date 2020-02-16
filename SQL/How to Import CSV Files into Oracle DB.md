# Caveat:
This instruction assumes that  
- The csv file that you would like to import into Oracle DB is already saved in your computer.
- The table you would like to import the csv file into is already saved in your Oracle DB (In order to import the csv file into Oracle DB, you must have the table to map the csv file with in the Oracle DB).  
  
----
# 1. Using SQL Loader
https://www.youtube.com/watch?v=vo9OUlWCnrY, https://www.youtube.com/watch?v=IZ6W_I6fBG4, https://www.youtube.com/watch?v=yxTly4GSZ9E  
## (1) Necessary files for operating SQL Loader
Remember that log file, bad file, and discard file are automatically generated when operationg SQL Loader: it is unnecessary to write them.  
1) control file (extension: .ctl) - interface between the data file and the Oracle DB table you are going to import the data file into  
Methods of data import that can be used in the control file - truncate, insert, append
2) log file (extension: .txt) - summary of the whole data loading process
3) bad file (extension: .bad) - records of the data that have been failed to be loaded
4) discard file (extension: .dsc) - records of the rejected data during the data loading process  
## (2) Code for the control file -
load data  
infile '[csv file's directory]'  
insert into table [table name]  
fields terminated by ","  
trailing nullcols  
([table column 1], [table column 2], ......)  
## (3) Data loading process -
1) Create the control file as shown in 1.-(2)  
2) Type and execute the following statement in the cmd window -  
sqlldr [Oracle DB username]/[Oracle DB password] control='[control file's directory]' bad='[bad file's directory]' discard='[discard file's directory]' log='[log file's directory]'  
  
----  
# 2. Using Oracle SQL Developer
https://docs.oracle.com/database/121/ADMQS/GUID-7068681A-DC4C-4E09-AC95-6A5590203818.htm#ADMQS0826  
  
If you do not have Oracle SQL Developer App in your computer, you can download it here (I highly recommend that you download it right after downloading Oracle DB, since it is much better to edit the SQL codes with the GUI like Oracle SQL Developer than to edit them with the command window): https://www.oracle.com/database/technologies/appdev/sql-developer.html  
  
(1) Create the table into which you are going to import the csv file of your interest  
(2) Right click the table of interest from [Connections] window (on the upper left corner)  
(3) Click [Import Data] menu  
(4) Browse and select the csv file of your interest, select [Header] (if the csv file doesn't have the header, then do NOT select), select None for [Left Enclosure] field and [Right Enclosure] field, and let [Line Terminator] field be environment default / standard  
(5) Click [Next] button  
(6) Select Insert for [Import Method] field, the table you are going to import the csv file into for [Table Name] field, and let the [Import Row Limit] be larger than the number of rows of the csv file you are going to import  
(7) Click [Next] button  
(8) In the [Source Data Columns] table on the left, select the column from the csv file, and then in the [Target Table Columns] table on the right, select in the [Name] field the name of the column in the database table that will store that csv file column  
(9) Click [Next] button  
(10) Click [Finish] button
