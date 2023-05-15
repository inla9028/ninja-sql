--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all(?) records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.new_ban, a.new_priceplan, a.new_campaign_code,
       a.handle_commitment, a.dealer, a.sales_agent, a.reason_code,
       a.memo_text, a.keep_user_name, a.waive_fees, a.is_move_from_sp,
       a.is_move_to_sp, a.enter_time, a.request_time, a.process_time,
       a.process_status, a.status_desc, a.priority, a.request_id,
       a.request_user_id, a.skip_ninja_validation
  FROM ninjadata.batch_move_subscribers a
 WHERE a.request_id      IN ('2018-08-31')
   AND a.request_user_id IN ('HGU')
   AND a.process_status    = 'PRSD_ERROR';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records either waiting or paused (i.e. 'in progress').
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.new_ban, a.new_priceplan, a.new_campaign_code,
       a.handle_commitment, a.dealer, a.sales_agent, a.reason_code,
       a.memo_text, a.keep_user_name, a.waive_fees, a.is_move_from_sp,
       a.is_move_to_sp, a.enter_time, a.request_time  me, a.process_time,
       a.process_status, a.status_desc, a.priority, a.request_id,
       a.request_user_id, a.skip_ninja_validation
  FROM ninjadata.batch_move_subscribers a
 WHERE a.process_status IN ('WAITING', 'IN_PROGRESS');


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List all request-id's & -user id's inserted since midnight.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.request_user_id, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_move_subscribers a
 WHERE a.request_time > TRUNC(SYSDATE - 1)
 GROUP BY a.request_id, a.request_user_id
 ORDER BY a.request_id, a.request_user_id;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status of the specific job - per price plan...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.new_priceplan, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 4.615) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 4.615) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_move_subscribers a
 WHERE a.request_id      IN ('2018-08-31')
   AND a.request_user_id IN ('HGU')
--   AND NVL(a.process_time, SYSDATE) > SYSDATE - (3 / 24)
 GROUP BY a.new_priceplan, a.process_status
 ORDER BY a.new_priceplan, a.process_status;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display only the status of the specific job...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 4.615) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 4.615) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_move_subscribers a
 WHERE a.request_id      IN ('2018-08-31')
   AND a.request_user_id IN ('HGU')
--   AND NVL(a.process_time, SYSDATE) > SYSDATE - (3 / 24)
 GROUP BY a.process_status
 ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display only the status of the specific job...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_user_id, a.request_id, to_char(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQ_TIME"
     , a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 4.615) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 4.615) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_move_subscribers a
 WHERE a.request_id      IN ('2018-08-31')
   AND a.request_user_id IN ('HGU')
--   AND NVL(a.process_time, SYSDATE) > SYSDATE - (3 / 24)
 GROUP BY a.request_user_id, a.request_id, to_char(a.request_time, 'YYYY-MM-DD HH24:MI'), a.process_status
 ORDER BY 1, 2, 3, 4
;



--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the errors for the specific job...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.new_ban, a.new_priceplan, -- a.new_campaign_code,
       --RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
       SUBSTR(RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))), INSTR(a.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM ninjadata.batch_move_subscribers a
 WHERE a.request_id      IN ('2018-08-31')
   AND a.request_user_id IN ('HGU')
   AND a.process_status = 'PRSD_ERROR'
 ORDER BY a.status_desc, a.subscriber_no;


--== Drop Ninja validation...
UPDATE ninjadata.batch_move_subscribers a
   SET a.skip_ninja_validation = 'Y', a.process_status  = 'WAITING', a.process_time = NULL, a.status_desc = NULL
 WHERE a.request_id          IN ('2018-08-31')
   AND a.request_user_id     IN ('HGU')
   AND a.process_status        = 'PRSD_ERROR'
   AND a.skip_ninja_validation = 'N';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the errors for the specific job...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.new_ban, a.new_priceplan,
       SUBSTR(RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))), INSTR(a.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM ninjadata.batch_move_subscribers a
 WHERE a.request_id      IN ('2018-08-31')
   AND a.request_user_id IN ('HGU')
   AND a.process_status   = 'PRSD_ERROR'
   AND a.process_time     > TRUNC(SYSDATE)
--   AND NVL(a.process_time, SYSDATE) > SYSDATE - (3 / 24)
 ORDER BY a.status_desc, a.subscriber_no;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start the paused (i.e. 'in progress') jobs.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_move_subscribers a
   SET a.process_status = 'WAITING'
 --    , a.request_time   = TO_DATE('2017-03-31 20:00', 'YYYY-MM-DD HH24:MI')
 WHERE a.request_id      IN ('2018-08-31')
   AND a.request_user_id IN ('HGU')
   AND a.process_status    = 'IN_PROGRESS'
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process failed records while skipping Ninja's validation.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_move_subscribers a
   SET a.skip_ninja_validation = 'Y', a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
 WHERE a.request_id          IN ('2018-08-31')
   AND a.request_user_id     IN ('HGU')
   AND a.process_status        = 'PRSD_ERROR'
   AND a.skip_ninja_validation = 'N';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process the failed records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.batch_move_subscribers a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  WHERE a.request_id          IN ('2018-08-31')
    AND a.request_user_id     IN ('HGU')
    AND a.process_status        = 'PRSD_ERROR'
    AND (a.status_desc    LIKE '%No Jolt connections available%'
      OR a.status_desc    LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc    LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc    LIKE '%Please try accessing account again later%'
      OR a.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR a.status_desc    LIKE '%not connected to ORACLE%'
      OR a.status_desc    LIKE '%Tuxedo server%service is down%'
      OR a.status_desc    LIKE '%weblogic.common.resourcepool.ResourceLimitException%'
    )
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
      FROM ninjadata.batch_move_subscribers a
      WHERE a.process_status      != 'WAITING'
        AND a.process_time        > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

