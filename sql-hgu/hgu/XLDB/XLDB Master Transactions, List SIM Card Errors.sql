--==
--== List all orders that failed so far today due to a SIM not being available.
--==
SELECT a.transaction_id, a.ban, a.subscriber_no, a.process_indicator,
       a.dealer_code, a.sales_agent, a.user_memo_text,
       a.request_creation_date, a.request_status, a.request_status_date,
       a.status_desc, a.xldb_order_id, a.error_code
  FROM xldb_master_transactions a
  WHERE a.request_creation_date BETWEEN TRUNC(SYSDATE) AND SYSDATE
    AND a.request_status    = 'PRSD_ERROR'
    AND a.status_desc    LIKE 'SIM Card%';


--==
--== List all the SIM numbers that has failed so far today.
--==
SELECT b.equipment_number AS "SIM_NUMBER", COUNT(*) AS "COUNT"
  FROM xldb_master_transactions a, xldb_equipment_details b
  WHERE a.request_creation_date BETWEEN TRUNC(SYSDATE - 3) AND SYSDATE
    AND a.request_status    = 'PRSD_ERROR'
    AND a.status_desc    LIKE 'SIM Card%'
    AND a.transaction_id    = b.master_trx_id
  GROUP BY b.equipment_number
  ORDER BY b.equipment_number;


