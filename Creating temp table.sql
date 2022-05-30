--Creating temp table
--Global Temp table
create table ##temp(val float)
insert ##temp values (3.14)
go
select * from ##temp

--Local Temp table
create table #temp(val float)
insert #temp values (3.14)
go
select * from #temp
