
DBCC SHRINKDATABASE (lo_editor,0);
DBCC SHRINKDATABASE (lo_editor,0,truncateonly);
alter database lo_editor set recovery simple
dbcc shrinkfile (lo_editor_log,5)
alter database testdb set recovery full


