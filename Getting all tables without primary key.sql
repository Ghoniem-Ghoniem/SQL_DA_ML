Getting all tables without primary key
SELECTSCHEMA_NAME(schema_id)AS SchemaName,name AS TableName
FROM sys.tables
WHERE OBJECTPROPERTY(OBJECT_ID,'TableHasPrimaryKey')= 0
ORDERBY SchemaName, TableName;
