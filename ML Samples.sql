EXECUTE sp_execute_external_script @language = N'Python'
    , @script = N'SQL_out = SQL_in.dropna();'
    , @input_data_1 = N'SELECT FirstName, LastName, Title FROM AdventureWorks2017.Person.Person ORDER BY ModifiedDate DESC;'
    , @input_data_1_name  = N'SQL_in'
    , @output_data_1_name = N'SQL_out'
WITH RESULT SETS((FirstName NVARCHAR(255) NOT NULL, LastName NVARCHAR(255) NOT NULL, Title NVARCHAR(255) NOT NULL));


exec sp_execute_external_script 
@language =N'Python',
@script=N'OutputDataSet = InputDataSet
print("Input data is {0}".format(InputDataSet))
', 
@input_data_1 = N'SELECT 1 as col'



exec sp_execute_external_script
@language = N'Python'
,@script=
N'
print("""jan:{2} feb:{0} mar:{2} Apr:{1} May:{2} Jun:{1} Jul:{2} Aug:{2} Sep:{1} Oct:{2} Nov:{1} Dec:{2}""".format(InputDataSet.A, InputDataSet.B, InputDataSet.C))
',
@input_data_1 = N'select 28 as A ,30 as B,31 as C'



DROP TABLE IF EXISTS dbo.EMP
GO
CREATE TABLE [dbo].[EMP](
	[empno] [int] NOT NULL,
	[ename] [varchar](10) NULL,
	[job] [varchar](9) NULL,
	[mgr] [int] NULL,
	[hiredate] [datetime] NULL,
	[sal] float NULL,
	[comm] [numeric](7, 2) NULL,
	[dept] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[empno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
 
GO
 
INSERT INTO EMP VALUES
    (1,'Prashanth','ADMIN',6,'12-17-1990',18000,NULL,4)
INSERT INTO EMP VALUES
    (2,'Jayaram','MANAGER',9,'02-02-1998',52000,300,3)
INSERT INTO EMP VALUES
    (3,'thanVitha','SALES I',2,'01-02-1996',25000,500,3)




 
SELECT EMPNO,ENAME,SAL from EMP
 
EXECUTE sp_execute_external_script 
@language = N'Python',
@script=N'OutputDataSet = InputDataSet
for i in OutputDataSet["sal"]:
	OutputDataSet["Bonus"]=OutputDataSet["sal"]*0.05',
@input_data_1 = N'SELECT [empno],[ename],sal,0 as Bonus from EMP'
WITH RESULT SETS ((EMPNO int, ENAME varchar(10), SAL float, Bonus float))







------

DROP TABLE IF EXISTS MyData;
CREATE TABLE MyData([Col1] INT NOT NULL) ON [PRIMARY];
INSERT INTO MyData VALUES(1);
INSERT INTO MyData VALUES(10);
INSERT INTO MyData VALUES(100);
GO
 
-- print all rows of MyData table
SELECT * FROM MyData;
 
--Find mean of Col1
 
 EXECUTE sp_execute_external_script  
@language = N'Python'  
, @script = N'
import pandas
print("*******************************")
OutputDataSet = InputDataSet
print (OutputDataSet)
print (OutputDataSet.mean())
print("*******************************")
'
, @input_data_1 = N'SELECT * from Mydata'



-----
