SELECT sysdate as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaatconfig.ninja_jobs a
  WHERE a.machine_id = 'NINJAA1_DEMON'
    AND a.exec_method IN ('numberReleaser', 'numberReconciler')
    
