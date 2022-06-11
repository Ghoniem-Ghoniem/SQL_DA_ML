use ECOMMERCEDEB
go
--Creating the groups table
create table itemgroup (id int identity primary key, arabic_name varchar(20), english_name varchar(20))
-- inserting single value
insert into itemgroup(arabic_name,english_name) values('جوال','Mobile')
-- inserting multiple values
insert into itemgroup(arabic_name,english_name) values ('إكسسوارات','Accessories') ,('ملابس','Cothes')

