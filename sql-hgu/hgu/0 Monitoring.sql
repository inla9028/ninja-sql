--== Ninja: Display all running jobs, sort by the 'status_time' in order to see how long they've been running...
SELECT a.machine_id, a.job_id, a.job_status
--     , ltrim(TO_CHAR(a.sleep_time/60000, '00')) || ':' || ltrim(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME"
     , TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", TO_CHAR(a.status_time, 'YYYY-MM-DD') AS "STATUS_DATE"
     , to_char(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME"
     , LTRIM(TO_CHAR(a.sleep_time/60000, 'FM9900')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'YYYY-MM-DD') AS "NEXT_EXEC_DAY"
     , TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME"
     , LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME"
     ,  a.exec_method, a.job_desc, a.fixed_start -- , a.hlr_based
  FROM ninja_jobs a 
 WHERE a.machine_id IN ('NINJAP1_DEMON', 'NINJAP2_DEMON')
--   AND (a.job_id = 0 OR a.job_status IN ( 'RUNNING', 'STOPPING', 'STARTING' ))
   AND (a.job_id = 0 OR a.job_status IN ( 'RUNNING', 'STOPPING' ))
ORDER BY a.status_time, a.machine_id, a.exec_method
;


--== NSM: Display all running jobs, sort by the 'status_time' in order to see how long they've been running...
SELECT a.hostname, a.job_id, a.job_status, TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW"
     , TO_CHAR(a.status_time, 'YYYY-MM-DD') AS "STATUS_DATE", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME"
     , LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || ltrim(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME"
     , TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME"
     , LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME",
       NVL(SUBSTR(a.job_fqcn, DECODE(INSTR(a.job_fqcn, '.', -1), -1, -1, INSTR(a.job_fqcn, '.', -1) + 1)), 'N/A') AS "JOB_FQCN"
  FROM nsm_jobs a
 WHERE a.hostname LIKE 'no-neo-prod%'
--    AND (a.job_id = 0 OR a.job_status = 'RUNNING')
    AND (a.job_id = 0 OR a.job_status IN ( 'RUNNING', 'STARTING' ))
--   AND (a.job_id = 0 OR a.job_status != 'STOPPED')
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


--== Check the TPID queue from Fokus into Party Manager
SELECT process_time, process_status, mycount AS "COUNT"
     , round(     mycount /   60 , 0) AS "RPM"
     , round(     mycount / 3600 , 2) AS "RPS"
     , round(1 / (mycount / 3600), 3) AS "SPR"
  FROM (
SELECT b.process_time, b.process_status, count(1) AS "MYCOUNT"
  FROM (SELECT to_char(a.process_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "PROCESS_TIME", a.process_status
          FROM batch_tpid_extract a
         WHERE a.request_time > trunc(SYSDATE - 1)
           AND nvl(a.process_time, SYSDATE) > trunc(SYSDATE)
--           AND nvl(a.process_time, SYSDATE) > trunc(SYSDATE - 1/3, 'HH')
--           AND nvl(a.process_time, SYSDATE) > to_date('2021-04-29 15:06', 'YYYY-MM-DD HH24:MI')
           AND a.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS', 'WAITING' )) b
GROUP BY b.process_time, b.process_status
ORDER BY b.process_time, b.process_status
)
;


--== Check the TPID queue from Ninja/Party Manager into Fokus
SELECT b.process_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(a.process_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "PROCESS_TIME", a.process_status
          FROM batch_tpid_update a
         WHERE a.request_time > trunc(SYSDATE - 1)
           AND trunc(SYSDATE) < nvl(a.process_time, SYSDATE)
           AND a.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS', 'WAITING' )) b
GROUP BY b.process_time, b.process_status
ORDER BY b.process_time, b.process_status
;


--== Check the events caused by processing by/via Ninja.
SELECT b.request_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(a.request_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "REQUEST_TIME", a.process_status
          FROM party_manager_events a
         WHERE a.request_time > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
           AND trunc(SYSDATE) < nvl(a.process_time, SYSDATE)
           AND a.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS', 'WAITING' )) b
GROUP BY b.request_time, b.process_status
ORDER BY b.request_time, b.process_status
;


--== Display charges, added today and/or waiting to be processed.
--SELECT TO_CHAR(TRUNC(a.request_time), 'YYYY-MM-DD') AS "REQUEST_DAY"
--     , a.request_user_id, a.request_id, a.charge_code, a.process_status, COUNT(*) AS "COUNT"
--     , TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.700) / 3600,      '9999999'))) || ' hours ' ||
--       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.700) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
--  FROM batch_charge_addition a
-- WHERE a.request_time > TRUNC(SYSDATE - 1)
--    OR a.process_status = 'WAITING'
--GROUP BY to_char(trunc(a.request_time), 'YYYY-MM-DD'), a.request_user_id, a.request_id, a.charge_code, a.process_status
--ORDER BY to_char(trunc(a.request_time), 'YYYY-MM-DD'), a.request_user_id, a.request_id, a.charge_code, a.process_status
--;

--== The job by/for Trond Vestli.
--SELECT a.requestor_id, a.request_time, a.process_status, COUNT(*) AS "COUNT",
--       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.726) / 3600), '9999999'))) || ' hours ' ||
--       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.726) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
--  FROM batch_change_priceplan a
-- WHERE a.requestor_id = 'TRVE0622 2022-03-01'
--GROUP BY a.requestor_id, a.request_time, a.process_status
--ORDER BY a.requestor_id, a.request_time, a.process_status
--;

--== For 3 days, split on Extracted, Successfully updated and Failed updates.
SELECT *
  FROM (
    SELECT TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '1. Extracted' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_request rq
     WHERE rq.record_creation_date > TRUNC(SYSDATE - 3)
    GROUP BY TO_CHAR(rq.record_creation_date, 'YYYY-MM-DD')
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '2. Pending' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PENDING'
       AND rs.record_creation_date > TRUNC(SYSDATE - 3)
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD')
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '3. Waiting' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'WAITING'
       AND rs.record_creation_date > TRUNC(SYSDATE - 3)
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD')
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '4. Updated' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_SUCCESS'
       AND rs.record_creation_date > TRUNC(SYSDATE - 3)
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD')
    UNION
    SELECT TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD') AS "DATE"
         , '5. Failed' AS "OPERATION"
         , COUNT(*) AS "COUNT"
      FROM dsp_response rs
     WHERE rs.process_status = 'PRSD_ERROR'
       AND rs.record_creation_date > TRUNC(SYSDATE - 3)
    GROUP BY TO_CHAR(rs.record_creation_date, 'YYYY-MM-DD')
)
ORDER BY 1, 2
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

-- In case no more extracts are found in the snapshot, pause for the rest of the day...
UPDATE ninja_jobs a
   SET a.next_exec_time = trunc(SYSDATE + 1) -- + 29/48
 WHERE a.machine_id     = 'NINJAP2_DEMON'
   AND a.job_id        IN ( 42 )
;
