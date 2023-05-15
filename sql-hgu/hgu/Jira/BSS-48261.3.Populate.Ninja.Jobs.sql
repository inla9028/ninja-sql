Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED)
values ('NINJAP1_DEMON','105','STARTING','N','60000',TRUNC(SYSDATE),TRUNC(SYSDATE),null,'batchExternalChargesExtract','Extract external charges from Fokus','N',null);

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJAP1_DEMON','105','1','NinjaInternal','Weblogic User Parameter');

Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED)
values ('NINJAP1_DEMON','106','STARTING','N','60000',TRUNC(SYSDATE),TRUNC(SYSDATE),null,'batchExternalChargesUpdate','Update Fokus with results of External Charges (Vipps)','N',null);

Insert into ninja_jobs_parameters (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION)
values ('NINJAP1_DEMON','106','1','NinjaInternal','Weblogic User Parameter');
