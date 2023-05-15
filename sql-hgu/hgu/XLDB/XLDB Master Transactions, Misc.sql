SELECT a.transaction_id, a.ban, a.subscriber_no, a.process_indicator,
       a.dealer_code, a.sales_agent, a.user_memo_text,
       a.request_creation_date, a.request_status, a.request_status_date,
       a.status_desc, a.xldb_order_id, a.error_code
  FROM ninjadata.xldb_master_transactions a
  WHERE a.request_creation_date BETWEEN SYSDATE - 0.1 AND SYSDATE
    AND a.request_status NOT IN ('PRSD_SUCCESS', 'PRSD_ERROR');
  
SELECT a.transaction_id, a.ban, a.subscriber_no, a.process_indicator,
       a.dealer_code, a.sales_agent, a.user_memo_text,
       a.request_creation_date, a.request_status, a.request_status_date,
       a.status_desc, a.xldb_order_id, a.error_code
  FROM ninjadata.xldb_master_transactions a
  WHERE a.request_creation_date BETWEEN 
          TO_DATE('20070113', 'YYYYMMDD') AND
          TO_DATE('20070114', 'YYYYMMDD')


--
SELECT a.transaction_id, a.ban, a.subscriber_no, a.process_indicator,
       a.dealer_code, a.sales_agent, a.user_memo_text,
       a.request_creation_date, a.request_status, a.request_status_date,
       a.status_desc, a.xldb_order_id, a.error_code
  FROM ninjadata.xldb_master_transactions a
  WHERE a.request_status = 'CANCEL'
    AND a.request_creation_date > TO_DATE('20070113', 'YYYYMMDD')

