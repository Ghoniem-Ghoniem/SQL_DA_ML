
--Preventing SQL Injection by using quotename function

declare @SQL nvarchar(100)
declare @TableName varchar(50)
--set @TableName ='Account'
set @TableName ='Account drop database test'
--set @SQL = 'select * from ' + @TableName 
set @SQL ='select * from '+quotename(@TableName)
print @SQL
execsp_executesql@SQL 

