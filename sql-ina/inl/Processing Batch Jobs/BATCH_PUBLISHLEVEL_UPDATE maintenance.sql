SELECT a.transaction_number, a.subscriber_no, a.publish_level,
       a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.request_user_id
  FROM batch_publishlevel_update a
  where a.process_status='PRSD_ERROR'
  and request_id ='IER 21.03.2011'
  and request_user_id='IER'
  
  select process_status, count(*)
  FROM batch_publishlevel_update
  where request_id ='IER 21.03.2011'
  and request_user_id='IER'
  group by process_status
  
  
