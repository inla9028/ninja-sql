/*
** List all running jobs.
*/
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id  IN ('NINJAP1_DEMON', 'NINJAP2_DEMON')
   AND a.job_status IN ('SLEEPING', 'STARTING', 'RUNNING')
ORDER BY 1,2
;

/*
** List all affected jobs.
*/
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id IN ('NINJAP1_DEMON')
   AND a.job_id     IN (32, 34)
UNION
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id IN ('NINJAP2_DEMON')
   AND a.job_id     IN (71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81)
;

/*
** Jobs to stop:
** Machine ID = 'NINJAP1_DEMON'
** 32, 34
** Machine ID = 'NINJAP2_DEMON'
** 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81
*/
UPDATE ninja_jobs a
   SET a.job_status = 'STOPPING'
 WHERE a.machine_id IN ('NINJAP1_DEMON')
   AND a.job_status IN ('SLEEPING', 'STARTING', 'RUNNING')
   AND a.job_id     IN (32, 34)
;

UPDATE ninja_jobs a
   SET a.job_status = 'STOPPING'
 WHERE a.machine_id IN ('NINJAP2_DEMON')
   AND a.job_status IN ('SLEEPING', 'STARTING', 'RUNNING')
   AND a.job_id     IN (71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81)
;

/*
** List all affected jobs.
*/
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id IN ('NINJAP1_DEMON')
   AND a.job_id     IN (32, 34)
UNION
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id IN ('NINJAP2_DEMON')
   AND a.job_id     IN (71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81)
;

/*
** Resume jobs.
*/
UPDATE ninja_jobs a
   SET a.job_status = 'STARTING'
 WHERE a.machine_id IN ('NINJAP1_DEMON')
   AND a.job_status IN ('STOPPED')
   AND a.job_id     IN (32, 34)
;

UPDATE ninja_jobs a
   SET a.job_status = 'STARTING'
 WHERE a.machine_id IN ('NINJAP2_DEMON')
   AND a.job_status IN ('STOPPED')
   AND a.job_id     IN (71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81)
;

/*
** List all affected jobs.
*/
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id IN ('NINJAP1_DEMON')
   AND a.job_id     IN (32, 34)
UNION
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id IN ('NINJAP2_DEMON')
   AND a.job_id     IN (71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81)
;

