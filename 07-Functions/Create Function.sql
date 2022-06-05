if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetAdjustmentsValues]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[GetAdjustmentsValues]



CREATE FUNCTION  dbo.GetVendEval (@WeightCode varchar(50), @PriceEval int,@QtyEval int,@LeadTimeEval int)
RETURNS int
 with RETURNS NULL ON NULL INPUT AS
begin
declare @NumValue int;
set @NumValue = (SELECT (EVALWGT_PRICEEVAL*@PriceEval + EVALWGT_QTYEVAL*@QtyEval +EVALWGT_LEADTIMEEVAL*@LeadTimeEval)/100 FROM VWCMN_EVALWGT WHERE EVALWGT_CODE = @WeightCode);
RETURN (@NumValue);
END;

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[VW_LASTITEMSTXN_FULLDATA]') AND OBJECTPROPERTY(ID, N'ISVIEW') = 1) drop view VW_LASTITEMSTXN_FULLDATA

