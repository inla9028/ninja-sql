INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 1                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 1                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 2                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 2                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 3                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 3                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 4                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 4                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 5                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 5                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 6                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 6                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 7                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 7                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 8                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 8                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 9                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 9                   AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'ADD'               AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 10                  AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;

INSERT INTO master_transactions
SELECT NULL                AS TRANS_NUMBER
     , a.subscriber_no
     , 'ODBCPA'            AS SOC
     , 'DELETE'            AS ACTION_CODE
     , NULL                AS NEW_SOC
     , SYSDATE             AS ENTER_TIME
     , SYSDATE             AS REQUEST_TIME
     , NULL                AS PROCESS_TIME
     , 'WAITING'           AS PROCESS_STATUS
     , NULL                AS STATUS_DESC
     , 'NET'               AS DEALER_CODE
     , 'A'                 AS SALES_AGENT
     , 1                   AS "PRIORITY"
     , 'HGU 2019-11-21'    AS REQUEST_ID
     , 'Stress-test in PT' AS MEMO_TEXT
     , 'Y'                 AS WAIVE_ACT_FEE
     , 10                  AS STREAM
  FROM mw_tmp_trans a
 WHERE a.soc = 'PXXX'
;
