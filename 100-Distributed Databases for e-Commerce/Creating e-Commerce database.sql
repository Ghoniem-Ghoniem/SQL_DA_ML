--01: Creating the databases
use master
create database ECOMMERCEDEB
--02: Create item groups table 
use ECOMMERCEDEB
go
--Creating the groups table
--drop table itemgroup
create table itemgroup (id int identity,code varchar(10) primary key, english_name varchar(20))
-- inserting single value
insert into itemgroup(code, english_name) values('01', 'Mobile')
-- inserting multiple values
insert into itemgroup(code,english_name) values ('02','Accessories') ,('03','Cothes')

-- Check the inserted data 
select count(1) as table_count from itemgroup
select * from itemgroup

--searching for mobile elements
select * from itemgroup where english_name = 'Mobile'
--Searching for groups starts with M
select * from itemgroup where english_name like 'M%'
--Searching with vowels
select * from itemgroup where soundex (english_name) = SOUNDEX('mobyle')
select * from itemgroup where soundex (english_name) = SOUNDEX('mubyle')
select * from itemgroup where soundex (english_name) = SOUNDEX('mubyl')

--Creating the items catalog
--drop table items

create table items 
(group_id varchar(10),
item_id int identity ,
item_code varchar(20) primary key,
item_name varchar(20) unique,
item_desc varchar(max) not null
CONSTRAINT FK_itemgroup FOREIGN KEY (group_id) REFERENCES itemgroup(code) 
on delete set null
on update cascade)

--Adding invalid new items
insert into items(group_id,item_name,item_code,item_desc) values('05','ITEM01','Samsung Galaxy A50', 'Samsung Galaxy A50')
--Adding valid new items
insert into items(group_id,item_code,item_name,item_desc) values('01','ITEM01','Samsung Galaxy A50', 'Samsung Galaxy A50')
insert into items(group_id,item_code,item_name,item_desc) values('02','ITEM02','Mobile head phone', 'Mobile head phone')

--SELECTING THE ITEM DATA
SELECT * FROM ITEMS
SELECT count(1) as items_count FROM ITEMS
SELECT * FROM ITEMS where item_name like '%galaxy%'

--update the first group code from 01 to 100 to see the self integrity of the database
update itemgroup set code = '100' where code = '01'
select * from itemgroup 
select * from items

--deleting the group 01 and notice what happened to the items data?
delete from itemgroup where code = '100'
select * from items

--Team validation to see items without allocation to groups
select * from items where group_id is null

--recreate the item group again
insert into itemgroup(code, english_name) values('01', 'Mobile')


--update the item with the new group code
update items set group_id = '01' where item_code = 'ITEM01'
SELECT * FROM ITEMS


--DO you feel the data is readable?
SELECT itemgroup.english_name,ITEMS.* FROM ITEMS inner join itemgroup on ITEMS.group_id = itemgroup.code


--What complexity do you feel in the statement?
--drop view vwItems 
Create view vwItems 
as 
SELECT itemgroup.english_name,ITEMS.* FROM ITEMS inner join itemgroup on ITEMS.group_id = itemgroup.code

WITH CHECK OPTION;

go
select * from vwItems
go
--wWhere is the log of all what we did?
--We need to make a new code for the item : conatenated between group and itemcode
alter view vwItems 
as 
SELECT itemgroup.english_name,ITEMS.group_id+'-'+item_code as itemcode,item_desc FROM ITEMS inner join itemgroup on ITEMS.group_id = itemgroup.code

WITH CHECK OPTION;
go
select * from vwItems

--How to keep single responsibility protocol in DB? Procedure for the operations
--Creating the logging database
--Why creating separate logging database?
create database LOGDB
go

use logdb
create table TXNLOG (ID int identity,transaction_type varchar(20),ActionName varchar(20),Action_By varchar(20),action_date  datetime default getdate())
go


select  * from TXNLOG


--Moving forward to SRP and operation encapsulation
--Was that right to insert directly in the tables?
--What if we need to make business rules before the operation?
--What if we need to extend the functionality?
--Solution: Moving forward to programmable objects for implementation
use ECOMMERCEDB
go
--Creating programmable object for read
CREATE procedure sp_ItemGroups as
begin
	insert into LOGDB..TXNLOG (transaction_type,ActionName,Action_By,action_date) VALUES ('ITEMGROUPS','READ',SESSION_USER,GETDATE())
	select * from itemgroup
end
GO
use ECOMMERCEDB
create procedure sp_Items as
begin
	insert into LOGDB..TXNLOG (transaction_type,ActionName,Action_By,action_date) VALUES ('ITEMS','READ',SESSION_USER,GETDATE())
	select * from items
end

GO
--Calling the read FOR item groups object with logging
sp_ItemGroups -- Can You imagin what we did
sp_ItemGroups -- Can You imagin what we did
sp_ItemGroups -- Can You imagin what we did

--Calling the read FOR items object with logging
sp_Items
sp_Items
sp_Items

SELECT * FROM LOGDB..TXNLOG
--TRUNCATE TABLE LOGDB..TXNLOG


--select CURRENT_USER,SESSION_USER


--What we can do: Getting objects log per datetime per operations

use LOGDB
go
ALTER  procedure sp_GetObjectLog (@transaction_type varchar(20) = NULL)
as
Begin
	IF @transaction_type IS NOT NULL
		Select * from TXNLOG WHERE transaction_type=@transaction_type ORDER BY ACTION_DATE DESC;
	ELSE
		Select * from TXNLOG ORDER BY ACTION_DATE DESC;
End

GO


--From screens: Get the log for specific user
use LOGDB
logdb..sp_GetObjectLog 'ITEMGROUPS' --loading actions performed on items group
logdb..sp_GetObjectLog 'ITEMS'		 --loading actions performed on items 
logdb..sp_GetObjectLog				 --loading actions performed on all objects

SELECT * FROM TXNLOG				--Reading all data

-------------------------------------Moving forward to Event driven Model
---How to automate the SRP and hide details?
/*Example: Create new group: 2 steps
	1--Required creating the record
	2--Adding log for inserted records
*/

use ECOMMERCEDB
go

--triggers implement the single responsibility, and remove overheads from the team to implement more codes
create trigger dbo.itemgroup_create ON [dbo].itemgroup
after insert
as
begin
	insert into LOGDB..TXNLOG (transaction_type,ActionName,Action_By,action_date) VALUES ('ITEMGROUPS','INSERT',SESSION_USER,GETDATE())
end

--creating insert procesure for item groups
create procedure sp_itemgroup_create (@code varchar(20), @english_name varchar(20))
as
begin
	insert into itemgroup(code, english_name) values(@code, @english_name)
End

--Calling the new procedure 
sp_itemgroup_create '04','Toys'
sp_itemgroup_create '05', 'Clothes'


--Tracking on the database level
use LOGDB
go
alter table LOGDB..txnlog DROP COLUMN Action_Details
GO
alter table LOGDB..txnlog add Action_Details varchar(4000)
go
use ECOMMERCEDB
GO

CREATE TRIGGER Track_Db_Changes_TRG ON DATABASE 
	FOR CREATE_TABLE , DROP_TABLE, ALTER_TABLE 
AS 

BEGIN
	DECLARE @data XML = EVENTDATA()
	DECLARE @cmd NVARCHAR(4000) = @data.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'NVARCHAR(4000)')
   	insert into LOGDB..TXNLOG (transaction_type,ActionName,Action_Details,Action_By,action_date) VALUES ('SYSTEM','DDL',@cmd,SESSION_USER,GETDATE())
END
GO
--DROP TRIGGER Track_Db_Changes_TRG


SELECT * FROM items
--ALTER TABLE ITEMS DROP COLUMN UOM 
ALTER TABLE ITEMS ADD UOM VARCHAR(10) NOT NULL DEFAULT 'PCS'
SELECT * FROM LOGDB..TXNLOG --Notice that we have logged the executed sql statement


