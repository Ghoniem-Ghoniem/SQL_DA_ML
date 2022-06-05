--Renaming column, renaming table in sql server
--Renaming column

sp_RENAME 'test.abuahmed', '1' , 'COLUMN'
GO

--Re-Naming Table
sp_RENAME 'test', 'test_tab'
GO



