--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.257) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.257) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining records, per stream... ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.257) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.257) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining records, per stream and priority ... --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, a.priority, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.257) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.257) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream), a.priority
  ORDER BY TO_NUMBER(a.stream), a.process_status, a.priority;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of remaining records. ==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, a.priority, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.257) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.257) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, a.priority
  ORDER BY a.process_status, a.priority;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per stream, action and operation... -==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.action_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.257) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.257) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status, a.action_code, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.action_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the process status, per operation ... =--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action_code, a.process_status, a.priority, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 1.257) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.257) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
--    AND a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.action_code, a.process_status, a.priority
  ORDER BY a.action_code, a.process_status, a.priority;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.status_desc
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
--    AND a.status_desc NOT LIKE '%SOC is already on subscription%'
  ORDER BY a.subscriber_no;
--  ORDER BY SUBSTR("STATUS_DESC", 0, 40), a.subscriber_no;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.action_code;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with action code, soc & trimmed status
--== description.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, a.soc, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.action_code, a.soc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Pause all waiting requests...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status   = 'IN_PROGRESS'
  WHERE a.request_id     = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_status = 'WAITING';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Resume all paused records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status   = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  WHERE a.request_id     = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_status = 'IN_PROGRESS';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== The last 10-20 changes might be difficult due to constant BAN-locks.  =--==
--== Stop the additional master manipulators and set the stream to '1' for =--==
--== the remaining records...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.stream = '1'
  WHERE a.request_id      = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_status  = 'WAITING'
    AND a.stream         != '1';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run all failed records =--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
     , a.stream = '1'
  WHERE a.request_id      = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_status  = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%No Jolt connections available%'
      OR a.status_desc LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
      OR a.status_desc LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
    );

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT to_char(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id   = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_time IS NOT NULL
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED", MAX(a.process_time) AS "LAST_PROCESSED"
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninjadata.master_transactions a
      WHERE a.request_id      = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
        AND a.process_status != 'WAITING'
        AND a.process_time    > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

