/*
** List the current status.
*/
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterPPChanger'
;

/*
** Start all sleeping threads.
*/
UPDATE ninjaconfig.ninja_jobs a
   SET a.next_exec_time = trunc(SYSDATE)
 WHERE a.exec_method = 'masterPPChanger'
   AND a.job_status  = 'SLEEPING'
;
