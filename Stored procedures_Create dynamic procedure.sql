Create PROCEDURE [dbo].[TestDynamicSQL] @tableName varchar(50),@strCriteria varchar(50)
as
declare @strSQL nvarchar(2000);
set @strSQL = 'select count(1) from ' + @tableName + ' ' +  @strCriteria;

EXECUTE sp_executesql @strSQL;

execute TestDynamicSQL 'groups',''
