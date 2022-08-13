--Creating Sequence in SQL Server
drop sequence myseq 
create sequence myseq as int
start with 1  -- Start with value 1
	increment by 1-- Increment with value 1
	minvalue 0 -- Minimum value to start is zero
	maxvalue 10 -- Maximum it can go to 100
	no cycle -- Do not go above 100
	cache 50 -- Increment 50 values in memory rather than incrementing from 
go
SELECT NEXT VALUE FOR myseq AS seq_no;--will fail after 10
go

drop sequence myseq 

--Adding sequence as default value in table
Alter table test add default (NEXT VALUE FOR myseq)for [Code]

--Reset sequence value to start with 100

ALTER SEQUENCE myseq
    RESTART WITH 100  
    INCREMENT BY 1
    MINVALUE 50  
    MAXVALUE 200  
    NO CYCLE  
    NO CACHE;  
