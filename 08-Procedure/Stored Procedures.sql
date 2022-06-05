/*Retrieving data using stored procedures*/

--Creating the procedure
CREATE PROCEDURE [dbo].[GetProducts] AS SELECT ProductID, ProductName FROM Products

--sample query with parameters
Create PROCEDURE [dbo].[GetProducts](@strCode varchar(50))
ASSELECT*FROM CMN_ACTV where ACTV_CODE > @strCode;

/*
Procedure for reading data from dynamic table
This feature allows you to:
•	Dynamically create your SQL statement
•	Dynamically create your filter criteria
•	Dynamically create your Order criteria
•	Automate Grouping Information*/

createPROCEDURE [dbo].[GetProducts](@strTable varchar(30), @strCode int)
AS 

DECLARE @strSQL nvarchar(500);
DECLARE @ParmDefinition nvarchar(500);
set @strSQL = 'SELECT * FROM ' + @strTable + ' where identitycol > @strCode';
SET @ParmDefinition =N'@strCode int';
EXECUTE sp_executesql@strSQL, @ParmDefinition,
                      @strCode = @strCode;

--Passing datatable to procedure
--in SQL Server
CREATETYPE LocationTableType ASTABLE
( LocationName VARCHAR(50)
, CostRate INT);
//this type will be stored under the database->Programatically->Types->User defined table types
CREATEPROCEDURE dbo. usp_InsertProductionLocation
    @TVP LocationTableType READONLY
AS
    SET NOCOUNT ON
INSERTINTO AdventureWorks2012.Production.Location
(Name
,CostRate
,Availability
,ModifiedDate)
SELECT*, 0,GETDATE()
FROM  @TVP;
GO


/* Declare a variable that references the type. */
DECLARE @LocationTVP AS LocationTableType;

/* Add data to the table variable. */
INSERT INTO @LocationTVP (LocationName, CostRate)
    SELECT Name, 0.00
    FROM AdventureWorks2012.Person.StateProvince;

/* Pass the table variable data to a stored procedure. */
EXEC usp_InsertProductionLocation @LocationTVP;
GO




 
