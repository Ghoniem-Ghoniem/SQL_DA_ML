Backup Database

create Procedure BackupDB @DBName varchar(20),@BackupFolder varchar(200)
as
begin
declare @BackupFileName varchar(300)= @BackupFolder +'\'+ @DBName +'_'+REPLACE(convert(varchar,GetDate(),120),':','_');

DBCC SHRINKDATABASE (@DBName,10);

--DBCC SHRINKfile @DBName+'_log';

BACKUP DATABASE @DBName 
TO DISK= @BackupFileName 
WITH FORMAT,
MEDIANAME='Z_SQLServerBackups',
      NAME ='Full Backup of DB';
end

USE [master]
ALTER DATABASE LO_Editor_Backup
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;

RESTORE DATABASE [LO_Editor_Backup] FROM  DISK = N'F:\TestDB_Full.bak' WITH  FILE = 1,  MOVE N'LO_Editor_Data' TO N'F:\LO_Editor_Backup.mdf',  MOVE N'LO_Editor_Log' TO N'F:\LO_Editor_Backup_1.ldf',  NOUNLOAD,  REPLACE,  STATS = 5

ALTER DATABASE [LO_Editor_Backup] SET MULTI_USER;
GO

USE [master]

Backup database LO_Editor to disk = 'F:\TestDB_Full.bak' with INIT—means overwrite
--with NOINIT means add different backups to the same file


ALTER DATABASE LO_Editor_Backup
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;

RESTORE DATABASE [LO_Editor_Backup] FROM  DISK = N'F:\TestDB_Full.bak' WITH  FILE = 1,  MOVE N'LO_Editor_Data' TO N'F:\LO_Editor_Backup.mdf',  MOVE N'LO_Editor_Log' TO N'F:\LO_Editor_Backup_1.ldf',  NOUNLOAD,  REPLACE,  STATS = 5

ALTER DATABASE [LO_Editor_Backup] SET MULTI_USER;
GO
--Creating procedure for backup database

exec BackupDB'HedeyaHOLive','D:\HedeyaHOLive_Backs'
Creat a job for it:
1-	Start SQL Agent server
2-	Expand SQL agent node
3-	Select Jobs
4-	Right click to add new job
5-	Add the steps
6-	Add the schedule


