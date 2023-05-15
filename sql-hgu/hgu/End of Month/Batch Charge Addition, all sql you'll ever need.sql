--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
-- Display the status of the jobs, sorted by stream, for the last day. =--==--==
-- The 'average seconds per record' value is calculated further down...... =--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.stream, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.175) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.175) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.record_creation_date > TRUNC(SYSDATE, 'MON')
--  AND a.record_creation_date BETWEEN TO_DATE('2010-05-01 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2010-05-01 22:00', 'YYYY-MM-DD HH24:MI')
  GROUP BY a.stream, a.process_status
  ORDER BY TO_NUMBER(a.stream), a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
-- Display the status of the jobs, not split on streams, for the last day. =--==
-- The 'average seconds per record' value is calculated further down...... =--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.175) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.175) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.record_creation_date > TRUNC(SYSDATE, 'MON')
--  AND a.record_creation_date BETWEEN TO_DATE('2012-03-23 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2012-04-11 22:00', 'YYYY-MM-DD HH24:MI')
  GROUP BY process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to multiple BAN access =--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_charge_addition a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
-- select * from ninjadata.batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE, 'MON')
--  AND a.record_creation_date BETWEEN TO_DATE('2010-05-01 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2010-05-01 22:00', 'YYYY-MM-DD HH24:MI')
    AND a.process_status = 'PRSD_ERROR'
    AND (
         a.status_desc LIKE '%IllegalChargeException%future dates not allowed%BatchChargeAddition%'
    )
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed items per minute ==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "TIME", COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
--  AND a.record_creation_date > TRUNC(SYSDATE, 'MON')
    AND a.record_creation_date BETWEEN TO_DATE('2012-03-23 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2012-04-11 22:00', 'YYYY-MM-DD HH24:MI')
    AND a.process_status       = 'PRSD_SUCCESS'
    AND a.stream              <> '1'
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
--  ORDER BY "COUNT"
  ORDER BY "TIME"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed items per hour --==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59' AS "TIME", COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.record_creation_date > TRUNC(SYSDATE, 'MON')
--  AND a.record_creation_date BETWEEN TO_DATE('2010-05-01 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2010-05-01 22:00', 'YYYY-MM-DD HH24:MI')
    AND a.process_status       = 'PRSD_SUCCESS'
    AND a.stream              <> '1'
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59'
  ORDER BY "TIME"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute
--== for the last 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_charge_addition a
      WHERE a.actv_reason_code     = 'PRPCHG'
        AND a.charge_code          = 'FLEX'
        AND a.request_user_id      = 'KONTANT'
        AND a.record_creation_date > TRUNC(SYSDATE, 'MON')
        --  AND a.record_creation_date BETWEEN TO_DATE('2010-05-01 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2010-05-01 22:00', 'YYYY-MM-DD HH24:MI')
        AND a.process_status       = 'PRSD_SUCCESS'
        AND a.stream              <> '1'
        AND a.process_time > (SYSDATE - (15 / 1440))
--          AND a.process_time BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
--        AND a.process_time > TRUNC(SYSDATE, 'MON')
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description =--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.status_desc
  FROM ninjadata.batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.stream              <> '1'
    AND a.record_creation_date > TRUNC(SYSDATE, 'MON')
--  AND a.record_creation_date BETWEEN TO_DATE('2010-05-01 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2010-05-01 22:00', 'YYYY-MM-DD HH24:MI')
    AND a.process_status       = 'PRSD_ERROR'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description ==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.stream              <> '1'
    AND a.record_creation_date > TRUNC(SYSDATE, 'MON')
--  AND a.record_creation_date BETWEEN TO_DATE('2010-05-01 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2010-05-01 22:00', 'YYYY-MM-DD HH24:MI')
    AND a.process_status       = 'PRSD_ERROR'
  ORDER BY a.subscriber_no
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
-- Display the status of the jobs, split on the charged amount
-- (to see the YoungTalk+ subscriptions, which are charged 400)...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, a.amount, COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.record_creation_date > TRUNC(SYSDATE, 'MON')
--    AND a.record_creation_date BETWEEN TO_DATE('2010-05-01 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2010-05-01 22:00', 'YYYY-MM-DD HH24:MI')
--    AND a.process_time         > TRUNC(SYSDATE)
    AND a.stream              <> '1'
GROUP BY process_status, a.amount
ORDER BY process_status, a.amount
;


--==
--== 2012-04-11 :: Display the subscribers that were charged within a period of time.
--==
SELECT a.ban_no, a.subscriber_no, a.charge_code, a.actv_reason_code, a.amount,
       a.user_bill_text, a.memo_text, a.process_time, a.status_desc
  FROM ninjadata.batch_charge_addition a
 WHERE a.actv_reason_code     = 'PRPCHG'
   AND a.charge_code          = 'FLEX'
   AND a.request_user_id      = 'KONTANT'
   AND a.process_time   BETWEEN TO_DATE('2012-04-10 15:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2012-04-10 17:00', 'YYYY-MM-DD HH24:MI')
   AND a.process_status       = 'PRSD_SUCCESS'
;
