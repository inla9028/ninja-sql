SELECT a.ban, a.sm_key, a.sm_desc, a.additional_name, a.enter_time, a.request_time,
       a.request_id, a.process_time, a.process_status, a.status_desc
  FROM salesmaker_ban_creator a
  WHERE a.request_id     = 'HGU 2009-06-16'
--    AND a.process_status = 'PRSD_SUCCESS';
    AND a.process_status = 'PRSD_ERROR';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the errors I'm not completely sure of why they appear...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.sm_key, a.sm_desc, a.additional_name, a.enter_time, a.request_time,
       a.request_id, a.process_time, a.process_status, a.status_desc
  FROM salesmaker_ban_creator a
  WHERE a.request_id     = 'HGU 2009-06-16'
    AND a.process_status = 'PRSD_ERROR'
    AND a.status_desc LIKE '%Requested Billing Account # 0 does not exist%';

SELECT a.account_type, a.account_sub_type, ban_status, COUNT(*) AS "COUNT"
  FROM billing_account@prod a, salesmaker_ban_creator b
  WHERE a.ban            = b.ban
    AND b.request_id     = 'HGU 2009-06-16'
    AND b.process_status = 'PRSD_ERROR'
    AND b.status_desc LIKE '%Requested Billing Account # 0 does not exist%'
  GROUP BY a.account_type, a.account_sub_type, ban_status
  ORDER BY a.account_type, a.account_sub_type, ban_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status. The value time-value is calculated in a script further down.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.992) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.992) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM salesmaker_ban_creator a
  WHERE a.request_id = 'HGU 2009-06-16'
  GROUP BY a.request_id, a.process_status
  ORDER BY a.request_id, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display records that failed, with trimmed status description
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.sm_key, a.sm_desc, a.additional_name, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM salesmaker_ban_creator a
  WHERE a.request_id      = 'HGU 2009-06-16'
    AND a.process_status  = 'PRSD_ERROR'
  ORDER BY a.ban, a.sm_key, a.sm_desc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display an overview of the records that failed.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--SELECT RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC", COUNT(*) AS "COUNT"
SELECT COUNT(*) AS "COUNT", RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM salesmaker_ban_creator a
  WHERE a.request_id      = 'HGU 2009-06-16'
    AND a.process_status  = 'PRSD_ERROR'
--    AND a.process_time    > SYSDATE - (15/1440)
    AND a.process_time    > SYSDATE - (60/1440)
  GROUP BY RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')))
  ORDER BY "COUNT", "STATUS_DESC";

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM salesmaker_ban_creator a
      WHERE a.request_time    <  SYSDATE
        AND a.process_status != 'WAITING'
        AND a.process_time    >  SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);



--
SELECT *
 FROM (SELECT   ROWID, ban AS "MAN", sm_key AS "SM_KEY",
                sm_desc AS "SM_DESC", additional_name AS "ADDITIONAL_NAME"
           FROM salesmaker_ban_creator
          WHERE process_status = 'WAITING' AND request_time < SYSDATE
       ORDER BY request_time)
WHERE ROWNUM < 16;

---
SELECT a.ban, a.sm_key, a.sm_desc, a.additional_name, a.enter_time, a.request_time,
       a.request_id, a.process_time, a.process_status, a.status_desc
  FROM salesmaker_ban_creator a
  WHERE a.request_id     = 'HGU 2009-06-16'
    AND a.process_status = 'WAITING'

--
UPDATE salesmaker_ban_creator a
  SET a.process_status = 'IN_PROGRESS'
  WHERE a.request_id     = 'HGU 2009-06-16'
    AND a.process_status = 'WAITING'
--
UPDATE salesmaker_ban_creator a
  SET a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
  WHERE a.request_id     = 'HGU 2009-06-16'
    AND a.process_status = 'PRSD_ERROR'
    AND a.status_desc LIKE '%Requested Billing Account%does not exist.%';

--== Assign xxx records for processing... :-)
UPDATE salesmaker_ban_creator a
  SET a.process_status = 'WAITING'
  WHERE ROWID in (
    SELECT ROWID FROM salesmaker_ban_creator b
    WHERE b.request_id     = 'HGU 2009-06-16'
      AND b.process_status = 'IN_PROGRESS'
      AND ROWNUM < 10000)

