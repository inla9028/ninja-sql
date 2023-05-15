--==
--== Display the number of records due for processing now.
--==
SELECT a.process_indicator, a.request_status, count(*) AS "COUNT"
  FROM NINJADATA.XLDB_MASTER_TRANSACTIONS A
  where a.request_status = 'WAITING'
  GROUP BY a.process_indicator, a.request_status
  ORDER BY a.process_indicator, a.request_status;

--==
--== Display when the waiting records were insterted thus requested.
--==
SELECT (TO_CHAR(a.request_creation_date, 'YYYY-MM-DD HH24') || ':00-59') AS "REQUEST_TIME", COUNT(*) AS "COUNT"
  FROM NINJADATA.XLDB_MASTER_TRANSACTIONS A
  where a.request_status = 'WAITING'
  GROUP BY (TO_CHAR(a.request_creation_date, 'YYYY-MM-DD HH24') || ':00-59')
  ORDER BY "REQUEST_TIME";

--==
--== Display the number of requests for the last few days...
--== NOTE! It's not using indexes - Use with caution!!!
--==
SELECT (TO_CHAR(a.request_creation_date, 'YYYY-MM-DD HH24') || ':00-59') AS "REQUEST_TIME", COUNT(*) AS "COUNT"
  from NINJADATA.XLDB_MASTER_TRANSACTIONS a
  where a.request_creation_date > TRUNC(sysdate - 7)
  GROUP BY (TO_CHAR(a.request_creation_date, 'YYYY-MM-DD HH24') || ':00-59')
  order by "REQUEST_TIME";

--==
--== Display the the currently waiting records...
--==
SELECT a.transaction_id, a.ban, a.subscriber_no, a.process_indicator,
       a.dealer_code, a.sales_agent, a.user_memo_text, a.request_creation_date,
       a.request_status, a.request_status_date, a.status_desc, a.xldb_order_id,
       a.error_code, a.bypass_validation
  FROM ninjadata.xldb_master_transactions a
  WHERE a.request_status = 'WAITING'
  ORDER BY a.transaction_id;


-- select a.* from ninjadata.xldb_master_transactions a;
