select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJAP2_DEMON'
   and a.job_id     = 100
order by 1,2
;

Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED)
values ('NINJAP2_DEMON','100','STOPPED','N','60000',TRUNC(SYSDATE),TRUNC(SYSDATE),null,'batchProcessSocs','Process socs (add/delete/modify)','N',null);

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJAP2_DEMON','100','1','NinjaInternal','Weblogic User Parameter');

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJAP2_DEMON','100','2','10','Thread Count');


select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJAP2_DEMON'
   and a.job_id     = 100
order by 1,2
;

update ninja_jobs a
   set a.job_status = 'STARTING'
 where a.machine_id = 'NINJAP2_DEMON'
   and a.job_id     = 100
;

--
-- PT
--
/*

select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJA_PT2_SH1'
   and a.job_id     = 100
order by 1,2
;

Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED)
values ('NINJA_PT2_SH1','100','STOPPED','N','60000',TRUNC(SYSDATE),TRUNC(SYSDATE),null,'batchReplaceSocsKeepExpDates','Replace SOCs while keeping exp dates','N',null);

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJA_PT2_SH1','100','1','NinjaInternal','Weblogic User Parameter');

select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJA_PT2_SH1'
   and a.job_id     = 100
order by 1,2
;

update ninja_jobs a
   set a.job_status = 'STARTING'
 where a.machine_id = 'NINJA_PT2_SH1'
   and a.job_id     = 100
;

*/
