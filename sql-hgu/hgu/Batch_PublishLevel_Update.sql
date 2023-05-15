--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records. ==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.subscriber_no, a.publish_level,
       a.process_status, a.process_time, a.status_desc,
       a.record_creation_date, a.request_id, a.request_user_id
  FROM ninjadata.batch_publishlevel_update a
  WHERE a.request_user_id = 'trlu0752'
    AND a.request_id      = 'Trond Lundby 2018-05-25'
    AND a.process_status  = 'PRSD_ERROR';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status... =--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.request_user_id, a.publish_level, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.453) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.453) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_publishlevel_update a
  WHERE a.request_user_id = 'trlu0752'
    AND a.request_id      = 'Trond Lundby 2018-05-25'
  GROUP BY a.request_id, a.request_user_id, a.publish_level, a.process_status
  ORDER BY a.request_id, a.request_user_id, a.publish_level, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List waiting jobs... ==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.request_user_id, a.publish_level, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.453) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.453) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.batch_publishlevel_update a
  WHERE a.process_status  = 'WAITING'
  GROUP BY a.request_id, a.request_user_id, a.publish_level, a.process_status
  ORDER BY a.request_id, a.request_user_id, a.publish_level, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (trimmed) error... -==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.publish_level,
       -- RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
       SUBSTR(RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))), INSTR(a.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM ninjadata.batch_publishlevel_update a
  WHERE a.request_id      = 'Trond Lundby 2018-05-25'
    AND a.request_user_id = 'trlu0752'
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.status_desc, a.subscriber_no, a.publish_level;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the failed records, with the (full) error... ==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.publish_level, a.status_desc
  FROM ninjadata.batch_publishlevel_update a
  WHERE a.request_id      = 'Trond Lundby 2018-05-25'
    AND a.request_user_id = 'trlu0752'
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.subscriber_no, a.status_desc, a.publish_level;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED", MAX(a.process_time) AS "LAST_PROCESSED"
  FROM ninjadata.batch_publishlevel_update a
  WHERE a.request_id      = 'Trond Lundby 2018-05-25'
    AND a.request_user_id = 'trlu0752';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM ninjadata.batch_publishlevel_update a
  WHERE a.request_id      = 'Trond Lundby 2018-05-25'
    AND a.request_user_id = 'trlu0752'
    AND a.process_time IS NOT NULL
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to a 'BAN in use' error. -==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==s
UPDATE ninjadata.batch_publishlevel_update a
   SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
 WHERE a.request_id      = 'Trond Lundby 2018-05-25'
   AND a.request_user_id = 'trlu0752'
   AND (a.status_desc  LIKE '%BAN%in use%'
     OR a.status_desc  LIKE '%No Jolt connections available%'
     OR a.status_desc  LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
     OR a.status_desc  LIKE '%Tuxedo% Fail retrieving DATA from table: PRODUCT%'
)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninjadata.batch_publishlevel_update a
      WHERE a.record_creation_date > TRUNC(SYSDATE - 2)
        AND a.process_status      != 'WAITING'
        AND a.process_time        > SYSDATE - (15 / 1440)  
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

