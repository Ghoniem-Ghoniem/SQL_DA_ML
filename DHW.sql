use DWHDB
go

alter procedure Merge_DWH
as 
--MERGE SQL statement - Part 2

--Synchronize the target table with refreshed data from source table
MERGE Emp AS TARGET
USING SampleDB..Emp AS SOURCE 
ON (TARGET.ID = SOURCE.ID) 
--When records are matched, update the records if there is any change
WHEN MATCHED 
THEN UPDATE SET TARGET.Name = SOURCE.Name, TARGET.Salary = SOURCE.Salary
--When no records are matched, insert the incoming records from source table to target table
WHEN NOT MATCHED BY TARGET 
THEN INSERT (ID, Name, Salary) VALUES (SOURCE.ID, SOURCE.Name, SOURCE.Salary)
--When there is a row that exists in target and same record does not exist in source then delete this record target
WHEN NOT MATCHED BY SOURCE 
THEN DELETE; 
----$action specifies a column of type nvarchar(10) in the OUTPUT clause that returns 
----one of three values for each row: 'INSERT', 'UPDATE', or 'DELETE' according to the action that was performed on that row
--OUTPUT $action, 
--DELETED.ProductID AS TargetProductID, 
--DELETED.ProductName AS TargetProductName, 
--DELETED.Rate AS TargetRate, 
--INSERTED.ProductID AS SourceProductID, 
--INSERTED.ProductName AS SourceProductName, 
--INSERTED.Rate AS SourceRate; 

--Reading from text file
	BULK INSERT dbo.empskills FROM 'd:\EmpSkills.txt' WITH ( ROWTERMINATOR ='\n' ,  CODEPAGE = '1252',CHECK_CONSTRAINTS)
	--Reading from xlsx file
	EXEC sp_configure 'show advanced option', '1';
	RECONFIGURE;
	EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
	RECONFIGURE;
	EXEC master.[sys].[sp_MSset_oledb_prop] N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
	RECONFIGURE;
	EXEC master.[sys].[sp_MSset_oledb_prop] N'Microsoft.ACE.OLEDB.15.0', N'AllowInProcess', 1
	RECONFIGURE;

	BULK INSERT Dictionary
	FROM 'd:\Dictionary.csv'
	 WITH
	(
		FIRSTROW = 2,
		codepage = 1256,
		FIELDTERMINATOR = ',',  --CSV field delimiter
		ROWTERMINATOR = '\n',   --Use to shift the control to next row
		TABLOCK
	)

	EXEC master.dbo.sp_MSset_oledb_prop 'Microsoft.ACE.OLEDB.12.0'


	SELECT A.* from (select * FROM OPENROWSET( 'Microsoft.ACE.OLEDB.12.0', 'Excel 8.0;Database=d:\Dictionary.xlsx', 'SELECT * FROM [Words$]')) A
	--where Word ='1'

select * from [NMG-PRG-L-00011\SQL2016].SAMPLEDB.dbo.EMP


SELECT @@ROWCOUNT;
GO

Merge_DWH
