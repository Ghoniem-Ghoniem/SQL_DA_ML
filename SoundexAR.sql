use TestDB
go

alter function AdjustSimilars(@strOrgchar varchar(1))
returns varchar(1)
--WITH ENCRYPTION --to encrypt the function body and keep privacy to work
as
begin
set @strOrgchar = REPLACE(@strOrgchar,'ا','أ')
set @strOrgchar = REPLACE(@strOrgchar,'إ','أ')
set @strOrgchar = REPLACE(@strOrgchar,'ء','أ')
set @strOrgchar = REPLACE(@strOrgchar,'ؤ','و')
set @strOrgchar = REPLACE(@strOrgchar,'ى','ي')
set @strOrgchar = REPLACE(@strOrgchar,'ت','ط')
set @strOrgchar = REPLACE(@strOrgchar,'ة','ط')

set @strOrgchar = REPLACE(@strOrgchar,'ث','ص')
set @strOrgchar = REPLACE(@strOrgchar,'س','ص')

set @strOrgchar = REPLACE(@strOrgchar,'د','ض')

set @strOrgchar = REPLACE(@strOrgchar,'ذ','ظ')
set @strOrgchar = REPLACE(@strOrgchar,'ز','ظ')

set @strOrgchar = REPLACE(@strOrgchar,'ح','ه')
set @strOrgchar = REPLACE(@strOrgchar,'ق','ك')
set @strOrgchar = REPLACE(@strOrgchar,'ه','ط')
set @strOrgchar = REPLACE(@strOrgchar,'ي','ى')
return @strOrgchar;
end
go
select dbo.AdjustSimilars('ت');
select dbo.AdjustSimilars('ث');
select dbo.AdjustSimilars('س');
go
-- check the code is secured
alter function RemoveVowels(@strOrgString varchar(100))
returns varchar(100)
WITH ENCRYPTION
as
begin
set @strOrgString = REPLACE(@strOrgString,'أ','')
set @strOrgString = REPLACE(@strOrgString,'ا','')
set @strOrgString = REPLACE(@strOrgString,'إ','')
set @strOrgString = REPLACE(@strOrgString,'و','')
set @strOrgString = REPLACE(@strOrgString,'ؤ','')
set @strOrgString = REPLACE(@strOrgString,'ي','')
set @strOrgString = REPLACE(@strOrgString,'ى','')
set @strOrgString = REPLACE(@strOrgString,'ة','')
return @strOrgString;
end
go
select dbo.RemoveVowels('حأحمدااا');
go
alter function RemoveAdditionals(@strOrgString varchar(100))
returns varchar(100)
WITH ENCRYPTION
as
begin
if(CHARINDEX('ال',@strOrgString,0)=1)
set @strOrgString = right(@strOrgString,len(@strOrgString)-2);
if(right(@strOrgString,1)='ه' or right(@strOrgString,1)='ة')
set @strOrgString = left(@strOrgString,len(@strOrgString)-1);


return @strOrgString;
end
go
select dbo.RemoveAdditionals('السيد');
go
alter  function dbo.soundexAr(@strOrgString varchar(100),@strTargetString varchar(100))
returns varchar(100)
--WITH ENCRYPTION
as
begin

if (@strOrgString = @strTargetString)-- if the values are equals
return 1;
if (soundex(@strOrgString) = soundex(@strTargetString) and soundex(@strOrgString)!='0000')-- if the values are english, use default soundex
return 1;
--01- getting the first character
set @strOrgString = UPPER(@strOrgString);
set @strTargetString = UPPER(@strTargetString);
set @strOrgString = dbo.RemoveAdditionals(@strOrgString);
set @strTargetString = dbo.RemoveAdditionals(@strTargetString);
declare @strOrgFirstChar varchar(1)= LEFT(@strOrgString, 1);
declare @strTargetFirstChar varchar(1)= LEFT(@strTargetString, 1);
declare @nRetVal int = 0;
declare @strCurrChar varchar(1);
declare @strNextChar  varchar(1);
--02- Remove vowles from original and destination values
set @strOrgString = dbo.RemoveVowels(@strOrgString);
set @strTargetString = dbo.RemoveVowels(@strTargetString);

--03- Remove voules from original value
set @strOrgFirstChar = dbo.AdjustSimilars(@strOrgFirstChar);
set @strTargetFirstChar  = dbo.AdjustSimilars(@strTargetFirstChar );

set @strOrgString = @strOrgFirstChar+right(@strOrgString,len(@strOrgString)-1);
set @strTargetString = @strTargetFirstChar+right(@strTargetString,len(@strTargetString)-1);




DECLARE @pos INT = 1;
declare @nCount int = len(@strOrgString);
while @pos < @nCount
begin
	set @strCurrChar =  SUBSTRING ( @strOrgString ,@pos, 1);
	if (@strCurrChar = '' or @strCurrChar is null)
		break;
	set @strOrgString = replace(@strOrgString,replicate(@strCurrChar,2),@strCurrChar);
	set @pos = @pos+1;
end

set @pos  = 1;
set @nCount = len(@strTargetString);

while @pos < @nCount
begin
	set @strCurrChar =  SUBSTRING ( @strTargetString ,@pos, 1);
	if (@strCurrChar = '' or @strCurrChar is null)
		break;
	set @strTargetString = replace(@strTargetString,replicate(@strCurrChar,2),@strCurrChar);
	set @pos = @pos+1;
end



if(@strOrgString =@strTargetString)
set @nRetVal= 1;

return @nRetVal

end

go

declare @stringSource varchar(100) = 'تلميذة'
--declare @stringDesc varchar(100) = 'طلمذ'
declare @stringDest varchar(100) = 'تلاميذ'
select dbo.soundexAr(@stringDest,@stringSource);
select dbo.soundexAr(@stringSource ,@stringDest);




select * from Employees where dbo.soundexAr(ArabicName,'أسماء')=1;
select * from Employees where dbo.soundexAr(ArabicName,'محمد')=1;
select * from Employees where dbo.soundexAr(ArabicName,'eman')=1;
select * from Employees where dbo.soundexAr(ArabicName,'joan')=1;
select * from Employees where dbo.soundexAr(ArabicName,'سيد')=1;
select * from Employees where dbo.soundexAr(ArabicName,'طالب')=1;
select * from Employees where dbo.soundexAr(ArabicName,'تلميذ')=1;
select * from Employees where dbo.soundexAr(ArabicName,'استخبار')=1;
select * from Employees where dbo.soundexAr(ArabicName,'ذكي')=1;
select * from Employees where dbo.soundexAr('مثلث','مسلس')=1;
