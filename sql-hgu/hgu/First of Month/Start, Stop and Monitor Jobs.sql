--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--== Check the status of the associated worker threads/processes.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SYSDATE AS "NOW", a.machine_id, a.job_id, a.job_status, a.sleep_time,
       a.next_exec_time, a.status_time, /*a.status_desc,*/ a.exec_method, a.job_desc
  FROM ninjaconfig.ninja_jobs a
  WHERE (a.machine_id = 'NINJAP2Z_DEMON'
     AND a.job_id IN (9, 10, 11, 12, 13, 14, 15, 16, 17, 18))
     OR (a.machine_id = 'NINJAP1Z_DEMON'
     AND a.job_id     = 8)
  ORDER BY a.job_id

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--== Updates the status of the monthly batch-jobs to 'STARTING',
--==--== which causes the demon engine to start the processes.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STARTING', a.next_exec_time = TRUNC(SYSDATE)
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id IN (9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    AND a.job_status NOT IN ('RUNNING', 'STOPPING', 'SLEEPING');
COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--== Runs the processes now, in case they're sleeping...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
--  SET a.next_exec_time = TRUNC(SYSDATE)
  SET a.next_exec_time = TO_DATE('2010-10-01 00:01', 'YYYY-MM-DD HH24:MI')
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id IN (9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    AND a.job_status IN ('SLEEPING');
COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--== Updates the status of the monthly batch-jobs to 'STOPPING',
--==--== which causes the demon engine to halt the processes. Don't do this
--==--== until after the trigger has stopped "spreading the load"....
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STOPPING'
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id IN (9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    AND a.job_status NOT IN ('STOPPED', 'STOPPING');
COMMIT WORK;

