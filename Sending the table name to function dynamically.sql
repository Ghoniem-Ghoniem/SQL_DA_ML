--Sending the table name to function dynamically
--01-you need to configure using the Ole automation
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO


CREATE FUNCTION [dbo].[GetSQLVal] (
@strFunction VARCHAR(100),
@str_TBName VARCHAR(100), 
@str_Criter VARCHAR(500),
@nMin int,	
@nMax int)
RETURNS BIGINT
AS	
BEGIN
DECLARE 
@int_objSQL INT,
@int_erros INT,
@int_objSelectResult INT,
@bint_SelectVal float,
@sql NVARCHAR(2000),
@property varchar(255)


EXEC @int_erros = sp_OACreate 'SQLDMO.SQLServer', @int_objSQL OUTPUT
EXEC @int_erros = sp_OASetProperty @int_objSQL, 'LoginSecure', TRUE
EXEC @int_erros = sp_OAMethod @int_objSQL, 'Connect', null, '.'
--if succeded then we are correctly login
if ( @str_TBName is not null and @str_TBName not in ('',' '))
	SET @sql = 'SELECT  distinct ' + @strFunction+' FROM ' + DB_NAME() + '.dbo.' + @str_TBName;
else
	SET @sql = 'SELECT  distinct '+DB_NAME() + '.dbo.'  + @strFunction;
if ( @str_Criter is not null and @str_Criter not in ('',' '))
 SET @sql = @sql  + ' where ' + @str_Criter 
SELECT @sql = 'ExecuteWithResults("' + @sql + '")'
EXEC @int_erros = sp_OAMethod @int_objSQL, @sql, @int_objSelectResult OUT
EXEC @int_erros = sp_OAMethod @int_objSelectResult, 'GetRangeString(1, 1)', @bint_SelectVal OUT
EXEC @int_erros = sp_OADestroy @int_objSQL
if (@int_erros <> 0)		SET @bint_SelectVal = @int_erros;
if (@bint_SelectVal<@nMin) 	set @bint_SelectVal = @nMin;
else
if (@bint_SelectVal>@nMax) 	set @bint_SelectVal = @nMax;
	
RETURN @bint_SelectVal
END

GO


select dbo.GetSQLVal('MAX','groups.GROUPID',NULL,10,30)