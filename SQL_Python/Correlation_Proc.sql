use testdb
go

alter PROCEDURE EmployeeCorrelation
AS
BEGIN
declare @xFactor numeric(18,3)=0.00; --average
declare @yFactor numeric(18,3)=0.00; --average
declare @xyFactor numeric(18,3)=0; 
declare @x2Factor numeric(18,3)=0; 
declare @y2Factor numeric(18,3)=0; 
declare @nCorrelation numeric(18,3)=0; 
declare @nCount numeric(18,3)=0; 
declare @nRegressionb numeric(18,3)=0; 
declare @nRegressiona numeric(18,3)=0; 
set @nCount = (select count(1) from employees);
set @xFactor = (select sum(employees.salary) from employees)
set @yFactor = (select sum(SalaryWithTax) from employees)
set @xyFactor = (select sum(employees.salary*employees.SalaryWithTax) from employees)
set @x2Factor = (select sum(power(employees.salary,2)) from employees)
set @y2Factor = (select sum(power(employees.SalaryWithTax,2)) from employees)
set @nCorrelation = ( (@xyFactor-((@xFactor*@yFactor)/@nCount))/sqrt((@x2Factor-power(@xFactor,2)/@nCount)* (@y2Factor-power(@yFactor,2)/@nCount)));
select @nCorrelation as correlation

--calculting regression
set @nRegressionb = ( (@xyFactor-((@xFactor*@yFactor)/@nCount))/((@x2Factor-power(@xFactor,2)/@nCount)));
set @nRegressiona = @yFactor/@nCount - @nRegressionb* @xFactor/@nCount;

--forcasting value
select @nRegressiona+ @nRegressionb*12000 as 'Forcasting emp salary for 10000'

END
GO


EmployeeCorrelation
