select to_char(a.status_time, 'YYYY-MM-DD HH24:MI:SS') AS "STAT_TIME",
       a.*
  from ninja_jobs a
 where a.machine_id = 'NINJAST2_HGU'
--  and a.job_status != 'STOPPED'
order by a.job_id
;

update ninja_jobs a
   set a.was_running = 'Y'
 where a.machine_id  = 'NINJAST2_HGU'
   and a.job_id      = 1
;

update ninja_jobs a
   set a.job_status = 'STOPPING'
 where a.machine_id  = 'NINJAST2_HGU'
   and a.job_id      = 0
;

