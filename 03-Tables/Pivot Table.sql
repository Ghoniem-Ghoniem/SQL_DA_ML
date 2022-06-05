SELECT *
FROM (
  SELECT
    YEAR(vwmms_po.PO_CONFRMDATE) [Year],
    MONTH(vwmms_po.PO_CONFRMDATE) [Month],
    vwmms_po.PO_MATVALUE
  FROM vwmms_po
) TableDate
PIVOT (
  SUM(PO_MATVALUE)
  FOR [Month] IN (
    [1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]
  )
) PivotTable

