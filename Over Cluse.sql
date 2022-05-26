use TestDB
go;
select dense_rank() over (order by empname) as denserank,--rank with 1,2,3
rank() over (order by empname) as rank, --rank with 1,1,3
ROW_NUMBER() over (order by empname) as rownumber, --1,2,3,4,5,6
 ROW_NUMBER() over (partition by empname order by role ) as Partionedrownumber ,---1,2,3,1,2,1,2,3,4
  Employees.EmpName from Employees
  go;
-- deviding data by groups
--calculating number of groups per salaries
declare @columnValues varchar(1000);
set @columnValues=(SELECT distinct STUFF(
                 (SELECT distinct ',' + role FROM Employees FOR XML PATH ('')), 1, 1, ''
               ) abc
FROM Employees
); 

declare @nGroupsCount int = 1.3 + 3.3 * log((select count(1) from Employees),10); 
with cte (groupid,salary)
as
(
select ntile(@nGroupsCount) over (order by salary) as [Group],salary from employees)
select groupid,min(salary) as MinSal,max(salary) as MaxSal from cte
group by groupid;


select top 1 LAST_VALUE(salary) over (order by salary rows between unbounded preceding and unbounded following) as MaxSal from Employees;
select top 1 First_VALUE(salary) over (order by salary rows between unbounded preceding and unbounded following) as MaxSal from Employees;
