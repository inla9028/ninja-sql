--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the content.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, a.action_code, a.request_id,
       a.xil_campaign_id, a.enter_time, a.process_time,
       a.process_status, a.status_desc
  FROM ninjadata.master_transactions_xil a;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the different campaigns we've ran.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD') AS "ENTER_DATE", a.soc, a.request_id,
       a.xil_campaign_id, a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions_xil a
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD'), a.soc, a.request_id, a.xil_campaign_id, a.process_status
  ORDER BY "ENTER_DATE", a.soc, a.request_id, a.xil_campaign_id, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute, today.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME", COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.105) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.105) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions_xil a
  WHERE a.process_time   > TRUNC(SYSDATE)
    AND a.process_status != 'WAITING'
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per hour, today.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59' AS "PROCESS_TIME", COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.105) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.105) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions_xil a
  WHERE a.process_time   > TRUNC(SYSDATE)
    AND a.process_status != 'WAITING'
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24')
  ORDER BY "PROCESS_TIME";

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status for today's records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, a.request_id, a.xil_campaign_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.105) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.105) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions_xil a
  WHERE a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.soc, a.request_id, a.xil_campaign_id, a.process_status
  ORDER BY a.soc, a.request_id, a.xil_campaign_id, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute today.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninjadata.master_transactions_xil a
      WHERE a.process_time   > TRUNC(SYSDATE)
        AND a.process_status != 'WAITING'
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)

