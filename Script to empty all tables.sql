

select 1,'Exec sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all' assqlstatement
union 
select 2,'delete from [' +name+ ']' fromsysobjectswheretype= 'U' 
--and name like 'GL%' 
union 
select 3,'Exec sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT all' assqlstatement

