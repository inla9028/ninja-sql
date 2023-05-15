--== Request that the job is stopped...
UPDATE ninja_jobs a
  SET a.job_status = 'STOPPING'
  WHERE a.machine_id  = 'NINJAP2Z_DEMON'
    AND a.job_id      = 40
    AND a.exec_method = 'serviceManipulator' -- Redundant, but safe
/

COMMIT WORK
/

--== Wait for the job to stop.
SELECT a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninja_jobs a
  WHERE a.machine_id  = 'NINJAP2Z_DEMON'
    AND a.job_id      = 40
    AND a.exec_method = 'serviceManipulator'
/

--== Make sure the job isn't flagged as temporarily stopped.
UPDATE ninja_jobs a
  SET a.was_running = 'N'
  WHERE a.machine_id  = 'NINJAP2Z_DEMON'
    AND a.job_id      = 40
    AND a.exec_method = 'serviceManipulator' -- Redundant, but safe
/

--== Request that the new job is started...
UPDATE ninja_jobs a
  SET a.job_status = 'STARTING'
  WHERE a.machine_id  = 'NINJAP2Z_DEMON'
    AND a.job_id      = 41
    AND a.exec_method = 'batchServiceTransactions' -- Redundant, but safe
/

COMMIT WORK
/

--== Now, go and monitor the progress in service_transactions table (for the last 5 minutes).
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24:MI') AS "ENTER_TIME",
       a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.service_transactions a
  WHERE a.enter_time > (SYSDATE - 5/1440) 
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24:MI'), a.process_status
  ORDER BY "ENTER_TIME", a.process_status
/
