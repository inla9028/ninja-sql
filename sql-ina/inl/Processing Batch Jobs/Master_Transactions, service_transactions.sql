SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM master_transactions a
  where a.request_time > sysdate -2
  and a.process_status='PRSD_ERROR'
  and a.request_id='TRANSFER 10.08.2008'
  and exists(
  --and status_desc like 'no.netcom.ninja.core.system.tuxedo.exception.EnvironmentException: No Jolt connections available%'
  order by a.status_desc


            select * from master_transactions a
            WHERE a.request_id='TRANSFER 10.08.2008'
            AND (status_desc LIKE '%No Jolt connections available%' or status_desc like '%Tuxedo system exception occurred during the execution%') 
            --AND soc LIKE 'FRINET%'
            and process_status ='PRSD_ERROR'
            AND not EXISTS (select * FROM service_transactions b
                            WHERE b.enter_time    > a.enter_time
                            AND a.subscriber_no = b.subscriber_no
                            AND rtrim(a.soc)     = rtrim(b.soc)
                            and rtrim(a.action_code)   = rtrim(b.action_code)
                            --and b.process_status = 'WAITING'
                            )
             
--set master_transactions that failed due to tuxedo down for re-processing if here are no new requests 
--in service_transactions for the moved records

update master_transactions a
            SET process_status='WAITING'            
            WHERE a.request_id='TRANSFER 10.08.2008'
            AND (status_desc LIKE '%No Jolt connections available%' or status_desc like '%Tuxedo system exception occurred during the execution%') 
            --AND soc LIKE 'FRINET%'
            and process_status ='PRSD_ERROR'
            AND not EXISTS (select * FROM service_transactions b
                            WHERE b.enter_time    > a.enter_time
                            AND a.subscriber_no = b.subscriber_no
                            AND rtrim(a.soc)     = rtrim(b.soc)
                            and rtrim(a.action_code)   = rtrim(b.action_code)
                            --and b.process_status = 'WAITING'
                            )
             
