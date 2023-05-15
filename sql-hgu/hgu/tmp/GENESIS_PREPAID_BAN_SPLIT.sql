SELECT a.*
  FROM genesis_prepaid_ban_split a
ORDER BY a.request_time
;

UPDATE genesis_prepaid_ban_split a
   SET a.process_time   = NULL
     , a.status_desc    = NULL
     , a.process_status = 'WAITING'
 WHERE a.ban            = 598241412
   AND a.process_status = 'PRSD_ERROR'
;
