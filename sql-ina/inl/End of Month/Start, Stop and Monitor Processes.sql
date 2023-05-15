--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--== Check the status of stream 1
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT * 
FROM ninja_jobs a
WHERE a.machine_id = 'NINJAP2Z_DEMON'
AND a.exec_method= 'batchChargeAddition'


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--== Check the status of the associated worker threads/processes.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT *
  FROM ninja_jobs a
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id IN (22, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
  ORDER BY a.job_id


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--== Updates the status of the monthly batch-jobs to 'STARTING',
--==--== which causes the demon engine to start the processes.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STARTING'
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id IN (22, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    AND a.job_status NOT IN ('RUNNING', 'STOPPING', 'SLEEPING')

--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = SYSDATE - 0.1
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id IN (9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    AND a.job_status IN ('SLEEPING')
    

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--== Updates the status of the monthly batch-jobs to 'STOPPING',
--==--== which causes the demon engine to halt the processes.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninja_jobs
  SET job_status = 'STOPPING'
  WHERE machine_id = 'NINJAP2Z_DEMON'
    AND job_id IN (22, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18);
--COMMIT WORK;


