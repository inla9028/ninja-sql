--== Ninja: Display all running jobs, sort by the 'status_time' in order to see how long they've been running...
SELECT a.machine_id, a.job_id, a.job_status,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", 
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME",
       LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME",
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninja_jobs a
 WHERE a.job_status = 'RUNNING'
    OR (a.job_id = 0 AND a.machine_id IN ('NINJAP1_DEMON', 'NINJAP2_DEMON'))
ORDER BY a.status_time, a.machine_id, a.exec_method
;

--== NSM: Display all running jobs, sort by the 'status_time' in order to see how long they've been running...
SELECT a.hostname, a.job_id, a.job_status,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", 
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME",
       LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME",
       NVL(SUBSTR(a.job_fqcn, INSTR(a.job_fqcn, '.', -1)), 'N/A') AS "JOB_FQCN"
  FROM nsm_jobs a
 WHERE a.job_status = 'RUNNING'
    OR (a.job_id = 0 AND a.hostname LIKE 'no-neo-prod%')
ORDER BY a.status_time, a.hostname, a.job_fqcn
;

--== According to Staffan, each transaction takes 300 ms in switch-control...
SELECT a.queue_name, a.queue_size AS "SIZE", a.queue_capacity AS "CAPACITY",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((a.queue_size * 0.300) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((a.queue_size * 0.300) / 60, 60), '9999999'))) || ' min' AS "QUEUE_TIME",
       a.lower_threshold AS "LOWER", a.upper_threshold AS "UPPER", a.update_interval AS "INTERVAL",
       TO_CHAR(a.last_update_date, 'HH24:MI:SS') AS "LAST_UPDATED",
       TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", 
       TO_CHAR(a.last_update_date + (a.update_interval / 86400), 'HH24:MI:SS') AS "NEXT_UPDATE",  
       a.description
  FROM switch_control_monitoring a
ORDER BY a.queue_name
;

--== For 12 hours/today, split on Extracted, Successfully updated and Failed updates.
SELECT *
  FROM (
    SELECT TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '1. Extracted' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
     WHERE rq.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '2. Pending' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PENDING'
       AND rs.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '3. Waiting' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'WAITING'
       AND rs.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '4. Updated' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_SUCCESS'
       AND rs.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx' AS "DATE"
         , '5. Failed' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
       AND rs.record_creation_date > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD HH24') || ':xx'
)
ORDER BY 1, 2
;
