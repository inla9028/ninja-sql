UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = TRUNC(SYSDATE)
WHERE a.job_status  = 'SLEEPING'
  AND a.exec_method = 'batchNameAddressUpdate'
;

UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = TRUNC(SYSDATE)
WHERE a.job_status  = 'SLEEPING'
  AND a.exec_method = 'masterManipulator' AND a.job_id IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59)
;

UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = TRUNC(SYSDATE)
WHERE a.job_status  = 'SLEEPING'
  AND a.exec_method = 'masterPPChanger'
;

UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = TRUNC(SYSDATE)
WHERE a.job_status  = 'SLEEPING'
  AND a.exec_method = 'statusManipulator'
;


/*
** Seldom used
*/
UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = TRUNC(SYSDATE)
WHERE a.job_status  = 'SLEEPING'
  AND a.exec_method = 'banTreeManipulator'
;

UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = TRUNC(SYSDATE)
WHERE a.job_status  = 'SLEEPING'
  AND a.exec_method = 'batchDiscountAddition'
;

