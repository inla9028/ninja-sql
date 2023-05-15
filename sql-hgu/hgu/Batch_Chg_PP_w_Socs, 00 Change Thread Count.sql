/*
** List the status of the job.
*/
SELECT a.*
  FROM ninja_jobs a
 WHERE a.exec_method = 'processChangeRatingAndSocs'
   AND a.machine_id  = 'NINJAP2_DEMON'
;

/*
** List the current configuration.
*/
SELECT a.*
  FROM ninja_jobs_parameters a
 WHERE a.machine_id  = 'NINJAP2_DEMON'
   AND a.job_id      = 81
;

/*
** Stop the job.
*/
UPDATE ninja_jobs a
   SET a.job_status  = 'STOPPING'
 WHERE a.machine_id  = 'NINJAP2_DEMON'
   AND a.job_id      = 81
   AND a.job_status  != 'STOPPED'
;

/*
** Commit...
*/
COMMIT WORK;

/*
** List the status of the job.
*/
SELECT a.*
  FROM ninja_jobs a
 WHERE a.exec_method = 'processChangeRatingAndSocs'
   AND a.machine_id  = 'NINJAP2_DEMON'
;

/*
** Change thread-count from the original 10, since Fokus keeps getting it|s knickers in a twist.
*/
UPDATE ninja_jobs_parameters a
   SET a.parameter_value = '1'
 WHERE a.machine_id      = 'NINJAP2_DEMON'
   AND a.job_id          = 81
   AND a.parameter_order = 2
;

/*
** Start the job.
*/
UPDATE ninja_jobs a
   SET a.job_status  = 'STARTING'
 WHERE a.machine_id  = 'NINJAP2_DEMON'
   AND a.job_id      = 81
   AND a.job_status  = 'STOPPED'
;

/*
** Commit...
*/
COMMIT WORK;

/*
** List the status of the job.
*/
SELECT a.*
  FROM ninja_jobs a
 WHERE a.exec_method = 'processChangeRatingAndSocs'
   AND a.machine_id  = 'NINJAP2_DEMON'
;

