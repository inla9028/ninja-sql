--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records... --==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.dealer_code, a.sales_agent, a.priceplan,
       a.campaign, a.handle_commitment, a.reason_code, a.memo_text,
       a.waive_fees, a.sub_tb_soc, a.sub_vpn_code, a.sub_cug_code,
       a.enter_time, a.process_time, a.process_status, a.processed_type,
       a.status_desc, a.requestor_id, a.request_time,
       a.process_description
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id   = 'AFL 17.01.2017'
    AND a.process_status = 'PRSD_ERROR'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display status of all records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 2.368) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 2.368) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id = 'AFL 17.01.2017'
  GROUP BY a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninjadata.tb_processing_trans a
      WHERE a.requestor_id    = 'AFL 17.01.2017'
        AND a.process_status != 'WAITING'
--        AND a.process_time    > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records currently marked 'IN_PROGRESS' or 'WAITING' -==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.requestor_id, a.priceplan, a.sub_tb_soc, a.sub_vpn_code, a.sub_cug_code,
       a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.tb_processing_trans a
  WHERE a.process_status IN ('IN_PROGRESS', 'WAITING')
  GROUP BY a.requestor_id, a.priceplan, a.sub_tb_soc, a.sub_vpn_code, a.sub_cug_code, a.process_status
  ORDER BY a.requestor_id, a.priceplan, a.sub_tb_soc, a.sub_vpn_code, a.sub_cug_code, a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start the processing... -==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.tb_processing_trans a
  SET a.process_status = 'WAITING'
  WHERE a.requestor_id   = 'AFL 17.01.2017'
    AND a.process_status = 'IN_PROGRESS'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Stop/pause the processing... ==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.tb_processing_trans a
  SET a.process_status = 'IN_PROGRESS'
  WHERE a.requestor_id   = 'AFL 17.01.2017'
    AND a.process_status = 'WAITING'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records, and the cause...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id   = 'AFL 17.01.2017'
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.status_desc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records, and the cause; ordering by the error.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.priceplan, a.sub_tb_soc,
       RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id   = 'AFL 17.01.2017'
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY "STATUS_DESC", a.subscriber_no
--  ORDER BY a.subscriber_no
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED", MAX(a.process_time) AS "LAST_PROCESSED"
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id = 'AFL 17.01.2017'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT to_char(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM ninjadata.tb_processing_trans a
  WHERE a.requestor_id = 'AFL 17.01.2017'
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI')
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Invalid campaign code. Fix it! --==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.tb_processing_trans a
  SET a.process_status = 'WAITING', a.campaign = '000000000'
  WHERE a.requestor_id    = 'AFL 17.01.2017'
    AND a.process_status IN ('WAITING', 'PRSD_ERROR', 'IN_PROGRESS')
    AND a.campaign        = '0'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to multiple BAN access. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.tb_processing_trans a
  SET a.process_status = 'WAITING', a.process_time = NULL,
      a.status_desc = NULL, a.processed_type = NULL
  WHERE a.requestor_id   = 'AFL 17.01.2017'
    AND a.process_status = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%has been changed since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
    )
;


