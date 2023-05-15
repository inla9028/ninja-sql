--== Display all rows transferred the last day --==--==--==--==--==--==--==--==-
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code, a.new_soc,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.request_id, a.memo_text, a.waive_act_fee, a.stream
  FROM ninjadata.master_transactions a
  WHERE a.request_id LIKE 'TRANSFER%'
    AND a.request_time > TRUNC(SYSDATE)

--== Display the number of records per stream --==--==--==--==--==--==--==--==--
SELECT a.stream, a.process_status, COUNT(*) AS count
  FROM ninjadata.master_transactions a
  WHERE a.request_id = 'TRANSFER 03.10.2007'
  GROUP BY a.stream, a.process_status
  ORDER BY TO_NUMBER(a.stream), a.process_status

--== Display the number of records waiting per stream --==--==--==--==--==--==--
SELECT a.stream, a.process_status, COUNT(*) AS count
  FROM ninjadata.master_transactions a
  WHERE /*a.request_id     = 'TRANSFER 03.10.2007'
    AND */a.process_status = 'WAITING'
  GROUP BY a.stream, a.process_status
  ORDER BY a.process_status

--== Display the records that failed (most likely due to invalid requests) --==-
SELECT *
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TRANSFER 03.10.2007'
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.soc, a.request_time, a.process_time

--== Display the records that failed not due to invalid requests --==--==--==--=
SELECT *
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TRANSFER 03.10.2007'
    AND a.process_status = 'PRSD_ERROR'
    AND a.status_desc NOT LIKE 'SOC does not exist on subscription%'
    AND a.status_desc NOT LIKE 'SOC is already on subscription%'
    AND a.status_desc NOT LIKE 'SOC is not available for add to subscription%'
  ORDER BY a.subscriber_no, a.soc, a.request_time, a.process_time

--== Re-try the records that failed due to BAN-locks --==--==--==--==--==--==--=
UPDATE ninjadata.master_transactions a
  SET a.process_time = NULL, a.process_status = 'WAITING', a.status_desc = NULL
  WHERE a.request_id     = 'TRANSFER 03.10.2007'
    AND a.process_status = 'PRSD_ERROR'
--    AND a.status_desc LIKE '%Ban is in use by an other activity%'
    AND (
         a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
    );

