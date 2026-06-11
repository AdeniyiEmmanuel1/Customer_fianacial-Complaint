/*
=================================================================================================================
Create Database and Schemas
=================================================================================================================

Script Purpose:
	This Script creates a new database named 'Himalayan_DWH' after checking if it already existed on the database
	Additionally it also creates 3 layers, Bronze, Silver and Gold for the data structure

Warning: Running this script will drop the entire datawarehouse database if it exist
		All data in the database will be deleted permanently; so proceed with caution
*/

Use master;


---To check for the database if it already existed
--- To check for Database Method 1
/*IF EXISTS (
    SELECT name 
    FROM sys.databases 
    WHERE name = 'DataWarehouse'
)
BEGIN
    PRINT 'Database exists';
END
ELSE
BEGIN
    PRINT 'Database does not exist';
END*/

----mETHOD 2
IF EXISTS (
    SELECT 1 
    FROM sys.databases
    WHERE name = 'Himalayan_DWH')
 BEGIN
  PRINT 'Database exists';
END
ELSE
BEGIN 
    PRINT 'Database does not exist';
END;

---To create a Database
Create Database Himalayan_DWH;

---- To create a Data Structure
USE Himalayan_DWH;
GO
Create Schema Bronze;
GO
Create Schema Silver;
GO
Create Schema Gold;
GO;
