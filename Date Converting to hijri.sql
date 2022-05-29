--Converting to hijri
DECLARE @DateTime AS DATETIME
SET @DateTime=GETDATE()

SELECT @DateTime AS [Gregorian Date]
,FORMAT(@DateTime,'dd-MM-yyyy','ar')
AS [Gregorian date to Hijri date]

UNION ALL

SELECT @DateTime AS [Gregorian Date]
,FORMAT(@DateTime,'dd/MM/yyyy','ar')
AS [Gregorian date to Hijri date]

UNION ALL

SELECT @DateTime AS [Gregorian Date]
,FORMAT(@DateTime,'yyyy-MM-dd','ar')
AS [Gregorian date to Hijri date]

UNION ALL

SELECT @DateTime AS [Gregorian Date]
,FORMAT(@DateTime,'dddd/MMMM/yyyy','ar')
AS [Gregorian date to Hijri date]

UNION ALL

SELECT @DateTime AS [Gregorian Date]
,FORMAT(@DateTime,'dd-MM-yyyy','ar')
AS [Gregorian date to Hijri date]
GO
/*
The result will be:

2015-08-18 15:46:35.643	03-11-1436
2015-08-18 15:46:35.643	03/11/1436
2015-08-18 15:46:35.643	1436-11-03
2015-08-18 15:46:35.643	الثلاثاء/ذو القعدة/1436
2015-08-18 15:46:35.643	03-11-1436
*/
select GETDATE()-325,convert(nchar, getdate()-325,120)
union
select GETDATE()-325,convert(nchar, getdate()-325,121)

union
select GETDATE()-325,convert(nchar, getdate()-325,126)
union
select GETDATE()-325,convert(nchar, getdate()-325,127)
union
select GETDATE()-325,convert(nchar, getdate()-325,130)
union
select GETDATE()-325,convert(nchar, getdate()-325,131)
union
select
GETDATE()-325,format(GETDATE()-325,'dd/MMM/yyyy','Ar-sa')-- Um alqura calendar
union
select GETDATE()-325,format(GETDATE()-325,'dd/MMM/yyyy')


