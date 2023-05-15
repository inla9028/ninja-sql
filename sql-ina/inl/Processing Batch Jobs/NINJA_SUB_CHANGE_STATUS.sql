SELECT a.trans_number, a.subscriber_no, a.action_code, a.dealer_code,
       a.memo_text, a.reason_code, a.fee_waiver_code, a.enter_time,
       a.request_time, a.priority, a.process_time, a.process_status,
       a.status_desc, a.request_reference_id, a.release_ctn,
       a.prepaid_user, a.hlr_stream, a.current_status
  FROM ninja_sub_change_status a
  where a.request_reference_id ='tobj1039'
  
  update ninja_sub_change_status 
  set request_time = TO_DATE('2010-06-23 01:00', 'YYYY-MM-DD HH24:MI')
  WHERE request_reference_id = 'tobj1039';
  
  select process_status, count(*)
  from ninja_sub_change_status
  where request_reference_id = 'tobj1039'
  group by process_status

SELECT a.trans_number, a.subscriber_no, a.action_code, a.dealer_code,
       a.memo_text, a.reason_code, a.fee_waiver_code, a.enter_time,
       a.request_time, a.priority, a.process_time, a.process_status,
       a.status_desc, a.request_reference_id, a.release_ctn,
       a.prepaid_user, a.hlr_stream, a.current_status
  FROM ninja_sub_change_status a
  where a.request_reference_id ='tobj1039'
  and a.process_status = 'PRSD_ERROR'
  
  
  select count(*), request_reference_id
  from ninja_sub_change_status
  where process_Status='WAITING'
  group by request_reference_id
  
