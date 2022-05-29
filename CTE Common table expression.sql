(CTE Queries) Building dependent queries

CTE= Common Table Expression

It’s a common table expression that create a temp result set to be used within the immediate next read,insert, delete and update
--Single CTE

with AssetAccounts(Code,Name1)as
(select Code,Name1 from account where AccountType ='A')

select*from AssetAccounts where Name1 >'ع';

--Multiple CTE
with AssetAccounts(Code,Name1)as
(select Code,Name1 from account where AccountType ='A'),
AssetAccounts2(Code,Name1)as
(select*from AssetAccounts where Name1 >'ع')
select*from AssetAccounts2 where code ='101030000'
