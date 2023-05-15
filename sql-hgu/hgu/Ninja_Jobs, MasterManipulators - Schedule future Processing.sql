/*
**
** Schedule the processes to start at a specific point in time later today...
**
*/
UPDATE ninjaconfig.ninja_jobs a
   SET a.next_exec_time = TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI')
 WHERE a.exec_method  = 'masterManipulator'
   AND a.job_status   = 'SLEEPING'
   AND a.job_id      IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59)
   AND a.machine_id   = 'NINJAP2Z_DEMON'
;


UPDATE ninjaconfig.ninja_jobs a
   SET a.next_exec_time = TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI')
     , a.job_status     = 'STARTING'
 WHERE a.exec_method  = 'masterManipulator'
   AND a.job_status   = 'STOPPED'
   AND a.job_id      IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59)
   AND a.machine_id   = 'NINJAP2Z_DEMON'
;


COMMIT WORK;


/*
**
** Display the result...
**
*/
SELECT SYSDATE AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method  = 'masterManipulator'
   AND a.job_id      IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59)
   AND a.machine_id   = 'NINJAP2Z_DEMON'
ORDER BY a.job_id
;
