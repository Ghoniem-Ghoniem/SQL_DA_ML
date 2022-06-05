USE [testdb]
GO


CREATE FULLTEXT CATALOG [testdbcat] AS DEFAULT;  
go
CREATE FULLTEXT INDEX ON [dbo].[employees] KEY INDEX [PK_employees] ON ([testdbcat]) WITH (CHANGE_TRACKING AUTO)
GO
USE [testdb]
GO
ALTER FULLTEXT INDEX ON [dbo].[employees] ADD ([department])
GO
USE [testdb]
GO
ALTER FULLTEXT INDEX ON [dbo].[employees] ADD ([role])
GO
USE [testdb]
GO
ALTER FULLTEXT INDEX ON [dbo].[employees] ENABLE
GO

--Run successfully
SELECT *
FROM employees
WHERE freetext(Department,'skert')

--Fail 

SELECT *
FROM employees
WHERE soundex(Department)=soundex('skert')


--

-- Using SOUNDEX  
SELECT SOUNDEX ('Smith'), SOUNDEX ('Smythe');  
SELECT *
FROM employees
WHERE soundex(Department)=soundex('skert')

 SELECT SOUNDEX ('nilson'),SOUNDEX ('nlson'),SOUNDEX ('nylson'),SOUNDEX (replace('ne lson',' ','')),SOUNDEX ('nelswn')

SELECT SOUNDEX ('محمد'), SOUNDEX ('ياسف');

SELECT difference('يوسف','ياسف');

SELECT SOUNDEX ('abb'), SOUNDEX ('abbbb');
SELECT SOUNDEX ('ather'), SOUNDEX ('attheeree');

SELECT SOUNDEX ('نصر'), SOUNDEX ('نسر');
union
SELECT SOUNDEX ('kwr'), SOUNDEX ('lsr');



select LEN('assa')

select char('assa')




declare @strOrgString varchar(100) = 'محمممد'
declare @strCurrChar varchar(1) = 'م';
SELECT replace(@strOrgString, @strCurrChar+@strCurrChar, @strCurrChar);