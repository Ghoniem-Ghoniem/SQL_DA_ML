/****CREATING DATABAE***/
create database ECOMM
GO
USE ECOMM
GO
select db_name()
go


select * from sys.databases
GO

--drop database ECOMM

/****CREATING TABLES***/
--Creating the groups table
--drop table itemgroup
USE ECOMM
GO

create table itemgroup 
(id int identity,
code varchar(10) primary key,
english_name varchar(20) not null,
Item_Details varchar(100),
UnitOfMeasure varchar(10) DEFAULT 'PCS',
ProductionDate datetime default getdate())

SELECT * FROM itemgroup
--reading table info from data dictionary

SELECT *
FROM sys.Tables
GO

sp_help itemgroup
go


/*****INSERTING DATA INTO TABLES*******************************/
USE ECOMM
GO
--delete from ITEMGROUP
go
--Will give error because of identity
INSERT INTO ITEMGROUP
(id, [code], [english_name], [Item_Details], [UnitOfMeasure], [ProductionDate])
VALUES
(1, '01','Mobiles','Andoid Phones','PCS','12 Mar 2022')


select * from itemgroup
--Insert Duplicate in PK gives error
INSERT INTO ITEMGROUP([code], [english_name], [Item_Details],[ProductionDate])
VALUES				 ('01','Tablets','Andoid Tablets','14 Mar 2022')

--Insert new record
INSERT INTO ITEMGROUP([code], [english_name], [Item_Details],[ProductionDate])
VALUES				 ('02','Tablets','Andoid Tablets','15 Mar 2022')

select * from itemgroup
--Insert multi rows using vallues
INSERT INTO ITEMGROUP([code], [english_name], [Item_Details],[ProductionDate])
VALUES				 
('03','Head Phones','Android head Phones','16 Mar 2020') ,
('04','Mouses','Wired and Wireless Mouses','17 Mar 2020')

select * from itemgroup


--inserting multi rows using sql statement
INSERT INTO ITEMGROUP([code], [english_name], [Item_Details],[ProductionDate])
select '05','Microphones','Wired and wireless micro phones','13 Mar 2020' 

select * from itemgroup

--which means we can use select statement to insert new data 


--inserting data from another table
INSERT INTO ITEMGROUP([code], [english_name], [Item_Details])
select --Fields
Code, [Name], Details 
from 
[OldGroups]




select * from itemgroup--Check the identity value now



/*************Updating and deleting data*******************/
--Updating Primary Keys
use ECOMM
go
--Updating the primary key
update itemgroup 
set code = '100' where code = '01'

select * from itemgroup

update itemgroup 
set code = '04' where code = '03' --gives error

--Updating date

update itemgroup
set productionDate = '1 Jan 2022'
select * from itemgroup


update itemgroup
set Item_Details = 'Android tablets 10 Inc',  ProductionDate= '1 Jan 2021' 
where
code = '02'

UPDATE itemgroup SET UnitOfMeasure ='KG' WHERE CODE = '11'


select * from itemgroup



--deleting data
delete from itemgroup
where code = '10'


delete from itemgroup
where english_name = 'Cheese'

delete from itemgroup
where code in ('02','03')

select * from itemgroup --check the current index


--inserting data from another table again and recheck the index
INSERT INTO ITEMGROUP([code], [english_name], [Item_Details])
select --Fields
Code, [Name], Details 
from 
[OldGroups]

delete from itemgroup
--truncating table


Truncate table itemgroup  --it considered as rebuilding to the table structure again, remember the identity column previous values

--insert new record and check the index again
select * from itemgroup






/*****NUMBERING SEARCH*******************************/
use ECOMM
go

-- Select All data
Select * from itemgroup where code = '01'

-- Select Partial data columns, Why?
Select id,code,english_name from itemgroup

-- Select Partial Rowns by count, Why?
select * from itemgroup
Select top 5 * from itemgroup
-- Select Partial Rowns by percentage, Why?
Select top 20 percent * from itemgroup

-- Numbers search
select * from itemgroup where id > 4
select * from itemgroup where id <4
select * from itemgroup where id =4

select * from itemgroup where id >4 and id<7

select * from itemgroup where id in (1,3,5)
select * from itemgroup where id = 1 or id = 3 or id = 5


SELECT ROUND(10.567,2)
SELECT ABS(-10.567)
SELECT CEILING(10.567)
SELECT FLOOR(10.567)
SELECT SQRT(25)
SELECT SQUARE(5)
SELECT SIGN(10.2)
SELECT SIGN(-10.2)
select SQUARE(id) from itemgroup


--Text search with equality

select * from itemgroup where UnitOfMeasure ='PCS'
select * from itemgroup where UnitOfMeasure ='KG'
select * from itemgroup where UnitOfMeasure <> 'KG'

--Text search with like
select * from itemgroup where Item_Details like 'And%'
select * from itemgroup where Item_Details like '%Phones'

--Vowels search
select * from itemgroup where soundex(english_name) = soundex('Tblt') --tablet tublit tublite
select * from itemgroup where soundex(english_name) = soundex('Tublt')
select * from itemgroup where soundex(english_name) = soundex('Tublite')



--searching date fields
select * from itemgroup where ProductionDate> '1 Jan 2022'
select * from itemgroup where ProductionDate< '1 Jan 2022'
select * from itemgroup where ProductionDate= '16 Mar 2020'

select * from itemgroup where month (ProductionDate)=3
select * from itemgroup where month (ProductionDate)>3
select * from itemgroup where year (ProductionDate)=2020
select * from itemgroup where year (ProductionDate)=2022
select * from itemgroup where year (ProductionDate)=2022 and month (ProductionDate) =3






--Ordering selection

select * from itemgroup order by code
select * from itemgroup order by ProductionDate
select * from itemgroup order by ProductionDate desc
select * from itemgroup order by UnitOfMeasure desc, english_name asc
















