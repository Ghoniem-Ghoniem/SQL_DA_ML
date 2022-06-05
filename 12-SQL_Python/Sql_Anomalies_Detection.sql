SELECT Emp.Name,DENSE_RANK() OVER (--PARTITION BY  dept 
ORDER BY salary DESC) rn FROM EMP



SELECT Emp.Name,ntile(100) OVER (--PARTITION BY  dept 
ORDER BY salary DESC) m FROM EMP

WITH cte_Min_Emp (emp, salary,State) AS (
select top .025 percent Name,Salary,'Low'  from Emp A order by salary desc),
cte_Min_Max (emp, salary,State) AS (
select top .025 percent Name,Salary,'High' from Emp B order by salary asc)
select * from cte_Min_Emp
union
select * from cte_Min_Max 
