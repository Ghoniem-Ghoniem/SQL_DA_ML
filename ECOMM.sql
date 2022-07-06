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
delete from itemgroup where code = '03'

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

delete from itemgroup where code ='10'


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
select * from itemgroup where ProductionDate > '1 Jan 2022'
select * from itemgroup where ProductionDate < '1 Jan 2022'
select * from itemgroup where ProductionDate= '16 Mar 2020'

select * from itemgroup where month (ProductionDate)=3 
select * from itemgroup where month (ProductionDate)>3
select * from itemgroup where year (ProductionDate)=2020
select * from itemgroup where year (ProductionDate)=2022
select * from itemgroup where year (ProductionDate)=2022 and month (ProductionDate) =3






--Ordering selection
select * from itemgroup order by id desc
select * from itemgroup order by code
select * from itemgroup order by ProductionDate
select * from itemgroup order by ProductionDate desc
select * from itemgroup order by UnitOfMeasure desc, english_name asc


--Foriegn Keys
IF OBJECT_ID (N'items', N'U') IS NOT NULL 
	drop table items 

create table items 
(group_id varchar(10),
item_id int identity ,
item_code varchar(20) primary key,
item_name varchar(20) unique,
item_desc varchar(max) not null
CONSTRAINT FK_itemgroup FOREIGN KEY (group_id) REFERENCES itemgroup(code) 
on delete set null
on update cascade)

select * from itemgroup
--Adding invalid new items with group code 400
insert into items(group_id,item_name,item_code,item_desc) values('400','ITEM01','Samsung Galaxy A50', 'Samsung Galaxy A50')
--Adding valid new items
insert into items(group_id,item_code,item_name,item_desc) values('11','ITEM01','Samsung Galaxy A50', 'Samsung Galaxy A50')
insert into items(group_id,item_code,item_name,item_desc) values('02','ITEM02','Mobile head phone', 'Mobile head phone')

select * from itemgroup
select * from items

delete from itemgroup where code = '11'

--group value is set to null
select * from items

--what to do?
ALTER TABLE items drop CONSTRAINT FK_itemgroup  

--when to make delete cascade?
ALTER TABLE items 
--with nocheck 
add CONSTRAINT FK_itemgroup FOREIGN KEY (group_id) REFERENCES itemgroup(code) 
on delete cascade
on update cascade

select * from items
--gives error for the null value

update items set group_id = '04' where group_id is null

--What happened when deleting group?
select * from itemgroup
delete from itemgroup where code = '04'
select * from items -- item is deleted

update itemgroup set code ='2000' where code ='02'



select * from itemgroup
insert into items(group_id,item_name,item_code,item_desc) values('01','ITEM11','Samsung Galaxy A50+', 'Samsung Galaxy A50')
--Adding valid new items
insert into items(group_id,item_code,item_name,item_desc) values('02','ITEM12','Samsung Galaxy A50+', 'Samsung Galaxy A50')
insert into items(group_id,item_code,item_name,item_desc) values('02','ITEM13','Mobile head phone+', 'Mobile head phone')

select * from items

---------------------------------------------------------------------------------
--Creating views
--Joining tables to simplify calls, prevent mistakes, encapsulate work
--Creating logical attributes

select * from items 
select itemgroup.english_name as groupname, items.*

from 
itemgroup inner join items 
on itemgroup.code = items.group_id

drop view vwItems 
create view vwItems as 
select itemgroup.english_name as groupname, items.*

from 
itemgroup inner join items 
on itemgroup.code = items.group_id 
go

select * from vwItems

--creating balance table
drop table itemsbalance 
go
create table itemsbalance 
(item_code varchar(20) NOT NULL,
transactioncode varchar(20) NOT NULL,
transactiontype int,
quantity int,
price float,
txndate datetime default getdate(),
PRIMARY KEY (item_code,transactioncode),
CONSTRAINT FK_item FOREIGN KEY (item_code) REFERENCES items(item_code) 
on delete cascade
on update cascade)

select * from itemsbalance 

--
insert into itemsbalance 
(item_code,transactioncode,transactiontype,quantity,price)
values 
('ITEM02','TXN-0001-2022',1,10,25),
('ITEM02','TXN-0002-2022',-1,5,25)

delete from itemsbalance 

GO
--Creating logical attributes
drop view vwitembalance 
go
create view vwitembalance as 
select itemsbalance.*, 
quantity*price as grandtotal,
quantity*price*.14 as taxes,
 quantity*price*1.14 as total
from itemsbalance
GO

select * from itemsbalance
select * from vwitembalance

--data summarization
use ECOMM
go
drop view vwitembalanceSum 
go
create view vwitembalanceSum as 
select item_code,sum(transactiontype*quantity) as totalqty
from vwitembalance 
group by item_code
GO
select * from vwitembalanceSum 

select * from itemsbalance
















--13-Pivot Tables
select * from itemgroup
sp_help itemgroup

SELECT *
FROM (
  SELECT
YEAR(ProductionDate) [Year],
MONTH(ProductionDate) [Month]
FROM itemgroup
) TableDate
PIVOT(
count([Month])
FOR [Month] IN(
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]
)	
) PivotTable

sp_help itemsbalance
go
select * from items
go

insert into itemsbalance 
(item_code,transactioncode,transactiontype,quantity,price,txndate)
values 
('ITEM12','TXN-0003-2022',1,12,25,'12 Dec 2016'),
('ITEM12','TXN-0004-2022',-1,3,25,'13 Jan 2020')

SELECT *
FROM (
  SELECT
item_code,--will be the row
Year(txndate) [Year],--will be the column
quantity*transactiontype as total_qty --will be the aggregated content
FROM itemsbalance

) TableDate
PIVOT(
sum(total_qty)
FOR [Year] 
IN
(
  [2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017],[2018],[2019],[2020],[2021],[2022]
)	
) PivotTable


create view vwItemsHistory 
as
SELECT *
FROM (
  SELECT
item_code,--will be the row
Year(txndate) [Year],--will be the column
quantity*transactiontype as total_qty --will be the aggregated content
FROM itemsbalance

) TableDate
PIVOT(
sum(total_qty)
FOR [Year] 
IN
(
  [2010],[2011],[2012],[2013],[2014],[2015],[2016],[2017],[2018],[2019],[2020],[2021],[2022]
)	
) PivotTable
go

select * from vwItemsHistory

--14-Functions

