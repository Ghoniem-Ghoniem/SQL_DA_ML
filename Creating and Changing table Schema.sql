--Creating and Changing table Schema
--create schema and set it to login
create schema MetaData 
go

ALTER SCHEMA MetaData TRANSFER dbo.words_metadata;
GO


--setting default scehma to user to use it directly from user
select * from words_metadata --failed
select * from dbo.words_metadata --failed
select * from MetaData.words_metadata --run successfully

