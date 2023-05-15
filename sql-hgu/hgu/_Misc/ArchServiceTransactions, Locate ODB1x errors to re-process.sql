SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.success_msg_id, a.error_msg_id, a.msg_status_desc,
       a.next_action_code, a.next_action_argument
  FROM ninjadata.arch_service_transactions a
  WHERE a.soc             LIKE 'ODB%'
    AND a.action_code        = 'DELETE'
    AND a.process_status     = 'PRSD_ERROR'
    AND a.enter_time         >  TO_DATE('2009-09-01', 'YYYY-MM-DD') 
    AND a.status_desc     LIKE '%does not have the soc%'
    AND a.status_desc NOT LIKE '%does not have the soc ['|| a.soc || ']%';

--
SELECT COUNT(*)
  FROM ninjadata.arch_service_transactions a
  WHERE a.soc             LIKE 'ODB%'
    AND a.action_code        = 'DELETE'
    AND a.process_status     = 'PRSD_ERROR'
    AND a.enter_time         >  TO_DATE('2009-09-01', 'YYYY-MM-DD') 
    AND a.status_desc     LIKE '%does not have the soc%'
    AND a.status_desc NOT LIKE '%does not have the soc ['|| a.soc || ']%';

--
SELECT -1 AS "TRANS_NUMBER", a.subscriber_no, a.soc, a.action_code,
       a.enter_time, NULL AS "REQUEST_TIME", NULL AS "PROCESS_TIME", 'WAITING' AS "PROCESS_STATUS",
       NULL AS "STATUS_DESC", a.dealer_code, a.sales_agent, 4 AS "PRIORITY",
       a.success_msg_id, a.error_msg_id, a.msg_status_desc,
       a.next_action_code, a.next_action_argument
  FROM ninjadata.arch_service_transactions a
  WHERE a.soc             LIKE 'ODB%'
    AND a.action_code        = 'DELETE'
    AND a.process_status     = 'PRSD_ERROR'
    AND a.enter_time         >  TO_DATE('2009-09-01', 'YYYY-MM-DD') 
    AND a.status_desc     LIKE '%does not have the soc%'
    AND a.status_desc NOT LIKE '%does not have the soc ['|| a.soc || ']%';
