/*
=================================================================================================================
Create Database and Schemas
=================================================================================================================

Script Purpose:
	This Script creates a new database named 'Customer_Complaints' after checking if it already existed on the database
	Additionally it also creates 3 layers, Bronze, Silver and Gold for the data structure

Warning: Running this script will drop the entire datawarehouse database if it exist
		All data in the database will be deleted permanently; so proceed with caution
*/

/*To check for the database if it already existed*/
Use master;
GO

Create Database Customer_Complaints;

If Exists (Select 1 From sys.databases 
Where name = 'Customer_Complaints')
Begin
	Print 'Database Exist';
End
Else 
Begin
	Print'Databse does not exist';
End

--To Create a Data Structure
USE Customer_Complaints;
GO
CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO;

