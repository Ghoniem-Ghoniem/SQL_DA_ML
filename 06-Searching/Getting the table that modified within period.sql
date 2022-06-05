--Getting the table that modified within period

use SampleDB
go
select * from sys.objects
where (type = 'U' or type = 'P')
and modify_date >GETDATE()-1
SELECT * FROM sys.objects order by modify_date desc
