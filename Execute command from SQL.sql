Executing command on sql server (deleting files)
exec sp_configure 'show advanced options',1;
reconfigure 
exec sp_configure 'xp_cmdshell',1;
reconfigure 

Declare @cmd nvarchar(200);
Set @cmd  ='del /Q "E:\Db_Backs\*.*"' – means quite delete
Exec xp_cmdshell  @cmd  

 


