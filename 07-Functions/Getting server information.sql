--Getting server information
select @@VERSION,	@@SERVICENAME,@@SERVERNAME,APP_NAME(),DB_NAME(),CURRENT_USER,
case
when (windows_release like'10%')then'Windows 10 or Windows Server 2016'
when (windows_release like'6.3%')then'Windows 8.1	or Windows Server 2012 R2'
when (windows_release like'6.2%')then'Windows 8 or Windows Server 2012'
when (windows_release ='6.1')then'Windows 7 or Windows Server 2008 R2'
when (windows_release ='6.0')then'Windows Server 2008 Windows Vista'
else'Unknown'
end
, windows_service_pack_level, windows_sku, os_language_version  
FROM sys.dm_os_windows_info;

