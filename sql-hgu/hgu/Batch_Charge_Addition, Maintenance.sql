--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records. ==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.ban_no, a.subscriber_no, a.charge_code,
       a.actv_reason_code, a.amount, a.user_bill_text, a.memo_text,
       a.effective_date, a.process_status, a.process_time,
       a.status_desc, a.record_creation_date, a.request_id, a.stream,
       a.request_user_id
  FROM batch_charge_addition a
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700'
--    AND a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_status  = 'PRSD_ERROR'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all waiting records, and for which user(s). -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.charge_code, a.request_id, a.request_user_id, a.stream, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.700) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.700) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
     OR a.process_status = 'WAITING'
  GROUP BY a.charge_code, a.request_id, a.request_user_id, a.stream, a.process_status
  ORDER BY a.charge_code, a.request_id, a.request_user_id, TO_NUMBER(a.stream), a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status. The value time-value is calculated in a script further down.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) as "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.700) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.700) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM batch_charge_addition a
  WHERE a.process_status = 'WAITING'
  GROUP BY a.process_status
  ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status. The value time-value is calculated in a script further down.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) as "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.700) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.700) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM batch_charge_addition a
  WHERE a.request_user_id = 'SAMA1700' 
    AND a.request_id      IN ( 'Gjensidige' )
    AND a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY a.process_status
  ORDER BY a.process_status
;


SELECT a.request_user_id, a.request_id, a.process_status, COUNT(*) as "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.700) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.700) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM batch_charge_addition a
  WHERE a.request_user_id = 'SAMA1700' 
    AND a.request_id      IN ( 'Gjensidige' )
    AND a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY a.request_user_id, a.request_id, a.process_status
  ORDER BY a.request_user_id, a.request_id, a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.status_desc
  FROM batch_charge_addition a
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700'
    AND a.process_status = 'PRSD_ERROR';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.charge_code, a.amount 
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
  FROM batch_charge_addition a
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700'
    AND a.process_status  = 'PRSD_ERROR'
    AND a.record_creation_date > TRUNC(SYSDATE)
  ORDER BY a.subscriber_no, a.transaction_number;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban_no, a.charge_code, a.amount, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM batch_charge_addition a
  WHERE a.request_user_id = 'SAMA1700' 
    AND a.request_id      IN ( 'Gjensidige' )
    AND a.process_status  = 'PRSD_ERROR'
    AND a.record_creation_date > TRUNC(SYSDATE)
  ORDER BY a.ban_no, a.transaction_number;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban_no, a.subscriber_no, a.charge_code, a.amount, A.request_id
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
  FROM batch_charge_addition a
 WHERE a.request_user_id = 'SAMA1700' 
   AND a.request_id      IN ( 'Gjensidige' )
   AND a.process_status  = 'PRSD_ERROR'
   AND A.record_creation_date > trunc(SYSDATE)
ORDER BY a.ban_no, a.subscriber_no, a.transaction_number
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "First Processed",
       MAX(a.process_time) AS "Last Processed",
       ROUND(TO_NUMBER(MAX(a.process_time) - MIN(a.process_time)) * 24 * 60) AS "Duration (minutes)",
       TO_NUMBER(LTRIM(TO_CHAR(TO_NUMBER(MAX(a.process_time) - MIN(a.process_time)) * 24 * 60, '9999999.99'))) AS "Duration (mm.ss)"
  FROM batch_charge_addition a
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the sum, average, maximum and minimum values that were --==--==--==
--== successfully processed.                                        --==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM(a.amount) AS "SUM", TO_NUMBER(TO_CHAR(AVG(a.amount), '9999999,99')) AS "AVG", 
       MAX(a.amount) AS "MAX", MIN(a.amount) AS "MIN"
  FROM batch_charge_addition a
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700'
    AND a.process_time IS NOT NULL
    AND a.process_status  = 'PRSD_SUCCESS';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the sum, average, maximum and minimum values that were
--== successfully processed, and display names that /even/ Marketing People
--== might, just might understand...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM(a.amount) AS "Total sum", TO_NUMBER(LTRIM(TO_CHAR(AVG(a.amount), '9999999,99'))) AS "Gj.snitt sum", 
       MAX(a.amount) AS "Høyest sum", MIN(a.amount) AS "Lavest sum"
  FROM batch_charge_addition a
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700'
    AND a.process_time IS NOT NULL
    AND a.process_status  = 'PRSD_SUCCESS'
    AND a.record_creation_date > TRUNC(SYSDATE)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT to_char(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.request_user_id = 'SAMA1700' 
    AND a.request_id      IN ( 'Gjensidige' )
    AND a.process_time IS NOT NULL
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI');


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME", COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_time IS NOT NULL
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI');


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per 10 minutes. -==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUBSTR(TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), 0, 15) || '0-' || SUBSTR(TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), 15, 1) || '9' AS "PROCESS_TIME", COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_time IS NOT NULL
  GROUP BY SUBSTR(TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), 0, 15) || '0-' || SUBSTR(TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), 15, 1) || '9'
  ORDER BY SUBSTR(TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), 0, 15) || '0-' || SUBSTR(TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), 15, 1) || '9';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of inserted records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI') AS "RECORD_CREATION_DATE", COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI')
  ORDER BY TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI');


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of inserted records per 10 minutes. -==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUBSTR(TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI'), 0, 15) || '0-' || SUBSTR(TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI'), 15, 1) || '9' AS "RECORD_CREATION_DATE", COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY SUBSTR(TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI'), 0, 15) || '0-' || SUBSTR(TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI'), 15, 1) || '9'
  ORDER BY SUBSTR(TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI'), 0, 15) || '0-' || SUBSTR(TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI'), 15, 1) || '9';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_charge_addition a
      WHERE a.record_creation_date > TRUNC(SYSDATE)
        AND a.process_status      != 'WAITING'
        AND a.process_time        > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Switch the req id & user id. ==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_charge_addition a
  SET a.request_id = a.request_user_id, a.request_user_id = a.request_id
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700';
    
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to Tuxedo-problems. --==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_charge_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
--      , a.effective_date = NULL
--      , a.stream = '1'
  WHERE a.request_user_id = 'SAMA1700' 
    AND a.request_id      IN ( 'Gjensidige' )
    AND a.process_status  = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
      OR a.status_desc LIKE 'No Jolt connections available%'
      OR a.status_desc LIKE 'Could not retrieve fokus dates%'
      OR a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%in use.%'
    )
;
--
/*
UPDATE batch_charge_addition a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = null
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700';


--
UPDATE batch_charge_addition a
  SET a.subscriber_no = '0' || a.subscriber_no
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700'
    AND a.subscriber_no LIKE '47%';

--==
--== If we've accidently startyed a job where the subscribers only have 8 digits,
--== prefix all of them with '047' and reset the status.
--== 
UPDATE batch_charge_addition a
  SET a.subscriber_no = '047' || a.subscriber_no, a.process_status = 'WAITING',
      a.process_time = NULL, a.status_desc = null
  WHERE a.request_id           IN ( 'Gjensidige' )
    AND a.request_user_id      = 'SAMA1700'
    AND a.subscriber_no NOT LIKE '047%'
    AND a.process_status      != 'PRSD_SUCCESS';
*/

/*
UPDATE batch_charge_addition a
  SET a.memo_text = a.user_bill_text, a.user_bill_text = a.memo_text
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700';
*/

/*
--== Switch the 'request_id' and 'request_user_id' values...
UPDATE batch_charge_addition a
  SET a.request_id = a.request_user_id, a.request_user_id = a.request_id
  WHERE a.request_id      = 'SAMA1700'
    AND a.request_user_id IN ( 'Gjensidige' );
*/

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Pause all records for the current request... ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_charge_addition a
  SET a.process_status = 'ON_HOLD'
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700'
    AND a.process_status  = 'WAITING';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Resume all paused records for the current request... ==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_charge_addition a
  SET a.process_status = 'WAITING'
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700'
    AND a.process_status  = 'ON_HOLD';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Spread the records on multiple streams --==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_charge_addition a
  SET a.stream = DECODE(MOD(a.subscriber_no, 10) + 1, null, 1, MOD(a.subscriber_no, 10) + 1)
  WHERE a.request_id      IN ( 'Gjensidige' )
    AND a.request_user_id = 'SAMA1700'
    AND a.process_status  = 'WAITING'
;

-- In case the BAN is provided...
UPDATE batch_charge_addition a
   SET a.stream          = TO_CHAR(MOD(a.ban_no, 9) + 2)
 WHERE a.request_id      = 'SAMA1700'
   AND a.request_user_id = 'SAMA1700'
--   AND a.process_status  = 'IN_PROGRESS'
   AND a.ban_no          IS NOT NULL
;

-- In case the BAN isn't provided...
UPDATE batch_charge_addition a
   SET a.stream          = (SELECT TO_CHAR(MOD(s.customer_id, 9) + 2)
                              FROM subscriber@fokus s
                             WHERE s.subscriber_no = DECODE(SUBSTR(a.subscriber_no, 0, 1)
                                                 , 'C', a.subscriber_no
                                                 , 'G', a.subscriber_no
                                                 , 'P', a.subscriber_no
                                                 , DECODE(TO_CHAR(LENGTH(a.subscriber_no))
                                                       ,  '8', 'GSM047'
                                                       , '10', 'GSM0'
                                                       , '11', 'GSM'
                                                       , '12', 'GSM047'
                                                       , '14', 'GSM0'
                                                       , '15', 'GSM'
                                                       , '') || a.subscriber_no)
                               AND s.cnt_seq_no    = (SELECT MAX(s2.cnt_seq_no)
                                                        FROM subscriber@fokus s2
                                                       WHERE s2.subscriber_no = s.subscriber_no))
 WHERE a.request_id      = 'SAMA1700'
   AND a.request_user_id = 'SAMA1700'
--   AND a.process_status  = 'IN_PROGRESS'
   AND a.ban_no          IS NULL
;

SELECT /*+ driving_site(a)*/
       a.subscriber_no, a.customer_id, a.sub_status, a.sub_status_date
     , a.operator_id, u.user_full_name, a.dealer_code, a.sales_agent
     , a.subscriber_id, RTRIM(a.publish_level) AS "PUBLISH_LEVEL"
 FROM subscriber@fokus a, users@fokus u
WHERE a.subscriber_no = 'GSM047'||'98474145'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.operator_id   = u.user_id(+)
;

/*
       -- Given that the number from the BAN is 0-9, we add 2 to get the streams 2 - 11, leaving 1 empty
       SELECT NVL((SELECT TO_CHAR(MOD(b.ban, 9) + 2)
                     FROM billing_account@fokus b, subscriber@fokus s
                    WHERE s.subscriber_no = DECODE(SUBSTR(:new.subscriber_no, 0, 1)
                                                 , 'C', :new.subscriber_no
                                                 , 'G', :new.subscriber_no
                                                 , 'P', :new.subscriber_no
                                                 , DECODE(TO_CHAR(LENGTH(:new.subscriber_no))
                                                       ,  '8', 'GSM047'
                                                       , '10', 'GSM0'
                                                       , '11', 'GSM'
                                                       , '12', 'GSM047'
                                                       , '14', 'GSM0'
                                                       , '15', 'GSM'
                                                       , '') || :new.subscriber_no)
                      AND s.customer_id    = b.ban
                      AND s.sub_status    IN ( 'A', 'R', 'S' )), '1') -- Default to '1' in case of issues... 
         INTO :new.stream
         FROM dual;
*/




