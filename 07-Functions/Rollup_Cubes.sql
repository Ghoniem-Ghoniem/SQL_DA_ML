use TestDB
go
select Department,[role],sum(Salary) from Employees
group by  rollup (Department,[Role])

go
select Department,[role],sum(Salary) from Employees
group by  cube (Department,[Role])
