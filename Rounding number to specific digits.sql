--Rounding number to specific digits
create FUNCTION [dbo].RoundNumber (@fNumber float,@nDecimalPlaces int)
RETURNS float
 with RETURNS NULL ON NULL INPUT AS
BEGIN
declare @nCount float;
--Get The number of decimal places here from the policy and send it instead of @nDecimalPlaces
set @nCount = round(@fNumber,@nDecimalPlaces);
RETURN(@nCount);
END

go

select dbo.RoundNumber(10.7,2)