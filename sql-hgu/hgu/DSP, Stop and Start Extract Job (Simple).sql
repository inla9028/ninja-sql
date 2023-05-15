/*
** List...
*/
SELECT TO_CHAR(SYSDATE, 'HH24:MI') AS "NOW", a.*
  FROM ninja_jobs a
 WHERE a.machine_id = 'NINJAP2_DEMON'
   AND a.job_id     = 42
;

/*
** Pause for the day after tomorrow...
*/
UPDATE ninja_jobs a
   SET a.next_exec_time = TRUNC(SYSDATE + 2) + 1 / 48 -- 00:30 tomorrow.
 WHERE a.machine_id     = 'NINJAP2_DEMON'
   AND a.job_id         = 42
;

/*
** Postpone...
*/
UPDATE ninja_jobs a
   SET a.next_exec_time = TRUNC(SYSDATE + 2) + 1/48 -- 00:30 
 WHERE a.machine_id     = 'NINJAP2_DEMON'
   AND a.job_id         = 42
   AND a.job_status IN ('RUNNING', 'SLEEPING')
;

/*
** Stop.
*/
UPDATE ninja_jobs a
   SET a.job_status = 'STOPPING'
 WHERE a.machine_id = 'NINJAP2_DEMON'
   AND a.job_id     = 42
   AND a.job_status IN ('RUNNING', 'SLEEPING')
;

/*
** Start.
*/
UPDATE ninja_jobs a
   SET a.job_status = 'STARTING'
 WHERE a.machine_id = 'NINJAP2_DEMON'
   AND a.job_id     = 42
   AND a.job_status IN ('STOPPED')
;


