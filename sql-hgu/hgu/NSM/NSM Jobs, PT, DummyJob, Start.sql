/*
update nsm_jobs a
   set a.job_status = 'STOPPING'
 where a.job_id      = 666
   and a.job_status IN ( 'STARTING', 'RUNNING', 'SLEEPING' )
;
*/

update nsm_jobs a
   set a.job_status = 'STARTING'
 where a.job_id      = 666
   and a.job_status IN ( 'STOPPED' )
;

commit work
;
