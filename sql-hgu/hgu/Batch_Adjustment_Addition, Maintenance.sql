--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records. ==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.ban_no, a.subscriber_no,
       a.adjustment_code, a.memo_text, a.user_bill_text, a.amount,
       a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.stream,
       a.request_user_id, a.effective_date
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.process_status  = 'PRSD_ERROR';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status. The value time-value is calculated in a script further down.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.request_user_id, a.adjustment_code, a.process_status, COUNT(*) as "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 1.075) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.075) / 60, 60), '9999999'))) || ' min' as "QUEUE"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
--    AND a.process_status   = 'WAITING'
  GROUP BY a.request_id, a.request_user_id, a.adjustment_code, a.process_status
  ORDER BY a.request_id, a.request_user_id, a.adjustment_code, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status. The value time-value is calculated in a script further down.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.request_user_id, a.adjustment_code, a.process_status, COUNT(*) as "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 1.075) /    3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 1.075) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_adjustment_addition a
 WHERE a.process_status       = 'WAITING'
    OR a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY a.request_id, a.request_user_id, a.adjustment_code, a.process_status
  ORDER BY a.request_id, a.request_user_id, a.adjustment_code, a.process_status;

--
/*
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-run all failed jobs...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_adjustment_addition a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = null
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.process_status  = 'PRSD_ERROR';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== In case the numbers were formatted as '4798765432', add the leading '0'
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_adjustment_addition a
  SET a.subscriber_no = '0' || a.subscriber_no
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.subscriber_no LIKE '47%';
*/

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Switch the manual/system texts for the memo. ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_adjustment_addition a
  SET a.memo_text = a.user_bill_text, a.user_bill_text = a.memo_text
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error... -==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.status_desc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error... -==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
-- SELECT a.request_id, a.request_user_id, a.subscriber_no, a.adjustment_code, a.amount, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
SELECT a.request_id, a.request_user_id, a.subscriber_no, a.adjustment_code, a.amount, SUBSTR(RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))), INSTR(a.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.adjustment_code, a.amount, a.status_desc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error... -==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.ban_no, a.status_desc;

SELECT A.ban_no, A.subscriber_no, A.amount
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   INSTR (                       SUBSTR (a.status_desc,
                               0,
                               INSTR (a.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND A.process_status  = 'PRSD_ERROR'
ORDER BY A.ban_no, A.status_desc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "First Processed",
       MAX(a.process_time) AS "Last Processed",
       TO_NUMBER(LTRIM(TO_CHAR(TO_NUMBER(MAX(a.process_time) - MIN(a.process_time)) * 24 * 60, '9999999.99'))) AS "Duration (mm.ss)"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the sum, average, maximum and minimum values that were --==--==--==
--== successfully processed.                                        --==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM(a.amount) AS "SUM", TO_NUMBER(LTRIM(TO_CHAR(AVG(a.amount), '9999999.99'))) AS "AVG", 
       MAX(a.amount) AS "MAX", MIN(a.amount) AS "MIN"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the sum, average, maximum and minimum values that were
--== successfully processed, and display names that /even/ Marketing People
--== might, just might understand...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM(a.amount) AS "Total sum", TO_NUMBER(LTRIM(TO_CHAR(AVG(a.amount), '9999999.99'))) AS "Gj.snitt sum", 
       MAX(a.amount) AS "H�yest sum", MIN(a.amount) AS "Lavest sum"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
--    AND a.adjustment_code = 'KORFAK'
    AND a.process_status   = 'PRSD_SUCCESS';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the sum, average, maximum and minimum values that were
--== successfully processed, for each unique REQUEST_ID.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id AS "Req. ID", SUM(a.amount) AS "Total sum", 
       TO_NUMBER(LTRIM(TO_CHAR(AVG(a.amount), '9999999.99'))) AS "Gj.snitt sum", 
       MAX(a.amount) AS "H�yest sum", MIN(a.amount) AS "Lavest sum"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.process_status   = 'PRSD_SUCCESS'
  GROUP BY a.request_id
  ORDER BY a.request_id;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM batch_adjustment_addition a
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.process_time IS NOT NULL
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_adjustment_addition a
/*      WHERE a.request_id      IN ('TRKA0776 19.05.2022')
        AND a.request_user_id IN ('TRKA0776')
        AND a.process_status  != 'WAITING'*/
      WHERE a.record_creation_date > TRUNC(SYSDATE)
        AND a.process_status      != 'WAITING'
        AND a.process_time        > SYSDATE - (15 / 1440)  
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to a 'BAN in use' error. -==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_adjustment_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND (a.status_desc    LIKE '%No Jolt connections available%'
      OR a.status_desc    LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc    LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc    LIKE '%Please try accessing account again later%'
      OR a.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR a.status_desc    LIKE '%not connected to ORACLE%'
      OR a.status_desc    LIKE '%Tuxedo server%service is down%'
      OR a.status_desc    LIKE '%weblogic.common.resourcepool.ResourceLimitException%')
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== In case the numbers were formatted as '4798765432', add the leading '0'
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_adjustment_addition a
  SET a.subscriber_no = '0' || a.subscriber_no
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.subscriber_no LIKE '47%';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Remove the 'user bill text' in case it's not allowed in Fokus. --==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_adjustment_addition a
  SET a.user_bill_text = NULL, a.process_status = 'WAITING', 
      a.status_desc = NULL, a.process_time = NULL
  WHERE a.request_id      IN ('TRKA0776 19.05.2022')
    AND a.request_user_id IN ('TRKA0776')
    AND a.process_status   = 'PRSD_ERROR'
    AND a.status_desc   LIKE 'Unable to make adjustment, user bill text was specified%';


