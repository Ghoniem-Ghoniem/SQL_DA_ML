alter procedure CreateBarcodes @count int,@truncate int
as
begin
declare @nLoop int = 0
if @truncate = 1
	truncate table Barcodes
while @nLoop<@count
	begin
		insert into BarCodes (Barcode) values (rand()* 10000000000000000)
		set @nLoop = @nLoop+1
	end
end


CreateBarcodes 5000000,1 --takes 30 minutes

select count(1) from Barcodes
select * from BarCodes where Barcode =2218596654810482

