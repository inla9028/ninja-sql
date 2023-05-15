--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM master_transactions a
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'WAITING';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 2.206) / 3600),   '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*)   * 2.206) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining records, per stream... ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 2.206) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 2.206) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream, action and operation... -==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.action_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 2.206) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 2.206) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status, a.action_code, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.action_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the requested execution time etc. for future requests =--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME",
       TO_NUMBER(a.stream) AS "STREAM", a.action_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 2.206) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 2.206) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
  WHERE /* a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND */ a.enter_time > TRUNC(SYSDATE - 1)
  GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), TO_NUMBER(a.stream), a.action_code, a.process_status
  ORDER BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), TO_NUMBER(a.stream), a.action_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process for each unique request id --==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.action_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 2.206) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 2.206) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
  WHERE /*a.process_status = 'WAITING'
--    AND */a.enter_time > TRUNC(SYSDATE - 1)
  GROUP BY a.request_id, a.action_code, a.process_status
  ORDER BY a.request_id, a.action_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process, action and soc for each unique request id --==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.action_code, a.soc, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 2.206) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 2.206) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.process_status = 'WAITING'
--    AND a.request_time >  LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
  GROUP BY a.request_id, a.action_code, a.soc, a.process_status
  ORDER BY a.request_id, a.action_code, a.soc, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per operation ... =--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action_code, a.soc, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 2.206) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 2.206) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.action_code, a.soc, a.process_status
  ORDER BY a.soc, a.action_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status of records added the last X day(s).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action_code, a.soc, a.request_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 2.206) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 2.206) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
  WHERE a.enter_time > TRUNC(SYSDATE - 1)
  GROUP BY a.action_code, a.soc, a.request_id, a.process_status
  ORDER BY a.action_code, a.soc, a.request_id, a.process_status
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, period. -==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 2.206) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 2.206) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status
  ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.status_desc
  FROM master_transactions a
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM master_transactions a
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
--    AND a.status_desc NOT LIKE '%SOC is already on subscription%'
--  ORDER BY a.subscriber_no
  ORDER BY "STATUS_DESC", a.subscriber_no;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM master_transactions a
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
--  ORDER BY a.subscriber_no, a.action_code;
--  ORDER BY "STATUS_DESC", a.subscriber_no;
  ORDER BY a.soc, a.subscriber_no, a.action_code;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with only the textual error.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, a.soc,
       -- RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
       SUBSTR(RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))), INSTR(a.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM master_transactions a
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
--    AND a.soc        NOT IN ( 'CON03' )
--  ORDER BY a.subscriber_no, a.action_code;
  ORDER BY "STATUS_DESC", a.subscriber_no;
--  ORDER BY a.soc, a.subscriber_no, a.action_code;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display an overview of the errors.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC", COUNT(*) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
   AND a.process_status = 'PRSD_ERROR'
   AND a.enter_time > TRUNC(SYSDATE - 3)
--   AND a.request_time      >= TO_DATE('2012-07-04 21:10', 'YYYY-MM-DD HH24:MI')
--   AND a.process_time BETWEEN TO_DATE('2012-07-04 21:09', 'YYYY-MM-DD HH24:MI') AND SYSDATE
GROUP BY a.soc, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')))
ORDER BY a.soc, "COUNT" DESC, "STATUS_DESC";

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with action code, soc & trimmed status
--== description.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, a.soc
     , RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM master_transactions a
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
--  ORDER BY a.subscriber_no, a.action_code, a.soc
  ORDER BY "STATUS_DESC", a.soc, a.subscriber_no
;
  
SELECT a.subscriber_no, a.action_code, a.soc
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (a.status_desc,
                               0,
                               INSTR (a.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM master_transactions a
 WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--   AND a.enter_time     > TRUNC(SYSDATE)
   AND a.process_status = 'PRSD_ERROR'
ORDER BY "STATUS_DESC", a.soc, a.subscriber_no
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Pause all waiting requests...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
   SET a.process_status = 'IN_PROGRESS'
 WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
   AND a.process_status = 'WAITING'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Resume all paused records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
--      , a.action_code = 'ADD'
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.process_status = 'IN_PROGRESS';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Set the execution time for these operations (that hasn't been run yet).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET a.request_time = TO_DATE('2011-02-02 01:30', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id         IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.soc                IN ('MCTBFREE')
    AND a.process_status NOT IN ('PRSD_ERROR', 'PRSD_SUCCESS');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run records that failed as the soc already exists (thus can't be added).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL,
      a.action_code = 'MODIFY' -- , a.stream = '1'
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.action_code    = 'ADD'
    AND a.process_status = 'PRSD_ERROR'
    AND a.status_desc LIKE '%SocException: SOC is already on subscription%';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run records that failed as the soc didn't exists (thus can't be modified).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL,
      a.action_code = 'ADD' -- , a.stream = '1'
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.action_code    = 'MODIFY'
    AND a.process_status = 'PRSD_ERROR'
    AND a.status_desc LIKE '%SocException: SOC does not exist on subscription%';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run all failed records =--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
     , a.stream = '1'
--     , a.stream = LTRIM(TO_CHAR(1 + TO_NUMBER(a.stream) / 2, '9')) -- Halfen the stream...
  WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.process_status = 'PRSD_ERROR'
    AND (a.status_desc    LIKE '%No Jolt connections available%'
      OR a.status_desc    LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc    LIKE '%BanInUseException%'
      OR a.status_desc    LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc    LIKE '%Please try accessing account again later%'
      OR a.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR a.status_desc    LIKE '%not connected to ORACLE%'
      OR a.status_desc    LIKE '%Tuxedo server%service is down%'
      OR a.status_desc    LIKE '%weblogic.common.resourcepool.ResourceLimitException%'
      OR a.status_desc    LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
      OR a.status_desc    LIKE '%java.util.ConcurrentModificationException%'
      OR a.status_desc    LIKE '%Mandatory value%'
    )
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "TIME", COUNT(*) AS "COUNT"
  FROM master_transactions a
  WHERE a.request_id   IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.process_time IS NOT NULL
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY "TIME";

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED", MAX(a.process_time) AS "LAST_PROCESSED"
  FROM master_transactions a
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' );

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999,999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999,999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM master_transactions a
      WHERE a.request_id     IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
        AND a.process_status != 'WAITING'
        AND a.process_time   BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Change all GSM* subscriptions into CDA*. ==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET a.subscriber_no = 'CDA' || SUBSTR(a.subscriber_no, 4)
      , a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.process_status = 'PRSD_ERROR'
    AND a.subscriber_no LIKE 'GSM047%';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Properly (re)format the GSM numbers. ==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET 
      -- a.subscriber_no = 'CDA' || SUBSTR(a.subscriber_no, 4)
--      A.subscriber_no = 'GSM0' || substr(A.subscriber_no, 4)
      a.subscriber_no = 'GSM047' || a.subscriber_no
--      , a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
--    AND a.process_status = 'PRSD_ERROR'
    --AND a.subscriber_no LIKE 'GSM047%';
--    AND A.subscriber_no LIKE 'GSM47%'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Spread the records (marked as 'IN_PROGRESS') on multiple streams ==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET a.stream = DECODE(MOD(SUBSTR(a.subscriber_no, 4), 10) + 1, null, 1, MOD(SUBSTR(a.subscriber_no, 4), 10) + 1)
--    , a.request_time = TO_DATE('2008-11-12 00:30', 'YYYY-MM-DD HH24:MI')
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.process_status = 'WAITING';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== In case one already has spread the load on multiple streams, but forgot -==
--== to start the processes, one could re-spread them again, and give it a   -==
--== second try..                                                            -==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
   --SET a.stream = MOD(SUBSTR(a.subscriber_no, 8, 3), 9) + 2 -- The old MWH way
   SET a.stream = MOD(ROWNUM, 10) + 1 -- Displays even 1-10
   --SET a.stream = MOD(ROWNUM, 9) + 2 -- Displays even 2-10, leaving stream 1 free
 WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
   AND a.process_status = 'IN_PROGRESS'
   AND a.stream         = '1'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Update the stream based on the BAN number, in this case 2 - 10 to leave 1 free
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions mt
   SET mt.stream = NVL((SELECT to_char(MOD(b.ban, 9) + 2)
                          FROM billing_account@fokus b, subscriber@fokus s
                         WHERE s.subscriber_no IN (mt.subscriber_no)
                           AND s.customer_id = b.ban
                           AND s.sub_status in ('A', 'R', 'S')), '99')
 WHERE mt.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== The last 10-20 changes might be difficult due to constant BAN-locks.  =--==
--== Stop the additional master manipulators and set the stream to '1' for =--==
--== the remaining records...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET a.stream = '1'
  WHERE a.request_id IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.process_status = 'WAITING'
    AND a.stream        != '1';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Set a dealer code and sales agent...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_transactions a
  SET a.dealer_code = 'KSSK', a.sales_agent = 'NVE'
--    , a.request_id  = 'STM 2021-03-09', 'STM 2021-03-10'
  WHERE a.request_id           IN ( 'STM 2021-03-09', 'STM 2021-03-10' )
    AND a.process_status          = 'WAITING'
    AND NVL(a.dealer_code, 'N/A') = 'N/A'
    AND NVL(a.sales_agent, 'N/A') = 'N/A'
;


