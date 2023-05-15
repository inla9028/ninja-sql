SELECT a.subscriber_no, a.new_priceplan, a.new_campaign_code,
       a.new_subscription_type, a.handle_commitment, a.effective_date,
       a.dealer, a.sales_agent, a.reason_code, a.memo_text,
       a.waive_fees, a.enter_time, a.request_time, a.process_time,
       a.process_status, a.status_desc, a.priority, a.requestor_id,
       a.skip_ninja_validation
  FROM master_chg_pp_trans a
  where  a.requestor_id = 'dsk 18.11.2008' and a.process_status='PRSD_ERROR'
  order by a.status_desc
  
  update master_chg_pp_trans a
  set a.process_status='WAITING'
  where a.process_status='IN_PROGRESS' and a.requestor_id = 'TJP 04.04.2011';
  commit work;
  
  select requestor_id,count(*) from master_chg_pp_trans
  where process_status='WAITING'
  group by requestor_id
  
   update master_chg_pp_trans a
  set a.process_status='WAITING'
  where a.process_status='WAITING' and a.requestor_id = 'AHV';
  commit work;
  
  SELECT 
       a.process_status, count(*)
  FROM master_chg_pp_trans a
  where  a.requestor_id = 'dsk 18.11.2008'
  group by a.process_status
  
  select * from master_chg_pp_trans a
  where a.new_priceplan='PSUB'
  and a.new_campaign_code='000000000'
  and a.process_status ='PRSD_SUCCESS'
  
  select * from master_chg_pp_trans a
  where a.requestor_id = 'RVH 14.03.2008'
  
  update master_chg_pp_trans a
  set a.new_campaign_code = '000000000', a.process_status='WAITING', a.status_desc=null
  where a.requestor_id = 'RVH 14.03.2008';
  commit work;
  
  select subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM master_chg_pp_trans a
  where  a.requestor_id = 'dsk 18.11.2008' and a.process_status='PRSD_ERROR'
  order by a.status_desc
