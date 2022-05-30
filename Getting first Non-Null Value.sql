--Getting first Non-Null Value
--helps in Arabic and English value
SELECT COALESCE (NULL,'AHMED')--FROM Employee
GO
SELECT COALESCE ('AHMED','AYMAN')--FROM Employee

--SELECT COALESCE(ARNAME,EMPNAME)FROM Employee