--Try and catch in sql Server
begin try
select * FROM Groups
end try
begin catch
if (error_number()= 1205)
select 'Deadlock issue'
end catch



BEGIN TRY	
DECLARE @StockID int
		begin tran							
			delete from tax where taxesID in(select SalesTax from Taxstock Where Stock =@StockID)
delete from taxstock where stock = @StockID	
select 'SUCCEEDED'
		commit
END TRY
BEGIN CATCH
	PRINT('WE CATCH THE ERROR')
	rollback
	SELECT ERROR_number()
END CATCH
