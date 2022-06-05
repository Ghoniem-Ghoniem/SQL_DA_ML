if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CreateMonthlyClosingInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[MakeItemsControlForCCV]

go


create PROCEDURE [dbo].[MakeItemsControlForCCV]	@strCCVCode varchar(50)
AS
begin

DELETE FROM MMS_ITEMHIST WHERE ITEMHIST_TRANSTYPE IN ('CCV' ,'CCV-' ,'CCV+') AND ITEMHIST_TRANSNO =@strCCVCode;
INSERT INTO MMS_ITEMHIST ( ITEMHIST_CODE, ITEMHIST_QTYTRANS, ITEMHIST_TRANSTYPE,ITEMHIST_CONFIRMDATE,ITEMHIST_ITHDATE,ITEMHIST_TRANSNO,ITEMHIST_ITHFROM,ITEMHIST_ITHTO)
 SELECT MMS_CCVITEM.CCVITEM_FROMITEM, MMS_CCVITEM.CCVITEM_FROMQTY, 'CCV-' AS Expr1,CCV_CONFIRMDATE, CCV_DATE,CCV_CODE,CCV_STORE,NULL
 FROM MMS_CCVITEM,MMS_CCV 
 WHERE MMS_CCVITEM.CCVITEM_CCV=MMS_CCV.CCV_CODE AND MMS_CCVITEM.CCVITEM_CCV=@strCCVCode 
UNION
 SELECT MMS_CCVITEM.CCVITEM_TOITEM, SUM(MMS_CCVITEM.CCVITEM_FROMQTY) AS TOTQTY, 'CCV+' AS Expr1,CCV_CONFIRMDATE, CCV_DATE,CCV_CODE,NULL,CCV_STORE
 FROM MMS_CCVITEM,MMS_CCV
 WHERE MMS_CCVITEM.CCVITEM_CCV=MMS_CCV.CCV_CODE AND MMS_CCVITEM.CCVITEM_CCV=@strCCVCode 
 GROUP BY CCVITEM_TOITEM,CCV_CONFIRMDATE, CCV_DATE,CCV_CODE,CCV_STORE;
 
 UPDATE MMS_ITEMHIST SET MMS_ITEMHIST.ITEMHIST_ONHAND = STCKITEM_TOTALQTY, MMS_ITEMHIST.ITEMHIST_STOREONHAN =  STORITEM_ONHAND,MMS_ITEMHIST.ITEMHIST_PRICE =MMS_STORITEM.STORITEM_LASTPRICE FROM MMS_STORITEM ,MMS_STCKITEM WHERE MMS_STORITEM.STORITEM_STORECODE = MMS_ITEMHIST.ITEMHIST_ITHFROM AND MMS_ITEMHIST.ITEMHIST_CODE = MMS_STORITEM.STORITEM_STOCKITEM AND MMS_ITEMHIST.ITEMHIST_CODE = MMS_STCKITEM.STCKITEM_CONCATENATED AND MMS_ITEMHIST.ITEMHIST_TRANSNO = @strCCVCode AND (MMS_ITEMHIST.ITEMHIST_TRANSTYPE = 'CCV-' OR MMS_ITEMHIST.ITEMHIST_TRANSTYPE = 'CCV' OR MMS_ITEMHIST.ITEMHIST_TRANSTYPE = 'CCV+');
 
 UPDATE MMS_ITEMHIST SET MMS_ITEMHIST.ITEMHIST_ONHAND = STCKITEM_TOTALQTY, MMS_ITEMHIST.ITEMHIST_STOREONHAN =  STORITEM_ONHAND,MMS_ITEMHIST.ITEMHIST_PRICE =MMS_STORITEM.STORITEM_LASTPRICE FROM MMS_STORITEM ,MMS_STCKITEM WHERE MMS_STORITEM.STORITEM_STORECODE = MMS_ITEMHIST.ITEMHIST_ITHTO AND MMS_ITEMHIST.ITEMHIST_CODE = MMS_STORITEM.STORITEM_STOCKITEM AND MMS_ITEMHIST.ITEMHIST_CODE = MMS_STCKITEM.STCKITEM_CONCATENATED AND MMS_ITEMHIST.ITEMHIST_TRANSNO = @strCCVCode AND (MMS_ITEMHIST.ITEMHIST_TRANSTYPE = 'CCV-' OR MMS_ITEMHIST.ITEMHIST_TRANSTYPE = 'CCV' OR MMS_ITEMHIST.ITEMHIST_TRANSTYPE = 'CCV+');
UPDATE MMS_ITEMHIST SET ITEMHIST_ACCFROM = STORE_ACCOUNT , ITEMHIST_CSFROM = STORE_COSTCENT FROM MMS_STORE WHERE MMS_STORE.STORE_CODE = MMS_ITEMHIST.ITEMHIST_ITHFROM AND ITEMHIST_ACCFROM IS NULL AND (MT_TYPE IS NULL OR MT_TYPE <> 'D/S' OR MT_TYPE <> 'C/S');
UPDATE MMS_ITEMHIST SET ITEMHIST_ACCTO = STORE_ACCOUNT , ITEMHIST_CSTO = STORE_COSTCENT FROM MMS_STORE WHERE MMS_STORE.STORE_CODE = MMS_ITEMHIST.ITEMHIST_ITHTO AND ITEMHIST_ACCTO IS NULL AND (MT_TYPE IS NULL OR MT_TYPE <> 'S/D' OR MT_TYPE <> 'S/C');


end