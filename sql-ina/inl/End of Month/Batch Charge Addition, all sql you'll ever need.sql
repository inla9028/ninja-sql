--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
-- Display the status of the jobs, sorted by stream, for the last day. =--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.stream, a.process_status, COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY a.stream, a.process_status
  ORDER BY TO_NUMBER(a.stream), a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
-- Display the status of the jobs, not split on streams, for the last day. =--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.record_creation_date > TRUNC(SYSDATE)
  GROUP BY process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to multiple BAN access =--==--==--==--==
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

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed items per minute ==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT to_char(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
	AND a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_status       = 'PRSD_SUCCESS'
    AND a.stream              <> '1'
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI')
  order by count
  
  SELECT to_char(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
	AND a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_status       = 'PRSD_SUCCESS'
    AND a.stream              <> '1'
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI')
  order by time

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed items per hour --==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT to_char(a.process_time, 'YYYY-MM-DD HH24') AS time, COUNT(*) AS "COUNT"
  FROM batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
	AND a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_status       = 'PRSD_SUCCESS'
    AND a.stream              <> '1'
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with complete status description =--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.status_desc
  FROM ninjadata.batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.stream              <> '1'
	AND a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_status       = 'PRSD_ERROR'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description ==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
	AND a.record_creation_date > TRUNC(SYSDATE)
    AND a.process_status       = 'PRSD_ERROR'
    AND a.stream              <> '1'
  ORDER BY a.subscriber_no

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==Get count from temporary monthly refill table, populated by Kontant --==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
select count(*) from monthly_refill_charges


SELECT *
  FROM ninjadata.batch_charge_addition a
  WHERE a.actv_reason_code     = 'PRPCHG'
    AND a.charge_code          = 'FLEX'
    AND a.request_user_id      = 'KONTANT'
    AND a.stream              <> '1'
	AND a.record_creation_date > TRUNC(SYSDATE-1)
	order by a.process_time

