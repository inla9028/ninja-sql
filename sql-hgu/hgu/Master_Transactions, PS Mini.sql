--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('TD 4466')
    AND a.process_time   > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
    AND a.process_time   > TRUNC(SYSDATE)
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining records, per stream... ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
    AND a.request_time   > TRUNC(SYSDATE)
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream, action and operation... -==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.action_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
    AND a.request_time   > TRUNC(SYSDATE)
  GROUP BY a.process_status, a.action_code, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.action_code, a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status, for all records added by 'TD 4466' -==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD') AS "REQUEST_TIME", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
  GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD'), a.process_status
  ORDER BY "REQUEST_TIME", a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status, for all records processed this week by 'TD 4466' =
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD') AS "REQUEST_TIME",
       a.soc, a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
    AND a.process_time BETWEEN TRUNC(SYSDATE - 7, 'DAY') AND SYSDATE
  GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD'), a.soc, a.process_status
  ORDER BY "REQUEST_TIME", a.soc, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all future requests added by 'TD 4466' -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
    AND a.request_time > SYSDATE
  GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.process_status
  ORDER BY "REQUEST_TIME", a.process_status;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all future requests added by 'TD 4466', with details =--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME",
       a.action_code, a.soc, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
    AND a.request_time > SYSDATE
  GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.action_code, a.soc, a.process_status
  ORDER BY "REQUEST_TIME", a.action_code, a.soc, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process for each unique request id --==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.action_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.process_status = 'WAITING'
    AND a.request_time   > TRUNC(SYSDATE)
  GROUP BY a.request_id, a.action_code, a.process_status
  ORDER BY a.request_id, a.action_code, a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process, action and soc for each unique request id --==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.action_code, a.soc, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.process_status = 'WAITING'
    AND a.request_time   > TRUNC(SYSDATE)
  GROUP BY a.request_id, a.action_code, a.soc, a.process_status
  ORDER BY a.request_id, a.action_code, a.soc, a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per operation ... =--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
  GROUP BY a.action_code, a.process_status
  ORDER BY a.action_code, a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, period. -==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.201) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.201) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
    AND a.request_time BETWEEN TRUNC(SYSDATE) AND SYSDATE
  GROUP BY a.process_status
  ORDER BY a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.status_desc
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('TD 4466')
    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.status_desc, a.subscriber_no;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('TD 4466')
    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
    AND a.process_status = 'PRSD_ERROR'
--    AND a.status_desc NOT LIKE '%SOC is already on subscription%'
--  ORDER BY a.subscriber_no
  ORDER BY "STATUS_DESC", a.subscriber_no;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('TD 4466')
    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.action_code
--  ORDER BY "STATUS_DESC", a.subscriber_no

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with action code, soc & trimmed status
--== description.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, a.soc, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('TD 4466')
    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
    AND a.process_status = 'PRSD_ERROR'
--  ORDER BY a.subscriber_no, a.action_code, a.soc
  ORDER BY "STATUS_DESC", a.subscriber_no;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed for this week, with soc & trimmed status
--== description.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     IN ('TD 4466')
    AND a.request_time   BETWEEN TO_DATE('2009-06-19', 'YYYY-MM-DD') AND TO_DATE('2009-06-20', 'YYYY-MM-DD')
--    AND a.request_time   BETWEEN TRUNC(SYSDATE, 'DAY') AND SYSDATE
--    AND a.process_time   BETWEEN TRUNC(SYSDATE, 'DAY') AND SYSDATE
    AND a.process_status = 'PRSD_ERROR'
--  ORDER BY a.subscriber_no, a.action_code, a.soc
  ORDER BY "STATUS_DESC", a.subscriber_no;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run all failed records =--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
--     , a.stream = '1'
  WHERE a.request_id     IN ('TD 4466')
    AND a.process_status = 'PRSD_ERROR'
--    AND a.process_time   < SYSDATE
    AND (a.status_desc   LIKE '%No Jolt connections available%'
      OR a.status_desc   LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc   LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc   LIKE '%Please try accessing account again later%'
      OR a.status_desc   LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR a.status_desc   LIKE '%not connected to ORACLE%'
      OR a.status_desc   LIKE '%Tuxedo server%service is down%'
      OR a.status_desc   LIKE '%weblogic.common.resourcepool.ResourceLimitException%'
    );

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per hour. =--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59' AS "TIME", COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id   IN ('TD 4466')
    AND a.request_time BETWEEN TRUNC(SYSDATE) AND SYSDATE
--    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
    AND a.process_time IS NOT NULL
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24') || ':00-59'
  ORDER BY "TIME";

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "TIME", COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id   IN ('TD 4466')
    AND a.request_time BETWEEN TRUNC(SYSDATE) AND SYSDATE
--    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
    AND a.process_time IS NOT NULL
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY "TIME"

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED", MAX(a.process_time) AS "LAST_PROCESSED"
  FROM ninjadata.master_transactions a
  WHERE a.request_id IN ('TD 4466')
    AND a.process_time   > TRUNC(SYSDATE)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Execute the records that are on hold, as well as due for a specific date. =
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', 
      a.request_time   = TO_DATE('2009-03-13 00:10', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id    IN ('TD 4466')
    AND a.process_status = 'IN_PROGRESS'
    AND TO_CHAR(a.request_time, 'YYYY-MM-DD') = '2009-03-12';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of todays' processed records per minute
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninjadata.master_transactions a
      WHERE a.request_id    IN ('TD 4466')
        AND a.process_time   > TRUNC(SYSDATE)
--        AND a.process_time   > SYSDATE - (15/1440) --== Last 15 minutes
        AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
        AND a.process_status != 'WAITING'
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)


