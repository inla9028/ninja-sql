SELECT a.transaction_number, a.ban_no, a.subscriber_no, a.charge_code,
       a.actv_reason_code, a.amount, a.user_bill_text, a.memo_text,
       a.effective_date, a.process_status, a.process_time,
       a.status_desc, a.record_creation_date, a.request_id, a.stream,
       a.request_user_id
  FROM batch_charge_addition a
  --where a.subscriber_no='04746745582'
  where a.request_user_id='19.12.2013'
  and a.process_status='PRSD_ERROR'
  
  select process_status, count(*)
  FROM batch_charge_addition a
  where a.request_id='17.07.2014'
  group by process_status
  
  SELECT a.subscriber_no, a.charge_code,
       a.actv_reason_code, a.amount, a.user_bill_text,RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_charge_addition a
  WHERE a.request_id      IN ('TBS 091210')
    AND a.request_user_id IN ('SMSm112010')
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.status_desc
