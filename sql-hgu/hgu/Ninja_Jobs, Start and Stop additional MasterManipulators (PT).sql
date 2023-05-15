--== Display all batchMasterTransactions's
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninja_jobs a
 WHERE a.machine_id  = 'NINJA_PT2_SH1'
    AND (a.exec_method = 'batchMasterTransactions'
      OR a.job_id      = 0) 
ORDER BY a.machine_id, a.job_id
;

--== Start the additional batchMasterTransactions's, in case they're sleeping.
UPDATE ninja_jobs a
   SET a.next_exec_time = TRUNC(SYSDATE)
     , a.status_desc    = NULL
 WHERE a.machine_id     = 'NINJA_PT2_SH1'
   AND a.exec_method    = 'batchMasterTransactions'
;

--== Start the additional batchMasterTransactions's
UPDATE ninja_jobs a
   SET a.job_status     = 'STARTING'
     , a.next_exec_time = TRUNC(SYSDATE)
 WHERE a.machine_id     = 'NINJA_PT2_SH1'
   AND a.exec_method    = 'batchMasterTransactions'
   AND a.job_status     = 'STOPPED'
;

COMMIT WORK;

--== Stop the additional batchMasterTransactions's
UPDATE ninja_jobs a
   SET a.job_status     = 'STOPPING'
 WHERE a.machine_id     = 'NINJA_PT2_SH1'
   AND a.exec_method    = 'batchMasterTransactions'
   AND a.job_status    IN ( 'RUNNING', 'SLEEPING' )
;

COMMIT WORK;
