SELECT a.*
  FROM ninjadata.batch_charge_addition a
 WHERE a.process_time BETWEEN to_date('2015-03-18 10:00', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2015-03-18 10:04', 'YYYY-MM-DD HH24:MI')
ORDER BY a.transaction_number
;


SELECT a.*
  FROM ninjadata.batch_charge_addition a
 WHERE a.transaction_number BETWEEN 20473645 AND 20474075
;

UPDATE ninjadata.batch_charge_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
  WHERE a.transaction_number BETWEEN 20473645 AND 20474075
    AND a.process_status != 'PRSD_ERROR'
;

SELECT a.charge_code, a.request_id, a.request_user_id, a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_charge_addition a
 WHERE a.transaction_number BETWEEN 20473645 AND 20474075
GROUP BY a.charge_code, a.request_id, a.request_user_id, a.process_status
ORDER BY a.charge_code, a.request_id, a.request_user_id, a.process_status
;

SELECT a.ban_no, a.subscriber_no, a.charge_code, a.amount, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_charge_addition a
 WHERE a.transaction_number BETWEEN 20473645 AND 20474075
   AND a.process_status  = 'PRSD_ERROR'
ORDER BY a.ban_no, a.subscriber_no, a.transaction_number
;
