--Conditional Selection
declare @a int = 10
declare @b int = 5
SELECT IIF ( @a > @b, 'TRUE', 'FALSE' ) AS Result;
go
SELECT Words_Metadata.*, iif(dbo.Words_Metadata.verblength>5,'true','false') long_verb FROM Words_Metadata
go

