SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'SSP 17.01.2012'
;


--
SELECT a.process_status, a.action_code, COUNT(*) AS COUNT
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'SSP 17.01.2012'
  GROUP BY a.process_status, a.action_code
  ORDER BY a.process_status, a.action_code
;

SELECT a.subscriber_no, a.action_code, a.soc,
       SUBSTR(RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))), INSTR(a.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'SSP 17.01.2012'
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.soc, a.subscriber_no, a.action_code
;


--
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.process_time, 
       a.process_status, a.status_desc
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'SSP 17.01.2012'
    AND a.process_status = 'PRSD_ERROR'
--    AND a.status_desc LIKE 'SOC does not exist on subscription%'
--  ORDER BY a.status_desc
  ORDER BY a.subscriber_no
;

---
UPDATE ninjadata.master_transactions a
  SET a.action_code = 'ADD', a.process_time = NULL, a.process_status = 'WAITING', a.status_desc = NULL
  WHERE a.request_id     = 'SSP 17.01.2012'
    AND a.process_status = 'PRSD_ERROR'
    AND a.status_desc LIKE 'SOC does not exist on subscription%'
;
