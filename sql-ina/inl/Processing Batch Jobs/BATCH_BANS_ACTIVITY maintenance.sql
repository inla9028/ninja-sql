SELECT a.transaction_number, a.ban_no, a.action, a.reason_code,
       a.activity_date, a.memo_text, a.request_id, a.process_status,
       a.process_time, a.status_desc, a.record_creation_date, a.stream
  FROM batch_bans_activity a
  where request_id='TRLU0752'
  
update batch_bans_activity
set process_status='WAITING' 
where process_status='IN_PROGRESS'
and request_id='TRLU0752'

select process_status, count(*)
from batch_bans_activity
where request_id='TRLU0752'
group by process_Status

SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
  FROM batch_bans_activity a
  WHERE a.request_id IN ('TRLU0752')
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status

