SELECT a.schema_name, a.table_name, a.column_name, a.data_type,
       a.retention_column, a.retention_days, a.effective_date,
       a.expiration_date, a.comments
  FROM gdpr_table_overview a
order by 1,2,3
;

INSERT INTO gdpr_table_overview 
VALUES('NINJADATA','TMP_GDPR_TEST','BAN_NO','BAN',NULL,NULL,TO_DATE('2017-11-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2017-12-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Transactions to do _this_ ....');

INSERT INTO gdpr_table_overview 
VALUES('NINJADATA','TMP_GDPR_TEST','SUBSCRIBER_NO','CTN',NULL,NULL,TO_DATE('2017-11-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-03-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Transactions to do _that_ ...');

INSERT INTO gdpr_table_overview 
VALUES('NINJADATA','TMP_GDPR_TEST','SIM_NO','SIM',NULL,NULL,TO_DATE('2017-11-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-03-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Transactions to do _this_ AND _that_ ...');

INSERT INTO gdpr_table_overview 
VALUES('NINJADATA','TMP_GDPR_TEST',NULL,NULL,'PROCESS_TIME',90,TO_DATE('2017-11-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-03-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Transactions to do _this_ AND _that_ ...');


-- Trigger validationt tests
INSERT INTO gdpr_table_overview 
VALUES('NINJADATA','TMP_GDPR_TEST','FAKE_COLUMN',NULL,NULL,90,TO_DATE('2017-11-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-03-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),'Transactions to do _this_ AND _that_ ...');

UPDATE gdpr_table_overview a
   SET a.retention_days = NULL
 WHERE a.retention_days IS NOT NULL
;
