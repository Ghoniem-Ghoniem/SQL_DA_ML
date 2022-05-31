--Synonym : It’s another name for your object in order to deal with.

drop SYNONYM MyAccounts

go 

CREATE SYNONYM MyAccounts for account

Go

select*from MyAccounts
go


use ecommercedb
go
--create it
create synonym Groups for mldatabase.dbo.groups
go
--use it in order to simplify and hide details of the main objects
select * from groups