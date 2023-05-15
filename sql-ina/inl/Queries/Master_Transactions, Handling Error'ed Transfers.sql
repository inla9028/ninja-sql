--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List all subscriptions that failed due to Tuxedo, BAN-locks etc... --==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'JFR 21.12.2007'
    AND a.process_status = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
    )

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the  subscriptions that failed due to Tuxedo, BAN-locks etc into a 
--== temporary table... Make sure it's empty first! ;-) --==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.master_transactions_hgu_tmp (
       trans_number, subscriber_no, soc, action_code, new_soc,
       enter_time, request_time, process_time, process_status,
       status_desc, dealer_code, sales_agent, priority,
       request_id, memo_text, waive_act_fee, stream
       )
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'JFR 21.12.2007'
    AND a.process_status = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
    )

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Dispaly all other requests for subscriptions that failed due to Tuxedo, -==
--== BAN-locks etc... ==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'JFR 21.12.2007'
    AND a.process_status = 'PRSD_SUCCESS'
    AND EXISTS (
        SELECT *
          FROM ninjadata.master_transactions_hgu_tmp b
          WHERE a.subscriber_no  = b.subscriber_no
--            AND a.soc            = b.soc
)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of unique operations that failed due to BAN-locks etc...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, a.action_code, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'JFR 21.12.2007'
    AND a.process_status = 'PRSD_SUCCESS'
    AND EXISTS (
        SELECT *
          FROM ninjadata.master_transactions_hgu_tmp b
          WHERE a.subscriber_no  = b.subscriber_no
--            AND a.soc            = b.soc
)
GROUP BY a.soc, a.action_code
ORDER BY a.soc, a.action_code

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the number of operations, per soc... =--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, a.action_code, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions_hgu_tmp a
  GROUP BY a.soc, a.action_code
  ORDER BY a.soc, a.action_code
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Finally, copy the rows from the temporary table back into the master table
--== for processing. -==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.master_transactions (
       trans_number, subscriber_no, soc, action_code, new_soc,
       enter_time, request_time, process_time, process_status,
       status_desc, dealer_code, sales_agent, priority,
       request_id, memo_text, waive_act_fee, stream
       )
SELECT NULL, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       SYSDATE, SYSDATE, NULL, 'WAITING',
       NULL, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, '1'
  FROM ninjadata.master_transactions_hgu_tmp a
  WHERE a.request_id     = 'JFR 21.12.2007'
    AND a.process_status = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
    )




--==
SELECT a.soc, a.action_code,
       RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC",
       COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'JFR 21.12.2007'
    AND a.process_status = 'PRSD_ERROR'
  GROUP BY a.soc, a.action_code,
       RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID')))

