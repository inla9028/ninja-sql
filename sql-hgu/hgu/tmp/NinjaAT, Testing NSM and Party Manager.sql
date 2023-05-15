select a.*
  from nsm_jobs a
order by 1,2
;

update nsm_jobs a
   set a.running = 'Y'
 where a.job_id  = 1
;

update nsm_jobs a
   set a.running = 'N'
 where a.job_id  = 13
;

update nsm_jobs a
   set a.job_status = 'STARTING'
 where a.job_id     = 12
;


select a.*
  from party_mgr_pid_update a
 where a.request_id IN ( 61 )
order by a.request_id
;

update party_mgr_pid_update a
   set a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
 where a.request_id IN ( 61 )
;

update party_mgr_pid_update a
   set a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
 where a.request_id IN ( 39, 81, 82, 83 )
;

select a.*
  from external_charges a
;

update external_charges a
   set a.process_status = 'NEW', a.req_status = NULL, a.req_status_desc = NULL
  where a.subscriber_no = 'GSM04792653600'
;


Insert into NSM_JOBS (HOSTNAME,JOB_ID,JOB_STATUS,RUNNING,SLEEP_TIME,NEXT_EXEC_TIME,STATUS_TIME,FIXED_START,JOB_FQCN,JOB_ARG1,JOB_ARG2,JOB_ARG3,JOB_ARG4,JOB_ARG5)
values ('no-neo-at-01','13','STOPPED','Y','60000',to_date('2020-03-09 12:21','YYYY-MM-DD HH24:MI'),to_date('2020-03-16 16:17','YYYY-MM-DD HH24:MI'),'N','no.netcom.ipl.ninjasyncmanager.jobs.paymenthandler.PaymentHandlerChurnJob',null,null,null,null,null);


Insert into EXTERNAL_CHARGES (BAN,SUBSCRIBER_NO,SOC,SOC_SEQ_NO,REQUEST_SEQ_NO,ENTER_TIME,PROCESS_TIME,PROCESS_STATUS,STATUS_DESC,CHANNEL_TYPE,DEALER_CODE,PAYMENT_AGR_ID,PAYMENT_AMOUNT,PAYMENT_CHARGE_ID,PAYMENT_DESC,PAYMENT_DUE_DATE,PAYMENT_RETRY,PAYMENT_TYPE,PRODUCT_TYPE,PURCHASE_ID,REQ_STATUS,REQ_STATUS_DESC)
values ('401415906','GSM04792653600','NCVASM04','240778019','1',SYSDATE,NULL,'NEW',null,'INT_WEB','NENI','agr_BÆSJ','666','chr_BÆSJ','Show me da manny!',to_date('2020-03-18','YYYY-MM-DD'),'2','VippsAgreementPayment','RecurringChargeProduct',NULL,NULL,NULL);


select a.*
  from subscription_types_socs a
 where a.soc LIKE 'NCVASM%'
;

select a.*
  from feature_parameters a
 where a.soc LIKE 'NCVASM%'
order by 1,2,3,4
;

select a.*
  from soc@fokus a
 where a.soc like 'NCVASM%'
   and sysdate between a.effective_date and NVL(a.expiration_date, sysdate + 1)
order by 1
;

SELECT RTRIM (b.soc) AS "SOC", RTRIM(a.feature_code) AS "FEATURE_CODE"
     , a.switch_code, a.feature_type, a.feature_desc
  FROM feature@fokus a, rated_feature@fokus b
 WHERE RTRIM (b.soc) IN ('NCVASM05', 'NCVASM06')
   AND b.feature_code = a.feature_code
   AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;

SELECT s.subscriber_no, s.customer_id, s.sub_status, s.sub_status_date, a1.soc AS "PP"
  FROM subscriber@fokus s, service_agreement@fokus a1
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc        LIKE 'PSJP%'
   AND 0                = (SELECT COUNT(1)
                             FROM service_agreement@fokus a2
                            WHERE s.customer_id    = a2.ban
                              AND s.subscriber_no  = a2.subscriber_no
                              AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
                              AND a2.service_type  = 'G')
   AND ROWNUM           < 11
;



SELECT s.subscriber_no, s.customer_id, s.sub_status, s.sub_status_date, a1.soc AS "PP"
  FROM subscriber@fokus s, service_agreement@fokus a1
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc        LIKE 'PSJP%'
   AND 0                = (SELECT COUNT(1)
                             FROM service_agreement@fokus a2
                            WHERE a2.ban           = a1.ban
                              AND a2.subscriber_no = a1.subscriber_no
                              AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
                              AND a2.soc        LIKE 'NCVASM%')
                              
   AND ROWNUM           < 11
;

-- 94187132

-- Service Agreement; SOCs...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
  FROM service_agreement@fokus a, users@fokus u
 WHERE a.subscriber_no = 'GSM047'||'94187132'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Service Feature; Feature parameters...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date --, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, a.ftr_add_sw_prm
  FROM service_feature@fokus a
 WHERE a.subscriber_no = 'GSM047'||'94187132'
   AND   SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
   AND a.soc LIKE 'NCV%'
--   AND a.feature_code LIKE 'F-SWC%' -- Switch
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
--   AND a.ftr_add_sw_prm IS NOT NULL
ORDER BY a.ban, a.subscriber_no, a.soc, a.feature_code
;

SELECT /*+ driving_site(a)*/
       a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus a, users@fokus u
 WHERE a.memo_subscriber = 'GSM047'||'94187132'
   AND a.memo_date       > TRUNC(SYSDATE - 60, 'MON')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;

/*
I’m so … half-brained..
I’m documenting the 5th job (Churn) I need to write, and forgot some details you told me.

Look in table SUBSCRIPTION_SOC_RC for expired agreements.
If a subscription is moved, it receives a new soc sequence nr, so I guess I’d still need to check in 
SUBSCRIPTION_SOC_RC for other active records with the same EXT_AGREEMENT_ID and EXT_AGREEMENT_TYPE for the same SUBSCRIBER_NO?

If so I should cancel all expired agreements where no active agreements exists, and I could put that logic into a single query towards SUBSCRIPTION_SOC_RC.
09:12
(In theory, I guess I would only need to check against EXT_AGREEMENT_ID and EXT_AGREEMENT_TYPE , since they should be a unique combination.)


*/
SELECT rc1.ban,             rc1.subscriber_no,    rc1.soc
     , rc1.feature_code,    rc1.ext_agreement_id, rc1.ext_agreement_type
     , rc1.expiration_date
  FROM subscription_soc_rc@fokus rc1
 WHERE NVL(rc1.expiration_date, SYSDATE + 1) BETWEEN TRUNC(SYSDATE - 7) AND TRUNC(SYSDATE - 6)
   AND 0 = (SELECT COUNT(1)
              FROM subscription_soc_rc@fokus rc2
             WHERE rc1.subscriber_no      = rc2.subscriber_no
               AND rc1.soc                = rc2.soc
               AND rc1.feature_code       = rc2.feature_code
               AND rc1.ext_agreement_id   = rc2.ext_agreement_id
               AND rc1.ext_agreement_type = rc2.ext_agreement_type);

--
SELECT rc1.ban,             rc1.subscriber_no,    rc1.soc
     , rc1.feature_code,    rc1.ext_agreement_id, rc1.ext_agreement_type
     , rc1.expiration_date
  FROM subscription_soc_rc@fokus rc1
 WHERE NVL(rc1.expiration_date, SYSDATE + 1) BETWEEN TRUNC(SYSDATE - 8) AND TRUNC(SYSDATE - 7)
   AND 0 = (SELECT COUNT(1)
              FROM subscription_soc_rc@fokus rc2
             WHERE rc1.subscriber_no      = rc2.subscriber_no
               AND rc1.soc                = rc2.soc
               AND rc1.feature_code       = rc2.feature_code
               AND rc1.ext_agreement_id   = rc2.ext_agreement_id
               AND rc1.ext_agreement_type = rc2.ext_agreement_type)
;

SELECT rc1.*
  FROM subscription_soc_rc@fokus rc1
 WHERE NVL(rc1.expiration_date, SYSDATE + 1) BETWEEN TRUNC(SYSDATE - 8) AND TRUNC(SYSDATE - 7)
   AND 0 = (SELECT COUNT(1)
              FROM subscription_soc_rc@fokus rc2
             WHERE rc1.subscriber_no      = rc2.subscriber_no
               AND rc1.soc                = rc2.soc
               AND rc1.feature_code       = rc2.feature_code
               AND rc1.ext_agreement_id   = rc2.ext_agreement_id
               AND rc1.ext_agreement_type = rc2.ext_agreement_type)
;

update subscription_soc_rc@fokus a
   set a.ext_agreement_id = 'agr_bXrSy4A'
 where a.soc_seq_no       = 240802062
;

SELECT a.nl, a.ngp, a.ctn_length, COUNT(1) AS "COUNT"
  FROM (SELECT RTRIM(t2.nl) AS "NL", RTRIM(t2.ngp) AS "NGP", LENGTH(RTRIM(t2.ctn)) as "CTN_LENGTH"
          FROM tn_inv@fokus t2
         WHERE t2.ctn_status = 'AA') a
         
GROUP BY a.nl, a.ngp, a.ctn_length
ORDER BY 1,2,3
;


