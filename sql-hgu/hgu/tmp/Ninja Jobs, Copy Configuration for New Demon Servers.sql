INSERT INTO ninja_jobs
SELECT REPLACE(nj.machine_id, 'Z_DEMON', '_DEMON') AS "MACHINE_ID"
     , nj.job_id, nj.job_status, nj.was_running
     , nj.sleep_time, nj.next_exec_time, nj.status_time, nj.status_desc
     , nj.exec_method, nj.job_desc, nj.fixed_start, nj.hlr_based
  FROM ninja_jobs nj
 WHERE nj.machine_id IN ('NINJAP1Z_DEMON','NINJAP2Z_DEMON')
   AND nj.job_id != 0
ORDER BY 1,2
;

INSERT INTO ninja_jobs_parameters
SELECT REPLACE(njp.machine_id, 'Z_DEMON', '_DEMON') AS "MACHINE_ID"
     , njp.job_id, njp.parameter_order, njp.parameter_value
     , njp.parameter_description
  FROM ninja_jobs_parameters njp
 WHERE njp.machine_id IN ('NINJAP1Z_DEMON','NINJAP2Z_DEMON')
   AND njp.job_id != 0
ORDER BY 1,2,3

;

SELECT nj.machine_id, nj.job_status, count(1) AS "COUNT"
  FROM ninja_jobs nj
GROUP BY nj.machine_id, nj.job_status
ORDER BY 1, 2
;

