--Conditional aggregation for frequency tables

SELECT SUM(CASE WHEN ISNULL(myColumn,0)=1 THEN 1 ELSE 0 END)
FROM AD_CurrentView

SELECT COUNT(NULLIF(0, myColumn))
FROM AD_CurrentView

SELECT id, COUNT(IF status=42 THEN 1 ENDIF) AS cnt
FROM table
GROUP BY table

