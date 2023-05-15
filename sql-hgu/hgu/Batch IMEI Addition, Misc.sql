--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all (or failed) records. ==--==--==--==--==--==--==--==--==--==--== 
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--== 
SELECT a.transaction_number, a.subscriber_no, a.imei_no, a.dealer,
       a.sales_agent, a.memo_text, a.process_status, a.process_time,
       a.status_desc, a.request_process_date, a.request_id,
       a.request_user_id
  FROM ninjadata.batch_imei_addition a
 WHERE a.request_id      IN ( 'fral11 170112' )
   AND a.request_user_id IN ( 'fral11' )
   AND a.process_status  IN ('PRSD_ERROR' )
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display waiting records. ==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_process_date, a.request_id, a.request_user_id, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_imei_addition a
 WHERE a.process_status = 'WAITING'
GROUP BY a.request_process_date, a.request_id, a.request_user_id
ORDER BY a.request_process_date, a.request_id, a.request_user_id
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records requested today... --==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_process_date, a.request_id, a.request_user_id, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_imei_addition a
 WHERE a.request_process_date > TRUNC(SYSDATE)
GROUP BY a.request_process_date, a.request_id, a.request_user_id
ORDER BY a.request_process_date, a.request_id, a.request_user_id
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status of a specific job. =--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.request_user_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.172) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.172) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_imei_addition a
 WHERE a.request_id      IN ( 'fral11 170112' )
   AND a.request_user_id IN ( 'fral11' )
GROUP BY a.request_id, a.request_user_id, a.process_status
ORDER BY a.request_id, a.request_user_id, a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the errored records. ==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.imei_no, a.process_status,
       RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_imei_addition a
 WHERE a.request_id      IN ( 'fral11 170112' )
   AND a.request_user_id IN ( 'fral11' )
   AND a.process_status   =   'PRSD_ERROR'
ORDER BY a.subscriber_no, a.imei_no
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to a 'BAN in use' error. -==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_imei_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
WHERE a.request_id     IN ('fral11 071211')
  and a.request_user_id  IN ('fral11')
  AND (a.status_desc  LIKE '%BAN%in use%'
      OR a.status_desc  LIKE 'No Jolt connections available%'
      OR a.status_desc  LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
    )
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "TIME", COUNT(*) AS "COUNT"
  FROM ninjadata.batch_imei_addition a
 WHERE a.request_id      IN ( 'fral11 170112' )
   AND a.request_user_id IN ( 'fral11' )
   AND a.process_status   != 'WAITING'
GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
ORDER BY "TIME"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED",
       MAX(a.process_time) AS "LAST_PROCESSED",
       TO_NUMBER(LTRIM(TO_CHAR((MAX(a.process_time) - MIN(a.process_time)) * (24 * 60), '9999999'))) AS "DURATION_MINUTES"
  FROM ninjadata.batch_imei_addition a
 WHERE a.request_id         IN ( 'fral11 170112' )
   AND a.request_user_id    IN ( 'fral11' )
   AND a.process_status     !=   'WAITING'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"),      '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninjadata.batch_imei_addition a
     WHERE a.request_id         IN ( 'fral11 170112' )
       AND a.request_user_id    IN ( 'fral11' )
       AND a.process_status     !=  'WAITING' 
       AND a.process_time  BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  )
;
