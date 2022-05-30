--Enable tracking for database
alter database koudjis set change_tracking=on (CHANGE_RETENTION = 100 DAYS,AUTO_CLEANUP = ON)

alter table area enable change_tracking WITH (TRACK_COLUMNS_UPDATED = OFF)
declare @sync_new_received_anchor int;
declare @sync_initialized int;

SET @sync_new_received_anchor =1;
set @sync_initialized = 1;

set @sync_new_received_anchor= CHANGE_TRACKING_CURRENT_VERSION()-3

IF @sync_initialized = 0
SELECT account.*
FROM account LEFT OUTER JOIN 
  CHANGETABLE(CHANGES account, 0)CT
ON CT.[accountid] = account.[accountid]
ELSE
BEGIN
  SELECT *
FROM account JOINCHANGETABLE(CHANGES account, @sync_new_received_anchor  ) CT
ON CT.[accountid] = account.[accountid]
--  WHERE (
  --CT.SYS_CHANGE_OPERATION = 'I' AND 
  --CT.SYS_CHANGE_CREATION_VERSION 
  --<= @sync_new_received_anchor)
END


