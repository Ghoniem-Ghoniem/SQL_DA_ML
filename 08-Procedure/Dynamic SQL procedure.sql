--Dynamic SQL for procedure
SearchAllTables 'Computer'

USE MMS
GetProducts 'cmn_actv',820
select CMN_ACTV.ACTV_CODE aa from CMN_ACTV

create PROCEDURE [dbo].[GetProducts] (@strTable varchar(30), @strCode int)
AS 

DECLARE @strSQL nvarchar(500);
DECLARE @ParmDefinition nvarchar(500);
set @strSQL = 'SELECT * FROM ' + @strTable + ' where identitycol > @strCode';
SET @ParmDefinition = N'@strCode int';
EXECUTE sp_executesql @strSQL, @ParmDefinition,
                      @strCode = @strCode;
