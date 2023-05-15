--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records. ==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.ban_no, a.subscriber_no,
       a.adjustment_code, a.memo_text, a.user_bill_text, a.amount,
       a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.stream,
       a.request_user_id, a.effective_date
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id       IN ('OMJ 23.11.11')
    AND a.request_user_id IN ('OLJO1103')
    AND a.process_status  = 'PRSD_ERROR'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "Count", substr(COUNT(*)/60/60, 0, 6) AS "Hours, or", 
       SUBSTR(COUNT(*)/60, 0, 6) AS "Minutes"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id       IN ('LED 02.01.12')
    AND a.request_user_id IN ('LIEI1298')
  --  and a.record_creation_date > sysdate -.1
  GROUP BY a.process_status
  ORDER BY a.process_status

--
/*
UPDATE ninjadata.batch_adjustment_addition a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = null
  WHERE a.request_id      IN ('19/12/07')
    AND a.request_user_id IN ('AHV')

--
UPDATE ninjadata.batch_adjustment_addition a
  SET a.subscriber_no = '0' || a.subscriber_no
  WHERE a.request_id      IN ('19/12/07')
    AND a.request_user_id IN ('AHV')
    AND a.subscriber_no LIKE '47%'
*/

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Switch the manual/system texts for the memo. ==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_adjustment_addition a
  SET a.memo_text = a.user_bill_text, a.user_bill_text = a.memo_text
  WHERE a.request_id      IN ('19/12/07')
    AND a.request_user_id IN ('AHV')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the faiAHV records, with the (trimmed) error... -==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      IN ('NOBO2552 01.03.11','nobo2552 01.03.11')
    AND a.request_user_id IN ('nobo2552','NOBO2552')
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.status_desc

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the faiAHV records, with the (trimmed) error... -==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      IN ('MHN 28.04.2010')
    AND a.request_user_id IN ('MHN')
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.status_desc

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the faiAHV records, with the (trimmed) error... -==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban_no, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      IN ('19/12/07')
    AND a.request_user_id IN ('LED')
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.ban_no, a.status_desc

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED", MAX(a.process_time) AS "LAST_PROCESSED"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      IN ('19/12/07')
    AND a.request_user_id IN ('LED')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the sum, average, maximum and minimum values that were --==--==--==
--== successfully processed.                                        --==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM(a.amount) AS "SUM", LTRIM(TO_CHAR(AVG(a.amount), '9999999.99')) AS "AVG", 
       MAX(a.amount) AS "MAX", MIN(a.amount) AS "MIN"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      IN ('19/12/07')
    AND a.request_user_id IN ('LED')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the sum, average, maximum and minimum values that were
--== successfully processed, and display names that /even/ Marketing People
--== might, just might understand...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM(a.amount) AS "Total sum", LTRIM(TO_CHAR(AVG(a.amount), '9999999.99')) AS "Gj.snitt sum", 
       MAX(a.amount) AS "Høyest sum", MIN(a.amount) AS "Lavest sum"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      IN ('19/12/07')
    AND a.request_user_id IN ('LED')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT to_char(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      IN ('19/12/07')
    AND a.request_user_id IN ('LED')
    AND a.process_time IS NOT NULL
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that faiLED due to a 'BAN in use' error. -==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_adjustment_addition a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
  WHERE a.request_id      IN ('19/12/07')
    AND a.request_user_id IN ('LED')
    AND (a.status_desc  LIKE '%BAN%in use%'
      OR a.status_desc  LIKE 'No Jolt connections available%'
      OR a.status_desc  LIKE 'Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
    )

SELECT SUM(a.amount) AS "Total sum", TO_NUMBER(LTRIM(TO_CHAR(AVG(a.amount), '9999999,99'))) AS "Gj.snitt sum", 
       MAX(a.amount) AS "Høyest sum", MIN(a.amount) AS "Lavest sum"
  FROM ninjadata.batch_adjustment_addition a
  WHERE a.request_id      IN ('LED 02.01.12')
    AND a.request_user_id IN ('LIEI1298')
    and a.process_status='PRSD_SUCCESS'
    and a.record_creation_date > sysdate -.1
    
    select count(*) from batch_adjustment_addition
    where process_Status='WAITING'
