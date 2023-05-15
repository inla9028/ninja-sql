SELECT a.*
  FROM ninja_jobs a
 WHERE a.exec_method = 'batchBansActivity'
   AND a.machine_id  = 'NINJAP1_DEMON'
;

UPDATE ninja_jobs a
   SET a.next_exec_time = TRUNC(SYSDATE)
 WHERE a.exec_method = 'batchBansActivity'
   AND a.machine_id  = 'NINJAP1_DEMON'
   AND a.job_status  = 'SLEEPING'
;

UPDATE ninja_jobs a
   SET a.job_status  = 'STOPPING'
 WHERE a.exec_method = 'batchBansActivity'
   AND a.machine_id  = 'NINJAP1_DEMON'
   AND a.job_status IN ('SLEEPING', 'RUNNING')
;

UPDATE ninja_jobs a
   SET a.job_status  = 'STARTING'
 WHERE a.exec_method = 'batchBansActivity'
   AND a.machine_id  = 'NINJAP1_DEMON'
   AND a.job_status IN ('STOPPED')
;
