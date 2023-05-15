--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.new_priceplan, a.new_campaign_code,
       a.new_subscription_type, a.handle_commitment, a.effective_date,
       a.dealer, a.sales_agent, a.reason_code, a.memo_text,
       a.waive_fees, a.enter_time, a.request_time, a.process_time,
       a.process_status, a.status_desc, a.priority, a.requestor_id,
       a.skip_ninja_validation, a.stream
  FROM master_chg_pp_trans a
  WHERE a.requestor_id   IN ('HGU 2022-04-07')
--    AND a.priority = 1
    AND a.process_status = 'PRSD_ERROR'
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display status of all records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 7.500) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 7.500) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_chg_pp_trans a
 WHERE a.requestor_id IN ('HGU 2022-04-07')
GROUP BY a.requestor_id, a.process_status
ORDER BY a.requestor_id, a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display status of all records, including priceplan.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.process_status, a.new_priceplan, a.new_campaign_code, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 7.500) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 7.500) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_chg_pp_trans a
 WHERE a.requestor_id IN ('HGU 2022-04-07')
GROUP BY a.requestor_id, a.process_status, a.new_priceplan, a.new_campaign_code
ORDER BY a.requestor_id, a.process_status, a.new_priceplan, a.new_campaign_code
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display status of all records, per stream.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.process_status, a.stream, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 7.500) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 7.500) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_chg_pp_trans a
 WHERE a.requestor_id IN ('HGU 2022-04-07')
GROUP BY a.requestor_id, a.process_status, a.stream
ORDER BY a.requestor_id, a.process_status, TO_NUMBER(a.stream)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display status of all records, split on requestor id and price plan.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.new_priceplan, a.stream, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 7.500) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 7.500) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_chg_pp_trans a
  WHERE a.requestor_id IN ('HGU 2022-04-07')
  GROUP BY a.requestor_id, a.new_priceplan, a.stream, a.process_status
  ORDER BY a.requestor_id, a.new_priceplan, TO_NUMBER(a.stream), a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display status of all records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 7.500) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 7.500) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_chg_pp_trans a
    WHERE a.process_status IN ('IN_PROGRESS', 'WAITING')
  GROUP BY a.requestor_id, a.process_status
  ORDER BY a.requestor_id, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining number of records, per stream.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.stream, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 7.500) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 7.500) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_chg_pp_trans a
 WHERE a.requestor_id IN ('HGU 2022-04-07')
   AND a.process_status = 'WAITING'
GROUP BY a.requestor_id, a.stream, a.process_status
ORDER BY a.requestor_id, TO_NUMBER(a.stream), a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start the processing...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_chg_pp_trans a
   SET a.process_status = 'WAITING'
--     , a.skip_ninja_validation = 'Y'
--     , a.process_time = NULL, a.status_desc = NULL
 WHERE a.requestor_id   IN ('HGU 2022-04-07')
   AND a.process_status = 'IN_PROGRESS'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start the processing, also re-process all failed records now with Ninja
--== validation turned off.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_chg_pp_trans a
   SET a.process_status        = 'WAITING'
     , a.skip_ninja_validation = 'Y'
     , a.process_time          = NULL
     , a.status_desc           = NULL
 WHERE a.requestor_id   IN ('HGU 2022-04-07')
   AND a.process_status IN ('IN_PROGRESS', 'PRSD_ERROR')
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Schedule this job to a time & date in the future...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_chg_pp_trans a
  SET A.process_status = 'WAITING'
--    , A.request_time = to_date('2009-11-04 00:05', 'YYYY-MM-DD HH24:MI')
  WHERE a.requestor_id   IN ('HGU 2022-04-07')
    AND a.process_status = 'IN_PROGRESS';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Pause the waiting records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_chg_pp_trans a
   SET a.process_status = 'IN_PROGRESS' -- , a.skip_ninja_validation = 'Y'
 WHERE a.requestor_id   IN ('HGU 2022-04-07')
   AND a.process_status = 'WAITING'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records, and the cause...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.subscriber_no, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM master_chg_pp_trans a
  WHERE a.requestor_id   IN ('HGU 2022-04-07')
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.requestor_id, a.subscriber_no, a.status_desc
--  ORDER BY a.status_desc, a.subscriber_no
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records, priceplan and the cause...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.subscriber_no, a.new_priceplan, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM master_chg_pp_trans a
  WHERE a.requestor_id   IN ('HGU 2022-04-07')
    AND a.process_status = 'PRSD_ERROR'
--  ORDER BY a.requestor_id, a.subscriber_no, a.new_priceplan, a.status_desc
  ORDER BY a.status_desc, a.subscriber_no
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records, priceplan and the cause, without prefix
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id,
       a.subscriber_no,
       a.new_priceplan,
       RTRIM (
           SUBSTR (
               SUBSTR (a.status_desc,
                       0,
                       INSTR (a.status_desc || ' [ID', ' [ID')),
               INSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   'Exception: ')))
           AS "STATUS_DESC"
  FROM master_chg_pp_trans a
 WHERE a.requestor_id IN ('HGU 2022-04-07')
   AND a.process_status = 'PRSD_ERROR'
ORDER BY "STATUS_DESC", a.requestor_id, a.subscriber_no
 ;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records, grouped by status and status-description.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.process_status,
       RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC",
       COUNT(*) AS "COUNT"
  FROM master_chg_pp_trans a
  WHERE a.requestor_id   IN ('HGU 2022-04-07')
  GROUP BY a.requestor_id, a.process_status, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')))
  ORDER BY a.requestor_id, a.process_status, "STATUS_DESC"
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "TIME", COUNT(*) AS "COUNT"
  FROM master_chg_pp_trans a
  WHERE a.requestor_id IN ('HGU 2022-04-07')
    AND a.process_time IS NOT NULL
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY "TIME";

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM master_chg_pp_trans a
      WHERE a.process_time BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
      /*WHERE a.requestor_id    IN ('HGU 2022-04-07')
        AND a.process_status != 'WAITING'
        -- AND a.process_time    > SYSDATE - (15 / 1440)*/
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to a temporary error. ==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_chg_pp_trans a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  , a.skip_ninja_validation = 'Y'
--    , a.reason_code = 'KON6'
--    , a.new_subscription_type = a.new_priceplan || 'REG1'
  WHERE a.requestor_id   IN ('HGU 2022-04-07')
    AND a.process_status = 'PRSD_ERROR'
--    AND a.reason_code = 'KON06'
    AND (
         a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
      OR a.status_desc LIKE 'Attempting to assign Default Fokus User but encountered a null value%'
      OR a.status_desc LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service%'
      OR a.status_desc LIKE '%ConcurrentModificationException%'
    )
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Update a column... Pick your poison! :-) ==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_chg_pp_trans a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
--     , a.handle_commitment = 'R' -- Replace current commitment.
--     , a.new_campaign_code = 'PSTB24OP' -- PSTB24BI isn't configured...
--     , a.new_subscription_type = a.new_subscription_type || 'REG1'
  WHERE a.requestor_id   IN ('HGU 2022-04-07')
    AND a.process_status = 'PRSD_ERROR'
    AND a.status_desc NOT LIKE 'Subscription is not Active%'
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process failed records at a certain date & time in the future... -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_chg_pp_trans a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
     , a.request_time = TO_DATE('2009-08-18 00:30', 'YYYY-MM-DD HH24:MI')
  WHERE a.requestor_id   IN ('HGU 2022-04-07')
    AND a.process_status = 'PRSD_ERROR'
--    AND a.status_desc NOT LIKE 'Subscription is not Active%'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start processing the first 100 waiting records for a future sceduled entry.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_chg_pp_trans a
  SET a.request_time = SYSDATE - (1 / 1440)
  WHERE a.requestor_id   IN ('HGU 2022-04-07')
    AND a.process_status = 'WAITING'
    AND ROWNUM           < 101
;

/*
** Spread the jobs onto mutiple streams.
*/
UPDATE master_chg_pp_trans a
   SET a.stream = MOD(ROWNUM, 10) + 1 -- Displays even 1-10
   --SET a.stream = MOD(ROWNUM, 9) + 2 -- Displays even 2-10, leaving stream 1 free
 WHERE a.requestor_id   IN ( 'HGU 2022-04-07' )
   AND a.process_status IN ( 'WAITING', 'IN_PROGRESS' )
   AND a.stream          = '1'
;

