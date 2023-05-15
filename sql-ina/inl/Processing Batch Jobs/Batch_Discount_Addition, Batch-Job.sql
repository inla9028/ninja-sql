--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (failed) records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.ban_no, a.subscriber_no, a.discount_code,
       a.memo_text, a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id
  FROM ninjadata.batch_discount_addition a
  WHERE a.request_id     = 'TJP01.12.2009'
    AND a.process_status = 'PRSD_ERROR'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.83) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.83) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_discount_addition a
  WHERE a.request_id     = 'nobo 24/6'
  GROUP BY a.process_status
  ORDER BY a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status for all jobs added today... --==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.discount_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.83) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.83) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_discount_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY a.request_id, a.discount_code, a.process_status
  ORDER BY a.request_id, a.discount_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.status_desc
  FROM ninjadata.batch_discount_addition a
  WHERE a.request_id     = 'TJP01.12.2009'
    AND a.process_status = 'PRSD_ERROR'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_discount_addition a
  WHERE a.request_id      = 'TJP01.12.2009'
    AND a.process_status  = 'PRSD_ERROR'
--    AND a.status_desc LIKE 'Overlapping Discounts%'
  ORDER BY a.subscriber_no

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "First Processed",
       MAX(a.process_time) AS "Last Processed",
       ROUND(TO_NUMBER(MAX(a.process_time) - MIN(a.process_time)) * 24 * 60 * 60, 0) AS "Duration (seconds)"
  FROM ninjadata.batch_discount_addition a
  WHERE a.request_id     = 'TJP01.12.2009';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_discount_addition a
  WHERE a.request_id = 'TJP01.12.2009'
    AND a.process_time IS NOT NULL
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute
--== for the last 5 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.99'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.99'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_discount_addition a
      WHERE a.request_id   = 'TJP01.12.2009'
        AND a.process_time IS NOT NULL
        AND a.process_time > (SYSDATE - (5 / 1440))
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to Tuxedo-problems. --==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_discount_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
  WHERE a.request_id      = 'TJP01.12.2009'
    AND a.process_status  = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
      OR a.status_desc LIKE 'No Jolt connections available%'
      OR a.status_desc LIKE 'Could not retrieve fokus dates%'
    )

--
/*
UPDATE ninjadata.batch_discount_addition a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = null
  WHERE a.request_id     = 'TJP01.12.2009'


--
UPDATE ninjadata.batch_discount_addition a
  SET a.subscriber_no = '0' || a.subscriber_no
  WHERE a.request_id     = 'TJP01.12.2009'
    AND a.subscriber_no LIKE '47%'
*/

