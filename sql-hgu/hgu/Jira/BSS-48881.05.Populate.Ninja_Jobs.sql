select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJAP2_DEMON'
   and a.job_id    IN ( 96, 97, 98 )
order by 1,2
;

/*
96: public static final void batchExtractNewVouchers(final int jobId, final String user) throws NinjaException {
97: public static final void batchExtractExistingVouchers(final int jobId, final String user) throws NinjaException {
98: public static final void batchProcessVouchers(final int jobId, final String user) throws NinjaException {
*/

Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED)
values ('NINJAP2_DEMON',96,'STOPPED','N','900000',TRUNC(SYSDATE),TRUNC(SYSDATE),null,'batchExtractNewVouchers','Extract new SOCs eligable for vouchers','N',null);

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJAP2_DEMON',96,'1','NinjaInternal','Weblogic User Parameter');


Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED)
values ('NINJAP2_DEMON',97,'STOPPED','N','3600000',TRUNC(SYSDATE),TRUNC(SYSDATE),null,'batchExtractExistingVouchers','Extract existing SOCs eligable for vouchers','N',null);

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJAP2_DEMON',97,'1','NinjaInternal','Weblogic User Parameter');


Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED)
values ('NINJAP2_DEMON',98,'STOPPED','N','900000',TRUNC(SYSDATE),TRUNC(SYSDATE),null,'batchProcessVouchers','Process vouchers into Prepaid/Kontant','N',null);

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJAP2_DEMON',98,'1','NinjaInternal','Weblogic User Parameter');



select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJAP2_DEMON'
   and a.job_id    IN ( 96, 97, 98 )
order by 1,2
;

update ninja_jobs a
   set a.job_status = 'STARTING'
 where a.machine_id = 'NINJAP2_DEMON'
   and a.job_id    IN ( 96, 97, 98 )
;

--
-- PT
--
/*

select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJA_PT2_SH1'
   and a.job_id     = 95
order by 1,2
;

Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED)
values ('NINJA_PT2_SH1',96,'STOPPED','N','60000',TRUNC(SYSDATE),TRUNC(SYSDATE),null,'batchReplaceSocsKeepExpDates','Replace SOCs while keeping exp dates','N',null);

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJA_PT2_SH1',96,'1','NinjaInternal','Weblogic User Parameter');

select a.*
  from ninja_jobs a
 where a.machine_id = 'NINJA_PT2_SH1'
   and a.job_id     = 95
order by 1,2
;

update ninja_jobs a
   set a.job_status = 'STARTING'
 where a.machine_id = 'NINJA_PT2_SH1'
   and a.job_id     = 95
;

*/
