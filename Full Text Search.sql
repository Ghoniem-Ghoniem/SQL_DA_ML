USE [custom]
GO
CREATE FULLTEXT INDEX ON [dbo].[Religion] KEY INDEX [PK_tblReligion] ON ([CustomFTS]) WITH (CHANGE_TRACKING AUTO)
GO
USE [custom]
GO
ALTERFULLTEXTINDEXON [dbo].[Religion] ADD ([NameA])
GO
USE [custom]
GO
ALTERFULLTEXTINDEXON [dbo].[Religion] ADD ([NameE])
GO
USE [custom]
GO
ALTER FULLTEXT INDEX ON [dbo].[Religion] ENABLE
GO

//Run successfully
SELECT *
FROM Religion
WHERE CONTAINS(Mynam,'SALAH')

//Fail 

SELECT *
FROM Religion
WHERE (Mynam ='SALAH')
