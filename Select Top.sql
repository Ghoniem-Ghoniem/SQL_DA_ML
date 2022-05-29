--Selecting data by top n or top %
select top 20 percent * from account
select top 20 * from account
declare @nCount int= 20
select top (@nCount)*from account

declare @nCount int= 10
select top (@nCount)percent * from account

