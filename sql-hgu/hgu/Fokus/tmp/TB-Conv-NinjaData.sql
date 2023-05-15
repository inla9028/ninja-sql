select a.*
  from ninjaconfig_at.ninja_jobs a
 where a.exec_method = 'masterManipulator'
   and a.machine_id  = 'NINJAAT2_SH1'
;

select a.*
  from master_transactions a
 where 1 = 1
--   and a.SUBSCRIBER_NO = 'GSM04791794244'
   and a.REQUEST_ID = 'Test-TB-CONV'
;

select a.*
  from master_transactions a
 where a.trans_number = (select max(trans_number) from master_transactions)
;

Insert into master_transactions (TRANS_NUMBER,SUBSCRIBER_NO,SOC,ACTION_CODE,NEW_SOC,ENTER_TIME,REQUEST_TIME,PROCESS_TIME,PROCESS_STATUS,STATUS_DESC,DEALER_CODE,SALES_AGENT,PRIORITY,REQUEST_ID,MEMO_TEXT,WAIVE_ACT_FEE,STREAM)
values (1647,'GSM04740722421','MCTBFREE','ADD',null,null,null,null,'WAITING',null,'NENI','A',1,'Test-TB-CONV',null,null,'1');

Insert into MASTER_TRAN_FEATURES (TRANS_NUMBER,FEATURE_CODE) values (1647,'M-VPT2');
Insert into MASTER_TRAN_FEATURES (TRANS_NUMBER,FEATURE_CODE) values (1647,'CUG');


Insert into MASTER_TRAN_FEATURE_PARMS (TRANS_NUMBER,FEATURE_CODE,PARAMETER_CODE,VALUE) values (1647,'M-VPT2','VPN','10284');
Insert into MASTER_TRAN_FEATURE_PARMS (TRANS_NUMBER,FEATURE_CODE,PARAMETER_CODE,VALUE) values (1647,'CUG',' CUG','I AL');
