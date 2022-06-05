

select 1,'Exec sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all' as sqlstatement
union 
select 2,'delete from [' +name+ ']' fromsysobjectswheretype= 'U' 
--and name like 'GL%' 
union 
select 3,'Exec sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT all' as sqlstatement




--Getting the database tables

select * from sysobjects where type ='U'
--and name like 'GL%' 
order by name
