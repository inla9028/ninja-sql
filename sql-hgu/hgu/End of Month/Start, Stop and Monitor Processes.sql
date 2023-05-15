--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Check the status of the associated worker threads/processes.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SYSDATE AS "NOW", a.machine_id, a.job_id, a.job_status, a.sleep_time,
       a.next_exec_time, a.status_desc, a.exec_method, a.job_desc
  FROM ninjaconfig.ninja_jobs a
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id IN (22, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
     OR (a.machine_id = 'NINJAP1Z_DEMON' AND a.job_id = 8)
  ORDER BY a.machine_id, a.job_id;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Updates the status of the monthly batch-jobs to 'STARTING',
--== which causes the demon engine to start the processes.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STARTING'
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id         IN (22, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    AND a.job_status NOT IN ('RUNNING', 'STOPPING', 'SLEEPING');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Resumes any sleeping additional 'batch charge addition' processes
--== since we don't want to wait the configured 60 seconds (at most).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = SYSDATE - 0.1
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id     IN (9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    AND a.job_status IN ('SLEEPING');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Runs the 'monthly refill helper' job immidiately, instead of waiting
--== 10 minutes until next run...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = TRUNC(SYSDATE)
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id     = 22
    AND a.job_status = 'SLEEPING';

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Sets the workers to start 3 minutes after the Monthly Refill Helper.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = (
    SELECT b.next_exec_time + (3 / 1440) 
      FROM ninjaconfig.ninja_jobs b
      WHERE b.job_id = 22
    )
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id     IN (9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    AND a.job_status IN ('SLEEPING');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Schedule the jobs to start at 10:00 the last day of the current month. --==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STARTING', a.next_exec_time = LAST_DAY(TRUNC(SYSDATE) + 600/1440)
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id         IN (22, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    AND a.job_status NOT IN ('RUNNING', 'STOPPING', 'SLEEPING');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Stops the 'monthly refill helper' job, as well as the additional 
--== 'batch charge addition' processes.
--== Note! We have a trigger that sets the stream-value for new records
--==       on the 1st of every month; ergo executing this call, will require
--==       manual handling of those records the day after!
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninja_jobs a
  SET a.job_status    = 'STOPPING'
  WHERE a.machine_id  = 'NINJAP2Z_DEMON'
    AND a.job_id     IN (22, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18);
--COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Stops the 'monthly refill helper' job, leaving the additional 
--== 'batch charge addition' processes running in order to handle
--== the 'first of month' job the day after...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninja_jobs a
  SET a.job_status   = 'STOPPING'
  WHERE a.machine_id = 'NINJAP2Z_DEMON'
    AND a.job_id     = 22;

