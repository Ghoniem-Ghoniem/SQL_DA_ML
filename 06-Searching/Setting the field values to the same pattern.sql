
--Setting the field values to the same pattern
SELECT REPLICATE('0', 10-len(groupid))+groupid from Groups;
/*the result will be : 
0000000000
0000000001
0000000004
0000000008
*/

--Getting the row number
SELECT ROW_NUMBER()over (order by groupid)as'Row Number',(REPLICATE('0', 10-len(groupid))+groupid) from groups
