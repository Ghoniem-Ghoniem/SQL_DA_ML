use testdb
go


alter procedure ObjectPivotStatistics @ObjName varchar(30),@RowValues varchar(100),@ColumnsValues varchar(100),@AggregateFunction varchar(20),@AggregateField varchar(20)
WITH ENCRYPTION --to encrypt the function body and keep privacy to work
as
begin
declare @columnValues varchar(1000);
declare @strSQL nvarchar(4000);

--EXECUTE sp_executesql @sqlCommand, N'@city nvarchar(75)', @city = @city

set @strSQL = '(SELECT distinct @columnValues = STUFF(
                 (SELECT distinct '','' + [RowValues] FROM [objename] FOR XML PATH ('''')), 1, 1, ''''
               ) 
FROM [objename]
);' 

set @strSQL = replace(@strSQL,'[objename]',@ObjName);
set @strSQL = replace(@strSQL,'[RowValues]',@RowValues);

EXECUTE sp_executesql @strSQL, N'@columnValues nvarchar(max) output', @columnValues output

SET @strSQL = '
select [ColumnsValues],'+@columnValues +' from 
(
select [ColumnsValues],[AggregateField],[RowValues] from -- 01-non pivoted required columns only, not all table columns
[objename] ) as sourstable
 pivot
(
[AggregateFunction] ([AggregateField]) --02-pivoted aggregate function 
for [RowValues] in ('+@columnValues+' ) --03-pivot column with expected unique values
)as UniqueRoles'

set @strSQL = replace(@strSQL,'[objename]',@ObjName);
set @strSQL = replace(@strSQL,'[RowValues]',@RowValues);
set @strSQL = replace(@strSQL,'[ColumnsValues]',@ColumnsValues);
set @strSQL = replace(@strSQL,'[AggregateFunction]',@AggregateFunction);
if (@AggregateField = @ColumnsValues)
	set @strSQL = replace(@strSQL,'[ColumnsValues],[AggregateField]',@AggregateField);
set @strSQL = replace(@strSQL,'[AggregateField]',@AggregateField);


print @strSQL 

execute sp_executesql @strSQL;
end


go
ObjectPivotStatistics 'employees','role','department','count','id'
go
ObjectPivotStatistics 'employees','role','department','sum','salary'


--select department,role,sum(salary) from Employees group by department,role

--select department,role,count(Department) from Employees group by department,role

--
--select department,JN,Manager,SM,SN,TL from 
--(
--select department,id,role from -- 01-non pivoted required columns only, not all table columns
--employees ) as sourstable
-- pivot
--(
--count (id) --02-pivoted aggregate function 
--for role in (JN,Manager,SM,SN,TL ) --03-pivot column with expected unique values
--)as UniqueRoles
--group by rollup (department, jn,Manager,SM,SN,tl)

