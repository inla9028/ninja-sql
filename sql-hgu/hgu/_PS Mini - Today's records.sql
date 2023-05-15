--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display today's waiting records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TOAV PRJ4441'
    AND a.process_status = 'WAITING'
    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
  GROUP BY a.process_status
  ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display today's waiting records, per stream...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TOAV PRJ4441'
    AND a.process_status = 'WAITING'
--    AND a.request_time   BETWEEN TO_DATE('2009-06-19', 'YYYY-MM-DD') AND TO_DATE('2009-06-20', 'YYYY-MM-DD')
--    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
  GROUP BY TO_NUMBER(a.stream), a.process_status
  ORDER BY TO_NUMBER(a.stream), a.process_status;

--== Temp
/*
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TOAV PRJ4441'
    AND a.request_time   < SYSDATE
    AND a.process_status = 'WAITING'
  GROUP BY TO_NUMBER(a.stream), a.process_status
  ORDER BY TO_NUMBER(a.stream), a.process_status;
*/

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display today's processed and waiting records...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TOAV PRJ4441'
    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
  GROUP BY a.process_status
  ORDER BY a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display today's processed and waiting records, per stream...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TOAV PRJ4441'
    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
  GROUP BY TO_NUMBER(a.stream), a.process_status
  ORDER BY TO_NUMBER(a.stream), a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display today's errors...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.soc, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TOAV PRJ4441'
    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
    AND a.process_status = 'PRSD_ERROR'
--  ORDER BY a.subscriber_no, a.action_code, a.soc
  ORDER BY "STATUS_DESC", a.subscriber_no;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process today's failed records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
--     , a.stream = '1'
  WHERE a.request_id     = 'TOAV PRJ4441'
    AND a.process_status = 'PRSD_ERROR'
--    AND a.request_time   BETWEEN TRUNC(SYSDATE) AND SYSDATE
    AND (a.status_desc   LIKE '%No Jolt connections available%'
      OR a.status_desc   LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc   LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc   LIKE '%Please try accessing account again later%'
      OR a.status_desc   LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR a.status_desc   LIKE '%not connected to ORACLE%'
      OR a.status_desc   LIKE '%Tuxedo server%service is down%'
      OR a.status_desc   LIKE '%weblogic.common.resourcepool.ResourceLimitException%'
    );
UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = TRUNC(SYSDATE), a.status_desc = NULL
  WHERE a.exec_method = 'masterManipulator'
    AND a.job_status IN ('SLEEPING') -- Should only start the stopped processes?
    AND a.job_id IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59)
    AND a.machine_id = 'NINJAP2Z_DEMON';
COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the state of all MasterManipulator's
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterManipulator'
    AND a.job_id IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59)
    AND a.machine_id = 'NINJAP2Z_DEMON'
  ORDER BY a.job_id;

