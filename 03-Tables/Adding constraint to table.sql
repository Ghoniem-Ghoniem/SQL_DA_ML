ALTER TABLE dbo.FMS_ACSRYLOG ADD CONSTRAINT 
	FK_FMS_ACSRYLOG_FMS_ACSRY_MAIN_DETAIL FOREIGN KEY
	(
	ACSRYLOG_ACSRYCOD
	) REFERENCES dbo.FMS_ACSRY
	(
	ACSRY_COD
	) ON UPDATE CASCADE
	 ON DELETE CASCADE


	 ALTER TABLE CMN_SEGCODE  DROP CONSTRAINT FK_CMN_SEGCODE_SEGCODE_APPCODE_SEGCODE_TABLENAME