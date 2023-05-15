-- REM INSERTING into table_export
Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED) values ('NINJAST2_HGU',0,'SLEEPING','Y',5000,to_timestamp('02-FEB-11','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('02-FEB-11','DD-MON-RR HH.MI.SSXFF AM'),null,'MASTER','HGU: Master Job - Håkan''s local ST Server','N',null);
Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED) values ('NINJAST2_HGU',1,'STOPPED','N',35000,to_timestamp('19-JUN-08','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('19-JUN-08','DD-MON-RR HH.MI.SSXFF AM'),null,'statusManipulator','HGU: Batch update of subscriber status - Stream 1','N',null);
Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED) values ('NINJAST2_HGU',2,'STOPPED','N',45000,to_timestamp('19-JUN-08','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('19-JUN-08','DD-MON-RR HH.MI.SSXFF AM'),null,'masterManipulator','HGU: Batch Soc updates - stream 1','N',null);
Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED) values ('NINJAST2_HGU',3,'STOPPED','N',60000,to_timestamp('19-JUN-08','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('19-JUN-08','DD-MON-RR HH.MI.SSXFF AM'),null,'masterXLDBProcessor','HGU: XLDB Processor','N',null);
Insert into ninja_jobs (MACHINE_ID,JOB_ID,JOB_STATUS,WAS_RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,STATUS_DESC,EXEC_METHOD,JOB_DESC,FIXED_START,HLR_BASED) values ('NINJAST2_HGU',4,'STOPPED','N',3600000,to_timestamp('19-JUN-08','DD-MON-RR HH.MI.SSXFF AM'),to_timestamp('19-JUN-08','DD-MON-RR HH.MI.SSXFF AM'),null,'populateServiceTransactions','HGU: Populates the table ''service_transaction''','N',null);

-- REM INSERTING into table_export
Insert into NINJA_JOBS_PARAMETERS (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION) values ('NINJAST2_HGU',1,1,'NinjaInternal','Weblogic User Parameter');
Insert into NINJA_JOBS_PARAMETERS (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION) values ('NINJAST2_HGU',1,2,'1','Stream');
Insert into NINJA_JOBS_PARAMETERS (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION) values ('NINJAST2_HGU',2,1,'NinjaInternal','Weblogic User Parameter');
Insert into NINJA_JOBS_PARAMETERS (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION) values ('NINJAST2_HGU',2,2,'1','Stream');
Insert into NINJA_JOBS_PARAMETERS (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION) values ('NINJAST2_HGU',3,1,'NinjaInternal','Weblogic User Parameter');
INSERT INTO NINJA_JOBS_PARAMETERS (MACHINE_ID,JOB_ID,PARAMETER_ORDER,PARAMETER_VALUE,PARAMETER_DESCRIPTION) VALUES ('NINJAST2_HGU',4,1,'NinjaInternal','Weblogic User Parameter');

update system_defaults a
   set a.value = 'N'
 where a.key = 'USE_RULE_MANAGER_FOR_MAPPINGS';

select a.* from system_defaults a
 where key = 'USE_RULE_MANAGER_FOR_MAPPINGS';

--
UPDATE ninjaconfig.ninja_jobs a
   set a.next_exec_time = trunc(SYSDATE)
 WHERE a.exec_method = 'masterManipulator'
   AND a.machine_id  = 'NINJAP2Z_DEMON'
   AND a.job_id      = 50;


UPDATE ninjadata.master_tran_feature_parms a
   set a.value = 'mdataxus'
   where a.parameter_code = 'M2M-APN'
     and a.value = 'MDATAXUS'
     and a.trans_number in (
       select b.trans_number
  FROM ninjadata.master_transactions b
  WHERE b.request_id     IN ('TJP 28.03.2011')
  );


SELECT	*
 FROM	feature_parameters
 WHERE soc = 'M2MVPN'
   AND feature_code = 'S-M2MV'
   AND parameter_code = 'M2M-APN';


SELECT a.apn, a.call_characteristic, a.apn_short_name, a.csm_displ_ind
  FROM access_point_name@prod a
  where a.apn like 'm%'
  order by a.apn;
;


SELECT a.subscriber_no, a.soc, a.action_code, a.status_desc
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TJP 28.03.2011'
    AND a.process_status = 'PRSD_ERROR'
  ORDER BY a.subscriber_no;

UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
--     , a.stream = '1'
  WHERE a.request_id     = 'TJP 28.03.2011'
    AND a.process_status = 'PRSD_ERROR'
    AND (a.status_desc    LIKE '%No Jolt connections available%'
      OR a.status_desc    LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc    LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc    LIKE '%Please try accessing account again later%'
      OR a.status_desc    LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service:%'
      OR a.status_desc    LIKE '%not connected to ORACLE%'
      OR a.status_desc    LIKE '%Tuxedo server%service is down%'
      OR a.status_desc    LIKE '%weblogic.common.resourcepool.ResourceLimitException%'
    );

SELECT a.subscriber_no, a.new_ban, a.new_priceplan, a.new_campaign_code, a.status_desc
  FROM ninjadata.batch_move_subscribers a
 WHERE a.request_id IN ('NPMig')
   AND a.request_user_id IN ('arfr1723')
   AND a.process_status = 'PRSD_ERROR'
   AND a.status_desc like '%identical%'
;


SELECT a.subscriber_no, a.new_ban, a.new_priceplan, a.new_campaign_code, a.process_status
  FROM ninjadata.batch_move_subscribers a
 WHERE a.subscriber_no = 'GSM04741121380'
order by a.subscriber_no;

update ninjadata.batch_move_subscribers a
   set a.process_time = NULL, a.status_desc = NULL, a.process_status = 'WAITING'
 WHERE a.subscriber_no = 'GSM04741121380'


---
SELECT a.ban, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date
  FROM service_agreement@prod a
  WHERE a.ban = 
    --AND a.subscriber_no = '00000000
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2011-03-15', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
  ORDER BY a.ban, a.soc;