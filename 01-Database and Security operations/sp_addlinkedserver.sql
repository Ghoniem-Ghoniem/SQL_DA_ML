USE [master] 
GO 
EXEC master.dbo.sp_addlinkedserver 
@server = N'NMG-PRH-L-00011\SQL2016', 
@srvproduct=N'SQL Server' ; 
GO


sp_addlinkedserver [NMG-PRG-L-00011\SQL2016]

EXEC master.dbo.sp_addlinkedsrvlogin 
@rmtsrvname = N'NMG-PRG-L-00011\SQL2016', 
@rmtuser = 'sa', 
@rmtpassword  = N'abcd_28051' ; 
GO

select * from [NMG-PRG-L-00011\SQL2016].SAMPLEDB.dbo.EMP