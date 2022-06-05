Getting value fro previous records

select Item,Qty, lag(qty)over (partitionby item orderby txndate)as balance from stockTxn


Getting value fro next records

select Item,Qty, lead(qty)over (partitionby item orderby txndate)as balance from stockTxn

