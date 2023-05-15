--== Display MasterManipulator --==--==--==--==--==--==--==--==--==--==--==--==-
SELECT sysdate as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method = 'masterManipulator'
   AND a.job_id      = 50
   AND a.machine_id  = 'NINJAP2_DEMON'
ORDER BY a.job_id
;

--== Start the MasterManipulator in case it's sleeping. =--==--==--==--==--==--=
UPDATE ninjaconfig.ninja_jobs a
   SET a.next_exec_time = TRUNC(SYSDATE), a.status_desc = NULL
 WHERE a.exec_method = 'masterManipulator'
   AND a.job_id      = 50
   AND a.machine_id  = 'NINJAP2_DEMON'
   AND a.job_status  = 'SLEEPING'
;

--== Start the MasterManipulator in case it was stopped ==--==--==--==--==--==--
UPDATE ninjaconfig.ninja_jobs a
--   SET a.job_status = 'STARTING', a.next_exec_time = TO_DATE('2010-04-15 06:01', 'YYYY-MM-DD HH24:MI')
   SET a.job_status = 'STARTING', a.next_exec_time = TRUNC(SYSDATE)
 WHERE a.exec_method = 'masterManipulator'
   AND a.job_id      = 50
   AND a.machine_id  = 'NINJAP2_DEMON'
   AND a.job_status  = 'STOPPED'
;

COMMIT WORK;

--== Stop the main MasterManipulator --==--==--==--==--==--==--==--==--==--==--=
UPDATE ninjaconfig.ninja_jobs a
   SET a.job_status = 'STOPPING'
 WHERE a.exec_method = 'masterManipulator'
   AND a.job_id      = 50
   AND a.machine_id  = 'NINJAP2_DEMON'
   AND a.job_status  IN ('RUNNING', 'SLEEPING')
;

COMMIT WORK;

