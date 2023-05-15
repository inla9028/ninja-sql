SELECT a.*
  FROM WH_SAS.W_SMS_TAB_PRD@wh12p a
 WHERE a.TIMESTAMP > trunc(SYSDATE)
--   AND ROWNUM < 11
;

SELECT a.*
  FROM WH_SAS.W_SMS_TAB_PRD@wh12p a
 WHERE a.TIMESTAMP > trunc(SYSDATE)
--   AND ROWNUM < 11
;

SELECT a.*
  FROM w_sms_dwh a
 WHERE a.msisdn = '4798062217'
   AND a.process_status = 'PRSD_SUCCESS'
;

SELECT a.*
  FROM w_sms_dwh a
 WHERE a.process_status = 'WAITING'
;

SELECT a.process_status, COUNT(1) AS "COUNT"
  FROM w_sms_dwh a
 WHERE a.process_status = 'WAITING'
GROUP BY a.process_status
ORDER BY 1
;


-- Show the latest entries...
SELECT a.*
  FROM w_sms_dwh a
 WHERE a.timestamp > (
     SELECT max(b.timestamp) - (1/96)
       FROM w_sms_dwh b)
;

/*
** Ninja query
*/
SELECT ROWID
     , timestamp AS "TIMESTAMP"
     , imsi      AS "IMSI"
     , msisdn    AS "MSISDN"
     , ppn       AS "SENDER"
     , sms       AS "SMS"
  FROM w_sms_dwh
 WHERE process_status = 'WAITING'
   AND ROWNUM < 11
;

-- Table
SELECT ROWID
     , timestamp AS "TIMESTAMP"
     , imsi      AS "IMSI"
     , msisdn    AS "MSISDN"
     , ppn       AS "SENDER"
     , sms       AS "SMS"
  FROM W_SMS_TAB_PRD@wh12p
 WHERE process_status = 'WAITING'
   AND ROWNUM < 11
;

-- View, should return 10 rows with status WAITING.
SELECT a.ROWID
     , a.imsi      AS "IMSI"
     , a.msisdn    AS "MSISDN"
     , a.ppn       AS "SENDER"
     , a.sms       AS "SMS"
     , a.timestamp AS "TIMESTAMP"
  FROM W_SMS_TAB_PRD_W@wh12p a
;

SELECT a.w_rowid   AS "ROWID"
     , a.imsi      AS "IMSI"
     , a.msisdn    AS "MSISDN"
     , a.ppn       AS "SENDER"
     , a.sms       AS "SMS"
     , a.timestamp AS "TIMESTAMP"
  FROM w_sms_dwh_read a
;

/*
** Ninja job.
*/
SELECT a.*
  FROM ninja_jobs a
 WHERE a.exec_method = 'processWelcomeSmsMemo'
   AND a.machine_id  = 'NINJAP2_DEMON'
;

/*
** Create new DB-Link.
*/
CREATE DATABASE LINK WH12P CONNECT TO NINJAMEMO IDENTIFIED BY EsPoNaLcTa USING 'WH12P';
/*
DROP   DATABASE LINK WH12P;
CREATE DATABASE LINK WH12P CONNECT TO RESYS     IDENTIFIED BY RESYS      USING 'WH12P';
*/
/*
** Update synonym...
*/
CREATE OR REPLACE SYNONYM w_sms_dwh
  FOR w_sms_tab_prd@wh12p
;

CREATE OR REPLACE SYNONYM w_sms_dwh_read
  FOR w_sms_tab_prd_w@wh12p
;

CREATE OR REPLACE SYNONYM w_sms_dwh_write
  FOR w_sms_tab_prd@wh12p
;

