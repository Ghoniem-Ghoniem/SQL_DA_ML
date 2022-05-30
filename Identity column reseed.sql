--Handling identity columns
--Getting the current identity 

select ident_current("DEPART") 

--Setting identity to specific value
DBCC CHECKIDENT('DEPART',RESEED,0)


--Getting last inserted ID in identity column
create table Test(Code int identity,empname varchar(10))
insert into Test(empname)values ('Ahmed')
delete from Test 

SELECT SCOPE_IDENTITY()AS [SCOPE_IDENTITY];--return the last inserted id


