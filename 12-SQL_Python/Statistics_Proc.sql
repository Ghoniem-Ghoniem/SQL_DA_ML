use testdb
go

alter PROCEDURE EmployeeStatistics
AS
BEGIN
declare @nMean decimal(10,2)=0.00; --average
declare @nCount decimal(10,2)=0.00; --average
declare @nGeometricMean decimal(10,2)=0; 
declare @nHarmonic decimal(10,2)=0; 
declare @nFirstQuarter decimal(10,2)=0; 
declare @nMedian decimal(10,2)=0; 
declare @nThirdQuarter decimal(10,2)=0; 

declare @nIQR decimal(10,2)=0; 
declare @nMinExtreme decimal(10,2)=0; 
declare @nMaxExtreme decimal(10,2)=0; 


declare @nBelowAverage decimal(10,2)=0; --average
declare @nAboveAverage decimal(10,2)=0; --average


declare @nMode decimal(10,2)=0;
declare @nMin decimal(10,2)=0;
declare @nMax decimal(10,2)=0;
declare @nStdDev decimal(10,2)=0;
declare @strRange varchar(50)
declare @nCV decimal(10,2)=0; 
declare @nLeastTenMax decimal(10,2)=0;
declare @nLeastTenMin decimal(10,2)=0; 
declare @nMinExteremsCount decimal(10,2)=0; 
declare @nMaxExteremsCount decimal(10,2)=0; 
declare @nVariance decimal(18,6)=0; 

set @nCount = (select count(1) from employees);
set @nMean = (select avg(employees.salary) from employees)
set @nMin = (select min(Salary) from employees)
set @nMax = (select MAX(Salary) from employees)
set @nStdDev = (select STDEV(Salary) from employees)
set @nVariance = (select var(Salary) from employees)

set @nAboveAverage = (select count(1) from employees where employees.salary >=@nMean)
set @nBelowAverage = (select count(1) from employees where employees.salary <@nMean)
set @nCV = @nStdDev/@nMean
set @strRange = str(@nMin)+ ' and ' + str(@nMax)


--getting IQR

set @nFirstQuarter = 
(SELECT MyDerivedTable.salary 
FROM (
    SELECT employees.salary, ROW_NUMBER() OVER (ORDER BY employees.salary) AS RowNum
    FROM employees
) AS MyDerivedTable
WHERE MyDerivedTable.RowNum =floor(@nCount/4))

set @nMedian = 
(SELECT MyDerivedTable.salary 
FROM (
    SELECT employees.salary, ROW_NUMBER() OVER (ORDER BY employees.salary) AS RowNum
    FROM employees
) AS MyDerivedTable
WHERE MyDerivedTable.RowNum =floor(@nCount/2))


set @nThirdQuarter = 
(SELECT MyDerivedTable.salary 
FROM (
    SELECT employees.salary, ROW_NUMBER() OVER (ORDER BY employees.salary) AS RowNum
    FROM employees
) AS MyDerivedTable
WHERE MyDerivedTable.RowNum =floor(@nCount*3/4))


----------

set @nLeastTenMax =(select min(RecordSet.Salary) 
from (
select top 3 employees.salary from employees order by employees.salary DESC) RecordSet
)

set @nLeastTenMin = (select Max(RecordSet.Salary) 
from (
select top 3 employees.salary from employees order by employees.salary) RecordSet
)

set @nHarmonic= (select count(1)/ sum(1/employees.salary) from Employees)
set @nGeometricMean = (select power(10,sum(log(Employees.salary,10))/COUNT(1)) from Employees)
set @nIQR = @nThirdQuarter-@nFirstQuarter
set @nMinExtreme = @nFirstQuarter - 1.5*@nIQR;
set @nMaxExtreme =  @nThirdQuarter + 1.5*@nIQR;
set @nMinExteremsCount = (select count(1) from Employees where Salary <@nMinExtreme)
set @nMaxExteremsCount = (select count(1) from Employees where Salary >@nMaxExtreme)


--Measures formatting
select '01-Average Salary' [Salary Metric],str(@nMean) [Metric value]
union
select '011-Geometric Mean',str(@nGeometricMean)
union
select '012-Harmonic Mean',str(@nHarmonic)
union
select '02-No. employees below average Salary',str(@nBelowAverage)
union
select '03-No. employees Above average Salary',str(@nAboveAverage)
union
select '04-Min Salary',str(@nMin)
union
select '05-Max Salary',str(@nMax)

union
select '06-Salary Ranges',@strRange

union
select '07-Salary Deviation',str(@nStdDev)

union
select '07-Salary Variance',str(@nVariance)

union
select '08-CV%',concat (str(@nCV*100,10,2),'%')

union
select '08-Variance between Min and Max',concat (str((@nMax/@nMin)*100,10,2),'%')


union
select '09-Top Three Max start from',concat (str(@nLeastTenMax,10,2),'')

union
select '10-Top Three Min End With',concat (str(@nLeastTenMin,10,2),'')


union
select '11-First Quarter value',concat (str(@nFirstQuarter,10,2),'')
union
select '12-Second Quarter Value',concat (str(@nMedian,10,2),'')
union
select '13-Third Quarter Value',concat (str(@nThirdQuarter,10,2),'')
union
select '14-IQR',concat (str(@nIQR,10,2),'')

union
select '15-Min Extreme Limit',concat (str(@nMinExtreme,10,2),'')
union
select '16-Max Extreme Limit',concat (str(@nMaxExtreme,10,2),'')

union
select '19-Min Extremes Count',concat (str(@nMinExteremsCount,10,2),'')
union
select '20-Max Extremes Count',concat (str(@nMaxExteremsCount,10,2),'')



END
GO


EmployeeStatistics