UPDATE ninjadata.master_transactions a
  SET a.request_time = TO_DATE('2009-10-27 00:30', 'YYYY-MM-DD HH24:MI')
      , a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  WHERE a.request_id IN ('TD 4466')
    AND a.process_status = 'PRSD_ERROR'
    AND a.status_desc LIKE '%InvalidCombinationsException%'

