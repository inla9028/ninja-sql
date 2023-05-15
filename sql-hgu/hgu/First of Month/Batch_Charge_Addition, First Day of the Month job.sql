--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Check the number of 'FLXSMS' requests today, split per stream. --==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.charge_code, a.actv_reason_code, a.stream, a.process_status,
       COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.188) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.188) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
--    AND a.process_status       = 'WAITING'
    AND a.charge_code          IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
  GROUP BY a.charge_code, a.actv_reason_code, a.stream, a.process_status
  ORDER BY a.charge_code, a.actv_reason_code, TO_NUMBER(a.stream), a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Simply display the number of remaining records, per charge_code -==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.charge_code, a.actv_reason_code, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.188) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.188) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
--    AND a.process_status       = 'WAITING'
    AND a.charge_code          IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
  GROUP BY a.charge_code, a.actv_reason_code, a.process_status
  ORDER BY a.charge_code, a.actv_reason_code, a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Check the number of 'FLXSMS' requests today, totally. =--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.charge_code, a.actv_reason_code, a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE - 1)
--    AND a.process_status       = 'WAITING'
    AND a.charge_code          IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
  GROUP BY a.charge_code, a.actv_reason_code, a.process_status
  ORDER BY a.charge_code, a.actv_reason_code, a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the errors so far, today. =--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.charge_code, a.actv_reason_code, a.amount,
       a.process_time, a.process_status, a.status_desc
  FROM ninjadata.batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
    AND a.charge_code          IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
    AND a.process_status       = 'PRSD_ERROR'
  ORDER BY a.transaction_number
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the errors with trimmed status --==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_status       = 'PRSD_ERROR'
    AND a.charge_code          IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to multiple access =--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_charge_addition a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  WHERE a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_status = 'PRSD_ERROR'
    AND (
         a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
      OR a.status_desc LIKE 'Attempting to assign Default Fokus User but encountered a null value%'
      OR a.status_desc LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service%'
    )
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of incoming records per minute =--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TRUNC(a.record_creation_date, 'MI') AS "DATE", COUNT(*) AS "COUNT"
  FROM ninjadata.batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
    AND a.charge_code         IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
  GROUP BY TRUNC(a.record_creation_date, 'MI')
  ORDER BY "DATE"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute --==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TRUNC(a.process_time, 'MI') AS "DATE", COUNT(*) AS "COUNT"
  FROM ninjadata.batch_charge_addition a
  WHERE a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_time         > TRUNC(SYSDATE)
    AND a.charge_code          IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
    AND a.process_status NOT IN ('WAITING')
  GROUP BY TRUNC(a.process_time, 'MI')
  ORDER BY "DATE"
--  ORDER BY count desc, "DATE"
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
        AND a.charge_code         IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
        AND a.request_user_id      = 'KONTANT'
--      AND a.record_creation_date > TRUNC(SYSDATE)
        AND a.record_creation_date BETWEEN TO_DATE('2010-08-01 10:00', 'YYYY-MM-DD HH24:MI') AND TO_DATE('2010-08-01 22:00', 'YYYY-MM-DD HH24:MI')
        AND a.process_status       = 'PRSD_SUCCESS'
        AND a.stream              <> '1'
        AND a.process_time > (SYSDATE - (15 / 1440))
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Spread the requests from stream 1 to stream 2 - 11. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_charge_addition a
  SET a.stream = DECODE(MOD(a.subscriber_no, 10) + 2, null, 1, MOD(a.subscriber_no, 10) + 2)
  WHERE a.record_creation_date > TRUNC(SYSDATE)
    AND a.charge_code          IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
    AND a.process_status       = 'WAITING'
    AND a.stream               = '1'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Unspread the requests from stream 2-11 1 to stream 1. =--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_charge_addition a
  SET a.stream = '1'
  WHERE /*a.record_creation_date > TRUNC(SYSDATE)
    AND a.charge_code          IN ('FLXSMS', 'FLXMMS', 'FLXVEN')
    AND */a.process_status       = 'WAITING'
    AND a.stream              != '1'
;

