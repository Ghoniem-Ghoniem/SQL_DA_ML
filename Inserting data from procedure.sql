--Reusing stored procedure output and complete on it
--It can be occurred by using the query output to create temp table for the output and separate each block in a separate function or procedure.

create procedure [dbo].[GetAllAccounts]
as
select AccountType,Code from account

createprocedure [dbo].[FilterAccountsProc]
as
begin
create table #FilterAccount(AccountType varchar(50),Code varchar(50))
insert into #FilterAccount 
execute GetAllAccounts;

select AccountType,count(1)from #FilterAccount groupby AccountType
end


FilterAccountsProc


