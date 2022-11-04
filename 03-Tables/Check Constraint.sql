--Adding Check Constraint
ALTER TABLE dbo.Employee ADD CONSTRAINT
	CK_Employee_Gender CHECK (Gender IN('M','F'))

1.	Creating SQL check constraint from another table

The value for this model is to create dynamic check validator for all your enum lookup fields, like gender
Create function dbo.CheckFunction(@Value varchar(50))
RETURNS VARCHAR(10)
As
begin
declare @nRetValint= 0;
IFEXISTS(select * from EmpLog where userid=@Value)
return'True'
return'False'

CREATELOGIN adminuser WITHPASSWORD='ABCDegf123';
GO

EXEC master..sp_addsrvrolemember@loginame =N'adminuser', @rolename =N'sysadmin'
GO

--Restrict database access to specific user
Create function dbo.CheckFunction()
RETURNS VARCHAR(10)
asbegin
declare @strRetUser varchar(20)=(select ORIGINAL_LOGIN());
IF (@strRetUser ='adminuser' and PROGRAM_NAME() is not like'%sQL Server%')
return'True'
return'False'
end
GO

--select dbo.CheckFunction();
--
ALTER TABLE Citizen		
WITH no CHECK ADD CONSTRAINT CK_FatherCheck
CHECK (dbo.CheckFunction()='True')
Insert into Citizen(id,citizen_FirstName,citizen_Father,citizen_Family,Citizen_gender, Citizen_Mother)
values(-2,	NEWID(),NEWID(),	NEWID(),1,NULL)

