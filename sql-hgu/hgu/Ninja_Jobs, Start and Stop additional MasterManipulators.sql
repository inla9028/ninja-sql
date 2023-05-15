--== Display all batchMasterTransactions's --==--==--==--==--==--==--==--==--==--==--=
SELECT sysdate as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE (a.exec_method = 'batchMasterTransactions'
    AND a.job_id IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 85, 86)
    AND a.machine_id = 'NINJAP2_DEMON')
    OR (a.exec_method = 'batchMasterTransactions'
    AND a.job_id IN (62)
    AND a.machine_id = 'NINJAP2_DEMON')
ORDER BY a.job_id
;

--== Start the additional batchMasterTransactions's, in case they're sleeping. =--==--
UPDATE ninjaconfig.ninja_jobs a
   SET a.next_exec_time = TRUNC(SYSDATE), a.status_desc = NULL
 WHERE (a.exec_method = 'batchMasterTransactions'
    AND a.job_id IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 85, 86)
    AND a.machine_id = 'NINJAP2_DEMON')
    OR (a.exec_method = 'batchMasterTransactions'
    AND a.job_id IN (62)
    AND a.machine_id = 'NINJAP2_DEMON')
;

--== Start the additional batchMasterTransactions's --==--==--==--==--==--==--==--==--
UPDATE ninjaconfig.ninja_jobs a
   SET a.job_status   = 'STARTING', a.next_exec_time = TRUNC(SYSDATE)
--   SET a.job_status   = 'STARTING', a.next_exec_time = TO_DATE('2012-06-26 22:45', 'YYYY-MM-DD HH24:MI')
--     , a.status_desc  = NULL
 WHERE (a.exec_method = 'batchMasterTransactions'
    AND a.job_id IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 85, 86)
    AND a.machine_id = 'NINJAP2_DEMON')
    OR (a.exec_method = 'batchMasterTransactions'
    AND a.job_id IN (62)
    AND a.machine_id = 'NINJAP2_DEMON')
;

COMMIT WORK;

--== Stop the additional batchMasterTransactions's --==--==--==--==--==--==--==--==--=
UPDATE ninjaconfig.ninja_jobs a
   SET a.job_status   = 'STOPPING'
 WHERE (a.exec_method = 'batchMasterTransactions'
    AND a.job_id IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 85, 86)
    AND a.machine_id = 'NINJAP2_DEMON')
    OR (a.exec_method = 'batchMasterTransactions'
    AND a.job_id IN (62)
    AND a.machine_id = 'NINJAP2_DEMON')
   AND a.job_status  IN ('RUNNING', 'SLEEPING') -- Should only stop the sleeping processes!
;

COMMIT WORK;
