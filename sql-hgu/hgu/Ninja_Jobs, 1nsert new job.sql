-- Check the nr of active jobs on each server, in order to choose where to put
-- the new job.
SELECT A.machine_id, count(1) AS "COUNT"
  FROM ninja_jobs A
 WHERE A.job_status IN ( 'RUNNING', 'SLEEPING', 'STARTING' )
   AND A.machine_id IN ( 'NINJAP1_DEMON', 'NINJAP2_DEMON' ) -- Comment out and change in test-environments
GROUP BY A.machine_id
ORDER BY A.machine_id
;

/*
2021-05-03:
NINJAP1_DEMON	81
NINJAP2_DEMON	70
*/

-- Display the job_id's on use on the selected server.
SELECT A.machine_id, a.job_id
  FROM ninja_jobs A
 WHERE A.machine_id IN ( 'NINJAP2_DEMON' )
ORDER BY 1,2
;

-- Insert rows into ninja_jobs and ninja_jobs_parameters
INSERT INTO ninja_jobs (machine_id,job_id,job_status,was_running,sleep_time,next_exec_time,status_time,status_desc,exec_method,job_desc,fixed_start,hlr_based)
VALUES ('NINJAP2_DEMON',104,'STOPPED','N','3600000',trunc(SYSDATE),trunc(SYSDATE),NULL,'BatdhJobFaceMethodName','Short description','N',NULL);

INSERT INTO ninja_jobs_parameters (machine_id,job_id,parameter_order,parameter_value,parameter_description)
VALUES ('NINJAP2_DEMON',104,'1','NinjaInternal','Weblogic User Parameter');

-- List the job
SELECT A.*
  FROM ninja_jobs A
 WHERE A.machine_id = 'NINJAP2_DEMON'
   AND a.job_id     = 104
ORDER BY 1,2
;

-- if everything looks ok, commit, then start the job.
UPDATE ninja_jobs A
   set a.job_status = 'STARTING' 
 WHERE A.machine_id = 'NINJAP2_DEMON'
   AND a.job_id     = 104
;

-- You should be done. Re-run the listing, and if it looks ok, commit, and re-run.
