--Creating Pivot Table
select * from sys.all_objects
go
SELECT *
FROM (
  SELECT
YEAR(sys.all_objects.create_date) [Year],
MONTH(sys.all_objects.create_date) [Month],
    sys.all_objects.schema_id
FROM sys.all_objects
) TableDate
PIVOT(
count(schema_id)
FOR [Month] IN(
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]
)	
) PivotTable


