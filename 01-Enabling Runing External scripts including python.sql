/*
1-	Installing SQL server 2017
•	Enable R and Python when installing sqlserver
•	Start Launchpad service
•	Enable external scripts
•	Restart server and re-enable Launchpad service
•	Create first Python solution

*/
/*Enabling steps

*/
EXECUTE sp_configure;
GO
EXEC sp_configure 'clr enabled', 1
RECONFIGURE WITH OVERRIDE

EXEC sp_configure 'external scripts enabled', 1
GO
RECONFIGURE WITH OVERRIDE
GO
RECONFIGURE;
go
/*Restart the server
Run SQL Server launchpad (Microsoft SQL server)
*/
declare @RScript nvarchar(100)=
N'print(3+4)'  --return all the dataset

exec sys.sp_execute_external_script
@language = N'Python',   --the language
@script= @RScript


