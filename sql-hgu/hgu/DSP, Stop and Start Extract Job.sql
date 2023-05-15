SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", nj.machine_id, nj.job_id, nj.job_status, -- nj.was_running,
       LTRIM(TO_CHAR(nj.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(nj.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
--       TO_CHAR(nj.sleep_time/60000, '00') AS "SLEEP_MIN", TO_CHAR(MOD(nj.sleep_time/1000, 60), '00') AS "SLEEP_SEC", nj.sleep_time, 
       TO_CHAR(nj.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(nj.status_time, 'HH24:MI:SS') AS "STATUS_TIME",
       --TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - nj.status_time), 'HH24:MI:SS') AS "RUNTIME",
       LTRIM(TO_CHAR(TRUNC(SYSDATE - nj.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - nj.status_time), ':HH24:MI:SS') AS "RUNTIME",
       /*nj.status_desc,*/ nj.exec_method, nj.job_desc, nj.fixed_start, nj.hlr_based
  FROM ninjaconfig.ninja_jobs nj
 WHERE nj.job_status = 'RUNNING'
ORDER BY nj.status_time, nj.machine_id, nj.exec_method
;

UPDATE ninja_jobs nj
   SET nj.job_status      = 'STOPPING'
 WHERE nj.job_id          = 42
   AND nj.machine_id      = 'NINJAP2Z_DEMON'
   AND nj.job_status NOT IN ('STOPPED', 'STOPPING')
;

UPDATE ninja_jobs nj
   SET nj.job_status  = 'STARTING'
 WHERE nj.job_id      = 42
   AND nj.machine_id  = 'NINJAP2Z_DEMON'
   AND nj.job_status IN ('STOPPED')
;

SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", nj.machine_id, nj.job_id, nj.job_status,
       LTRIM(TO_CHAR(nj.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(nj.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(nj.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(nj.status_time, 'HH24:MI:SS') AS "STATUS_TIME",
       LTRIM(TO_CHAR(TRUNC(SYSDATE - nj.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - nj.status_time), ':HH24:MI:SS') AS "RUNTIME",
       nj.exec_method, nj.job_desc, nj.fixed_start, nj.hlr_based
  FROM ninja_jobs nj
 WHERE nj.job_id     = 42
   AND nj.machine_id = 'NINJAP2Z_DEMON'
;

SELECT sd.*
  FROM system_defaults sd
 WHERE sd.key LIKE 'DSP%'
;
