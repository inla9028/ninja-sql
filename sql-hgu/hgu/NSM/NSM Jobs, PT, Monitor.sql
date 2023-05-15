SELECT a.hostname, a.job_id, a.job_status,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", 
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME",
       LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME",
       a.job_fqcn, a.running, a.fixed_start
  FROM nsm_jobs a
ORDER BY a.hostname, a.job_id
;

select a.*
  from nsm_jobs a
order by a.hostname, a.job_id
;


update nsm_jobs a
   set a.sleep_time  = 60000
 where a.job_id      = 666
   and a.job_status IN ( 'STARTING', 'RUNNING', 'SLEEPING' )
;

update nsm_jobs a
   set a.job_status = 'STOPPING'
 where a.job_id      = 666
   and a.job_status IN ( 'STARTING', 'RUNNING', 'SLEEPING' )
;


update nsm_jobs a
   set a.job_status = 'STARTING'
 where a.job_id      = 1
   and a.job_status IN ( 'STOPPED' )
;


update nsm_jobs a
   set a.running     = 'N'
 where a.job_id      = 1
   and a.running     = 'Y'
;

update nsm_jobs a
   set a.job_fqcn    = 'Controller'
 where a.job_id      = 0
;