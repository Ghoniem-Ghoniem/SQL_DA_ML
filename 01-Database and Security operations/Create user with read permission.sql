USE [MLDATABASE]
GO
CREATE LOGIN [UR] WITH PASSWORD ='12345678'
go
CREATE USER [USR_Read] FOR LOGIN [UR]
GO
USE [MLDATABASE]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_datareader] TO [USR_Read]
GO
USE [MLDATABASE]
GO
ALTER ROLE [db_datareader] ADD MEMBER [USR_Read]
GO

GRANT EXEC 
on [dbo] TO USR_Read;--because all read operation will be throw executing procedures

--LOGIN TO DATABASE WITH LOGIN USER = UR
--SELECTING DATA 
SELECT * FROM Groups
-- INSERTING DATA FAILED, AS USER IS NOT AUTHORIZED
INSERT INTO Groups VALUES ('Q11','AA','AA')
/* gives the following error
Msg 229, Level 14, State 5, Line 4
The INSERT permission was denied on the object 'Groups', database 'MLDATABASE', schema 'dbo'.

*/