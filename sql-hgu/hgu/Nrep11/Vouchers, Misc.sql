--
-- Test using a single subscription.
--
SELECT A.ban
     , A.subscriber_no
     , A.soc
     , rtrim(f.feature_code)                    AS "FEATURE"
     , NULL                                     AS "FREQUENCY"
     , substr(f.ftr_add_sw_prm, LENGTH('PRODUCT_ID=')     + instr(f.ftr_add_sw_prm, 'PRODUCT_ID='),     instr(substr(f.ftr_add_sw_prm, LENGTH('PRODUCT_ID=')     + instr(f.ftr_add_sw_prm, 'PRODUCT_ID=')),     '@') - 1) AS "PRODUCT_ID"
     , substr(f.ftr_add_sw_prm, LENGTH('PRODUCT_TYPE=')   + instr(f.ftr_add_sw_prm, 'PRODUCT_TYPE='),   instr(substr(f.ftr_add_sw_prm, LENGTH('PRODUCT_TYPE=')   + instr(f.ftr_add_sw_prm, 'PRODUCT_TYPE=')),   '@') - 1) AS "PRODUCT_TYPE"
     , substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_AMT=')   + instr(f.ftr_add_sw_prm, 'RECHARGE_AMT='),   instr(substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_AMT=')   + instr(f.ftr_add_sw_prm, 'RECHARGE_AMT=')),   '@') - 1) AS "RECHARGE_AMOUNT"
     , substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_COUNT=') + instr(f.ftr_add_sw_prm, 'RECHARGE_COUNT='), instr(substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_COUNT=') + instr(f.ftr_add_sw_prm, 'RECHARGE_COUNT=')), '@') - 1) AS "RECHARGE_COUNT"
     , substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_UNIT=')  + instr(f.ftr_add_sw_prm, 'RECHARGE_UNIT='),  instr(substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_UNIT=')  + instr(f.ftr_add_sw_prm, 'RECHARGE_UNIT=')),  '@') - 1) AS "RECHARGE_UNIT"
     , substr(f.ftr_add_sw_prm, LENGTH('SEND_SMS=')       + instr(f.ftr_add_sw_prm, 'SEND_SMS='),       instr(substr(f.ftr_add_sw_prm, LENGTH('SEND_SMS=')       + instr(f.ftr_add_sw_prm, 'SEND_SMS=')),       '@') - 1) AS "SMS"
     , c.cycle_start_date AS "VALID_FROM"
     , c.cycle_close_date AS "VALID_TO"
     , 'HGU ' || to_char(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , NULL                                     AS "ENTER_TIME"
     , NULL                                     AS "REQUEST_TIME"
     , 'ON_HOLD'                                AS "PROCESS_STATUS"
  FROM tmp_msisdns_w_status_pp_soc A, service_feature f, billing_account b, cycle_control@p01ol1 c
 WHERE A.subscriber_no = 'GSM04793226034'
   AND A.subscriber_no = f.subscriber_no
   AND A.ban           = f.ban
   and SYSDATE BETWEEN f.ftr_effective_date AND nvl(f.ftr_expiration_date, SYSDATE + 1)
   AND A.soc           = rtrim(f.soc)
   AND rtrim(f.feature_code) = 'S-VOUC'
   AND b.ban           = A.ban
   AND b.bill_cycle    = c.cycle_code
   AND trunc(SYSDATE) BETWEEN c.cycle_start_date and c.cycle_close_date
;

-- PRODUCT_TYPE=DATABOOST@RECHARGE_UNIT=MIN@SEND_SMS=N@RECHARGE_COUNT=2@PRODUCT_ID=TOPUP_B2C_DA_BOOST_180_FREE@RECHARGE_AMT=180@
-- BAN, SUBSCRIBER_NO, SOC, FEATURE, FREQUENCY, PRODUCT_ID, PRODUCT_TYPE, RECHARGE_AMOUNT, RECHARGE_COUNT, RECHARGE_UNIT, SMS, VALID_FROM, VALID_TO, REQUEST_ID

SELECT A.*
  FROM tmp_msisdns_w_status_pp_soc A
 WHERE A.subscriber_no = 'GSM04793226034'
;

--
-- Delete non-active subscriptions.
--
DELETE
  FROM tmp_msisdns_w_status_pp_soc@nrep11 a
 WHERE A.sub_status IN ( 'R', 'S' )
;
--
-- Delete duplicates...
--
DELETE
  FROM tmp_msisdns_w_status_pp_soc@nrep11 A
 WHERE 0 < (SELECT count(1)
              FROM batch_voucher v
             WHERE v.ban = A.ban
               AND v.subscriber_no = A.subscriber_no
               AND trunc(SYSDATE) BETWEEN v.valid_from AND v.valid_to)
; 

--
-- Insert from Ninja....
--
INSERT INTO batch_voucher
WITH cc_filter AS (
  SELECT c.cycle_code, c.cycle_start_date, c.cycle_close_date
    FROM cycle_control@fokus c
   WHERE trunc(SYSDATE) BETWEEN c.cycle_start_date AND c.cycle_close_date
)
SELECT A.ban
     , A.subscriber_no
     , A.soc
     , rtrim(f.feature_code)                    AS "FEATURE"
     , NULL                                     AS "FREQUENCY"
     , substr(f.ftr_add_sw_prm, LENGTH('PRODUCT_ID=')     + instr(f.ftr_add_sw_prm, 'PRODUCT_ID='),     instr(substr(f.ftr_add_sw_prm, LENGTH('PRODUCT_ID=')     + instr(f.ftr_add_sw_prm, 'PRODUCT_ID=')),     '@') - 1) AS "PRODUCT_ID"
     , substr(f.ftr_add_sw_prm, LENGTH('PRODUCT_TYPE=')   + instr(f.ftr_add_sw_prm, 'PRODUCT_TYPE='),   instr(substr(f.ftr_add_sw_prm, LENGTH('PRODUCT_TYPE=')   + instr(f.ftr_add_sw_prm, 'PRODUCT_TYPE=')),   '@') - 1) AS "PRODUCT_TYPE"
     , substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_AMT=')   + instr(f.ftr_add_sw_prm, 'RECHARGE_AMT='),   instr(substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_AMT=')   + instr(f.ftr_add_sw_prm, 'RECHARGE_AMT=')),   '@') - 1) AS "RECHARGE_AMOUNT"
     , substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_COUNT=') + instr(f.ftr_add_sw_prm, 'RECHARGE_COUNT='), instr(substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_COUNT=') + instr(f.ftr_add_sw_prm, 'RECHARGE_COUNT=')), '@') - 1) AS "RECHARGE_COUNT"
     , substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_UNIT=')  + instr(f.ftr_add_sw_prm, 'RECHARGE_UNIT='),  instr(substr(f.ftr_add_sw_prm, LENGTH('RECHARGE_UNIT=')  + instr(f.ftr_add_sw_prm, 'RECHARGE_UNIT=')),  '@') - 1) AS "RECHARGE_UNIT"
     , substr(f.ftr_add_sw_prm, LENGTH('SEND_SMS=')       + instr(f.ftr_add_sw_prm, 'SEND_SMS='),       instr(substr(f.ftr_add_sw_prm, LENGTH('SEND_SMS=')       + instr(f.ftr_add_sw_prm, 'SEND_SMS=')),       '@') - 1) AS "SMS"
     , c.cycle_start_date AS "VALID_FROM"
     , c.cycle_close_date AS "VALID_TO"
     , 'HGU ' || to_char(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , NULL                                     AS "ENTER_TIME"
     , NULL                                     AS "REQUEST_TIME"
     , NULL                                     AS "PROCESS_TIME"
     , 'ON_HOLD'                                AS "PROCESS_STATUS"
     , NULL                                     AS "STATUS_DESC"
  FROM tmp_msisdns_w_status_pp_soc@nrep11 A, service_feature@nrep11 f, billing_account@nrep11 b, cc_filter c
 WHERE A.subscriber_no = f.subscriber_no
   AND A.ban           = f.ban
   and SYSDATE BETWEEN f.ftr_effective_date AND nvl(f.ftr_expiration_date, SYSDATE + 1)
   AND A.soc           = rtrim(f.soc)
   AND rtrim(f.feature_code) = 'S-VOUC'
   AND b.ban           = A.ban
   AND b.bill_cycle    = c.cycle_code
;

SELECT a.process_status, count(1) AS "COUNT"
  FROM batch_voucher A
 WHERE A.request_id = 'HGU ' || to_char(SYSDATE, 'YYYY-MM-DD')
GROUP BY A.process_status
ORDER BY A.process_status
;

UPDATE batch_voucher A
   SET A.process_status = 'WAITING'
 WHERE A.request_id     = 'HGU ' || to_char(SYSDATE, 'YYYY-MM-DD')
   AND A.process_status = 'ON_HOLD'
;

UPDATE ninja_jobs A
   SET A.next_exec_time = SYSDATE
 WHERE A.machine_id     = 'NINJAP2_DEMON'
   AND A.job_id         = 98
   AND A.job_status     = 'SLEEPING'
;