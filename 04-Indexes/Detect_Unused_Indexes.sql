--Find Unused indexes in DB


SELECT OBJECT_NAME(A.[OBJECT_ID]) AS [OBJECT NAME], 
       I.[NAME] AS [INDEX NAME], 
       A.LEAF_INSERT_COUNT, 
       A.LEAF_UPDATE_COUNT, 
       A.LEAF_DELETE_COUNT 
FROM   SYS.DM_DB_INDEX_OPERATIONAL_STATS (db_id(),NULL,NULL,NULL ) A 
       INNER JOIN SYS.INDEXES AS I 
         ON I.[OBJECT_ID] = A.[OBJECT_ID] 
            AND I.INDEX_ID = A.INDEX_ID 
WHERE  OBJECTPROPERTY(A.[OBJECT_ID],'IsUserTable') = 1
and [name] is not null




--Find Missing indexes in DB

Select  OBJECT_SCHEMA_NAME(mid.object_id,mid.database_id) AS Schema_Name,
    db_name(mid.database_id) As Database_Name,
    Object_name(mid.object_id,mid.database_id) As Object_Name,
    migs.avg_user_impact, mid.equality_columns,
    mid.inequality_columns, 
    mid.included_columns
From sys.dm_db_missing_index_groups mig
Inner join sys.dm_db_missing_index_group_stats migs 
    on mig.index_group_handle =  migs.group_handle
Inner join sys.dm_db_missing_index_details mid
    on mig.index_handle = mid.index_handle










