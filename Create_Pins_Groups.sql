SELECT Emp.Name,DENSE_RANK() OVER (--PARTITION BY  dept 
ORDER BY salary DESC) rn FROM EMP


SELECT *, 
       NTILE(4) OVER(
       ORDER BY salary DESC) Rank
FROM emp
ORDER BY rank;

Update emp set Salary = 1000 where Salary is null

drop function udfPins
CREATE FUNCTION udfPins(@Min int,@Max int,@Pins int)
    RETURNS @PinsGroups TABLE (
        first_name VARCHAR(50),MinVal int,MaxVal int)
AS
BEGIN
DECLARE @Sum INT = @Min;
DECLARE @Interval INT = (@Max-@Min)/@Pins;

	WHILE @Sum < @Max
		BEGIN
			INSERT INTO @PinsGroups
			SELECT 
				'>= '+CAST(@Sum as varchar(10)),@Sum,@Sum + @Interval
		   SET @Sum = @Sum + @Interval;
		END;
    RETURN;
END;

select * from dbo.udfPins(0,10000,10)
select * from dbo.udfPins(1000,10000,10)