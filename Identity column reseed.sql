Handling identity columns
--Getting the current identity 

select ident_current("DEPART") 

--Setting identity to specific value
DBCC CHECKIDENT('DEPART',RESEED,0)
