--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display "all" rows...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.ban_no, a.memo_text,
       a.memo_sys_text, a.memo_type, a.sys_mem_append, a.enter_time,
       a.request_time, a.process_time, a.process_status, a.status_desc,
       a.priority, a.exclude_ind
  FROM master_memo_transactions a
 WHERE a.process_status = 'WAITING'
-- WHERE a.process_status != 'WAITING'
-- WHERE a.process_status = 'PRSD_ERROR'
-- WHERE a.process_status = 'EXCLUDED'
   AND a.process_time   > SYSDATE - (1 / 3)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status for waiting records.
--== The processing speed is calculated elsewhere.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, a.priority, a.exclude_ind, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.257) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.257) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM master_memo_transactions a
 WHERE a.process_status = 'WAITING'
GROUP BY a.process_status, a.priority, a.exclude_ind
ORDER BY a.process_status, a.priority, a.exclude_ind
;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status for the entire table.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, a.exclude_ind, COUNT (*) AS "COUNT"
  FROM master_memo_transactions a
GROUP BY a.process_status, a.exclude_ind
ORDER BY a.process_status, a.exclude_ind
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status for the entire table, including the status desc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, a.exclude_ind, a.status_desc, COUNT(*) AS "COUNT"
  FROM master_memo_transactions a
GROUP BY a.process_status, a.exclude_ind, a.status_desc
ORDER BY a.process_status, a.exclude_ind, a.status_desc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status for the last 6 hours.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, a.exclude_ind, a.status_desc, COUNT(*) AS "COUNT"
  FROM master_memo_transactions a
 WHERE a.process_time > (SYSDATE - (1 / 3))
GROUP BY a.process_status, a.exclude_ind, a.status_desc
ORDER BY a.process_status, a.exclude_ind, a.status_desc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status per day for the entire table.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD') AS "ENTER_TIME", a.process_status, a.exclude_ind, COUNT(*) AS "COUNT"
  FROM master_memo_transactions a
GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD'), a.process_status, a.exclude_ind
ORDER BY "ENTER_TIME", a.process_status, a.exclude_ind
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display number of processed rows per minute for the current day.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME",
       a.process_status, a.exclude_ind, COUNT(*) AS "COUNT"
  FROM master_memo_transactions a
 WHERE a.process_status != 'WAITING'
   AND a.process_time    > TRUNC(SYSDATE)
GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), a.process_status, a.exclude_ind
ORDER BY "PROCESS_TIME", a.process_status, a.exclude_ind
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display number of added records per day for the last week (or similar).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD') AS "ENTER_TIME",
       a.process_status, a.exclude_ind, COUNT(*) AS "COUNT"
  FROM master_memo_transactions a
 WHERE 1 = 1
   -- AND a.process_status != 'WAITING'
   AND a.enter_time      > TRUNC(SYSDATE - 7)
GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD'), a.process_status, a.exclude_ind
ORDER BY TO_CHAR(a.enter_time, 'YYYY-MM-DD'), a.process_status, a.exclude_ind
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of _processed_ records per minute
--== for the last 15 minutes (ignoring records excluded by trigger)...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM master_memo_transactions a
     WHERE a.process_time BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
       AND a.process_status    != 'EXCLUDED'
--       AND a.status_desc NOT LIKE 'Excluded by Trigger%'
    GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  )
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of _processed_ records per minute
--== for the last 6 hours (ignoring records excluded by trigger)...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM master_memo_transactions a
     WHERE a.process_time       > (SYSDATE - (1 / 3))
       AND a.process_status    != 'EXCLUDED'
--       AND a.status_desc NOT LIKE 'Excluded by Trigger%'
    GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  )
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display when the records currently waiting were added.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME",
       COUNT(*) AS "COUNT"
  FROM master_memo_transactions a
 WHERE a.process_status = 'WAITING'
GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI')
ORDER BY "REQUEST_TIME"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to a temporary error.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE master_memo_transactions a
   SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
 WHERE a.process_status = 'PRSD_ERROR'
   AND (
        a.status_desc LIKE '%Could not retrieve fokus dates%'
     OR a.status_desc LIKE '%No Jolt connections available%'
     OR a.status_desc LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
   )
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the messages that should be excluded...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.msg_id, a.language_code, a.from_ctn, a.msg_text
  FROM sms_messages a
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the average time (in seconds) a record had to wait after insert 
--== until it was processed.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   "ENTER_TIME",
         TO_NUMBER (LTRIM (TO_CHAR (AVG ("DURATION"), '9999999.99')))     AS "AVG_DURATION"
    FROM (SELECT TO_CHAR (a.enter_time, 'YYYY-MM-DD HH24') || ':00-59'    AS "ENTER_TIME",
                 24 * 60 * 60 * (a.process_time - a.enter_time)           AS "DURATION"
            FROM master_memo_transactions a
           --WHERE a.enter_time > TRUNC(SYSDATE - 1/2, 'HH') -- Last 24 hours.
           WHERE a.enter_time > TRUNC(SYSDATE - 10)
           --WHERE a.enter_time > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
             AND a.process_status != 'WAITING'
         )
GROUP BY "ENTER_TIME"
ORDER BY "ENTER_TIME"
;

