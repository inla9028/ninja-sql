SELECT a.subscriber_no, a.new_ban, a.new_priceplan, a.new_campaign_code,
       a.handle_commitment, a.dealer, a.sales_agent, a.reason_code,
       a.memo_text, a.keep_user_name, a.waive_fees, a.is_move_from_sp,
       a.is_move_to_sp, a.enter_time, a.request_time, a.process_time,
       a.process_status, a.status_desc, a.priority, a.request_id,
       a.request_user_id, a.skip_ninja_validation
  FROM batch_move_subscribers a
  where --process_status='PRSD_ERROR'
  --and 
  request_id = 'NPMig_3'
  and rownum < 20
  
  select process_status, count(*)
  from batch_move_subscribers
  where request_id = 'NPMig_3'
  group by process_status
  
SELECT a.subscriber_no, new_ban, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM batch_move_subscribers a
  WHERE a.request_id     =  'NPMig'
    --AND a.enter_time     > TRUNC(SYSDATE-2)
    AND a.process_status = 'PRSD_ERROR'
   --AND a.status_desc NOT LIKE '%SOC is already on subscription%'
   --and a.status_desc not like '% SOC is not available for add to subscription!%'
   --and a.status_desc not like '% is Non Active - Current Status%'
   --and a.status_desc not like '%: Found 2 duplicate features:%'
   --and a.status_desc not like '%: Found 3 duplicate features:%'
   --and a.status_desc not like '%[VMEPOST%'
  ORDER BY a.status_desc
--  ORDER BY SUBSTR("STATUS_DESC", 0, 40), a.subscriber_no

  update batch_move_subscribers
  set process_status='WAITING'
  where process_status='IN_PROGRESS'
  and request_id = 'NPMig_2'
  
  update batch_move_subscribers
  set keep_user_name = 'N'
  where process_status = 'WAITING'
  and request_id = 'NPMig'
