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

SELECT @@ROWCOUNT;
GO
--to resync, just delete all records from the target table
