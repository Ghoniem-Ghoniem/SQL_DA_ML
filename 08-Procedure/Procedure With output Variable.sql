create procedure spGetVal @inVal int,@OutVal int output
as
begin
set @OutVal = @inVal *2;
end
go

declare @OutVal int= 0;
exec spGetVal 20,@OutVal output;
print @OutVal
