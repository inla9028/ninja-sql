SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id = 'NINJAP2_DEMON'
   AND a.job_id     = 84
;

UPDATE ninja_jobs a SET a.job_status = 'STARTING' WHERE a.machine_id = 'NINJAP2_DEMON' AND a.job_id = 84 AND a.job_status = 'STOPPED'
;

UPDATE ninja_jobs a SET a.job_status = 'STOPPING' WHERE a.machine_id = 'NINJAP2_DEMON' AND a.job_id = 84 AND a.job_status IN ( 'SLEEPING', 'RUNNING' )
;

