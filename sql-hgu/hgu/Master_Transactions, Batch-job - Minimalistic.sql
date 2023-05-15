SELECT a.request_id, a.action_code, a.soc, DECODE(a.stream, '1', '1', '99', '99', '2-N') AS "STREAM", a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.240) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.240) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
 WHERE a.request_id IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
--   AND a.action_code   = 'ADD'
GROUP BY a.request_id, a.action_code, a.soc, DECODE(a.stream, '1', '1', '99', '99', '2-N'),  a.process_status
ORDER BY a.request_id, a.action_code, a.soc, "STREAM", a.process_status
;

SELECT a.request_id, a.action_code, a.soc, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.240) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.240) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
 WHERE a.request_id IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
--   AND a.action_code   = 'ADD'
GROUP BY a.request_id, a.action_code, a.soc, a.process_status
ORDER BY a.request_id, a.action_code, a.soc, a.process_status
;

SELECT a.request_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.240) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.240) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM master_transactions a
 WHERE a.request_id IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
--   AND a.action_code   = 'ADD'
GROUP BY a.request_id, a.process_status
ORDER BY a.request_id, a.process_status
;

SELECT a.subscriber_no, a.action_code, a.soc, a.new_soc,
       REPLACE (
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
 WHERE a.request_id     IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
   AND a.process_status = 'PRSD_ERROR'
--   AND a.action_code    = 'ADD'
ORDER BY "STATUS_DESC", a.subscriber_no
;

SELECT a.soc
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
     , COUNT(*) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id     IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
   AND a.process_status = 'PRSD_ERROR'
   AND a.enter_time > TRUNC(SYSDATE - 7)
--   AND a.request_time      >= TO_DATE('2012-07-04 21:10', 'YYYY-MM-DD HH24:MI')
--   AND a.process_time BETWEEN TO_DATE('2012-07-04 21:09', 'YYYY-MM-DD HH24:MI') AND SYSDATE
GROUP BY a.soc, REPLACE (
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
ORDER BY a.soc, "COUNT" DESC, "STATUS_DESC"
;

UPDATE master_transactions a
   SET A.process_status = 'WAITING', A.process_time = NULL, A.status_desc = NULL
--     , a.stream = '1'
--     , a.stream = MOD(ROWNUM, 10) + 1 -- Displays even 1-10
--     , a.stream = MOD(ROWNUM, 9) + 2 -- Displays even 2-10, leaving stream 1 free
 WHERE a.request_id     IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
   AND a.process_status = 'PRSD_ERROR'
   AND (a.status_desc    LIKE '%No Jolt connections available%'
     OR a.status_desc    LIKE '%Could not retrieve fokus dates%'
     OR a.status_desc    LIKE '%BanInUseException%'
     OR a.status_desc    LIKE '%Ban has been updated since last retrieved%'
     OR a.status_desc    LIKE '%Records have been updated since last retrieve%'
     OR a.status_desc    LIKE '%Please try accessing account again later%'
     OR a.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
     OR a.status_desc    LIKE '%not connected to ORACLE%'
     OR a.status_desc    LIKE '%Tuxedo server%service is down%'
     OR a.status_desc    LIKE '%weblogic.common.resourcepool.ResourceLimitException%'
     OR a.status_desc    LIKE '%Tuxedo service did not terminate successfully%'
     OR a.status_desc    LIKE '%java.lang.NullPointerException%'
   )
;

--UPDATE master_transactions a
--   SET a.stream = MOD(ROWNUM, 10) + 1 -- Displays even 1-10
----   SET a.stream = MOD(ROWNUM, 9) + 2 -- Displays even 2-10, leaving stream 1 free
-- WHERE a.request_id     IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
--   AND a.process_status = 'WAITING'
--;

UPDATE master_transactions mt
   SET mt.stream = NVL((SELECT TO_CHAR(MOD(s.customer_id, 9) + 2) -- Stream 2 - 10
                          FROM subscriber@fokus s
                         WHERE s.subscriber_no IN (mt.subscriber_no)
                           AND s.sub_status    IN ('A', 'R', 'S')), '99')
 WHERE mt.request_id     IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
   AND mt.process_status IN ( 'WAITING', 'ON_HOLD' )
;

UPDATE master_transactions a
   SET A.process_status = 'WAITING'
 WHERE A.request_id    IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
   AND A.process_status = 'ON_HOLD'
;

SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"),      '9999999,999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999,999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM master_transactions a
     WHERE a.request_id     IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
       AND a.process_status != 'WAITING'
       AND a.process_time   BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
     GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
     ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

SELECT SUM("COUNT")      AS "PROCESSED_RECORDS",
       AVG("COUNT")      AS "AVG_PER_MIN",
       60 / AVG("COUNT") AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM master_transactions a
--     WHERE a.process_time BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
     WHERE a.request_id        IN ( 'eb0fcf2c-6895-442b-9278-a28dab122111' )
       AND a.process_status    IN ('PRSD_SUCCESS', 'PRSD_ERROR')
--       AND a.process_time BETWEEN TRUNC(SYSDATE) AND SYSDATE
       AND a.process_time      IS NOT NULL
       AND a.process_time      > SYSDATE - 1/(4*24)
    GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
    ORDER BY to_char(A.process_time, 'YYYY-MM-DD HH24:MI')
);