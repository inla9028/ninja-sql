select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJAP1_DEMON'
   and a.job_id     = 104
order by 1,2
;

Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED)
values ('NINJAP1_DEMON','104','STOPPED','N','60000',TRUNC(SYSDATE),TRUNC(SYSDATE),null,'batchTreeDiscount','Add or Delete BAN tree discounts','N',null);

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJAP1_DEMON','104','1','NinjaInternal','Weblogic User Parameter');

select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJAP1_DEMON'
   and a.job_id     = 104
order by 1,2
;

update ninja_jobs a
   set a.job_status = 'STARTING'
 where a.machine_id = 'NINJAP1_DEMON'
   and a.job_id     = 104
;
