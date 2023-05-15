SELECT A.*
  from batch_tpid_extract a
 where a.request_time > trunc(sysdate)
order by nvl(a.process_time, sysdate)
;

INSERT INTO batch_tpid_extract (ban,subscriber_no,link_type) 
VALUES ('803620905','GSM04792653600','U');



SELECT A.subscriber_no, A.soc, A.expiration_date, A.parameters --, A.dealer, A.memo
     , A.request_id, A.enter_time, A.request_time, A.process_time
     , A.process_status, A.status_desc
  FROM batch_add_soc_w_exp_date a
 WHERE a.request_id = 'HGU ' || TO_CHAR(SYSDATE,'YYYY-MM-DD')
ORDER BY A.request_time
;

SELECT A.request_id, A.process_status, count(1) AS "COUNT"
  FROM batch_add_soc_w_exp_date A
 WHERE A.request_id = 'HGU ' || TO_CHAR(SYSDATE,'YYYY-MM-DD')
GROUP BY A.request_id, A.process_status
ORDER BY 1,2
;


'HGU ' || to_char(SYSDATE,'YYYY-MM-DD')

INSERT INTO batch_add_soc_w_exp_date (subscriber_no,soc,expiration_date,PARAMETERS,memo,request_id) 
VALUES ('GSM04792653600','MMS02',to_date('2021-01-01','YYYY-MM-DD'),'EMAIL=isnt.it.ironic@dont.you.yhink','Håkan tester litt lokalt...','HGU ' || to_char(SYSDATE,'YYYY-MM-DD'));

INSERT INTO batch_add_soc_w_exp_date (subscriber_no,soc,expiration_date,PARAMETERS,memo,request_id) 
VALUES ('GSM04792653600','MMS02',to_date('2022-02-02','YYYY-MM-DD'),'EMAIL=hello@is.it.me.you.looking.fo','Håkan tester litt lokalt...','HGU ' || to_char(SYSDATE,'YYYY-MM-DD'));

INSERT INTO batch_add_soc_w_exp_date (subscriber_no,soc,expiration_date,PARAMETERS,memo,request_id) 
VALUES ('GSM04792653600','MMS02',TO_DATE('2023-03-03','YYYY-MM-DD'),'EMAIL=take@me.out','Håkan tester litt lokalt...','HGU ' || TO_CHAR(SYSDATE,'YYYY-MM-DD'));

INSERT INTO batch_add_soc_w_exp_date (subscriber_no,soc,expiration_date,PARAMETERS,memo,request_id) 
VALUES ('GSM04792653600','MMS02',NULL,NULL,'Håkan tester litt lokalt...','HGU ' || TO_CHAR(SYSDATE,'YYYY-MM-DD'));


INSERT INTO batch_add_soc_w_exp_date (subscriber_no,soc,expiration_date,PARAMETERS,memo,request_id) 
SELECT /*+ driving_site(s)*/ s.subscriber_no, 'MMS02',to_date('2022-02-02','YYYY-MM-DD'),'EMAIL=hello@is.it.me.you.looking.fo','Håkan tester litt lokalt...','HGU ' || to_char(SYSDATE,'YYYY-MM-DD')
  FROM subscriber@fokus s
 WHERE s.sub_status = 'A'
   AND ROWNUM < 101
;

INSERT INTO batch_add_soc_w_exp_date (subscriber_no,soc,expiration_date,PARAMETERS,memo,request_id)
SELECT /*+ driving_site(s)*/ s.subscriber_no, 'MMS02',to_date('2022-02-02','YYYY-MM-DD'),'EMAIL=hello@is.it.me.you.looking.fo','Håkan tester litt lokalt...','HGU ' || to_char(SYSDATE,'YYYY-MM-DD')
  FROM subscriber@fokus s
 WHERE s.sub_status    = 'A'
   AND s.subscriber_no LIKE 'GSM%'
   AND ROWNUM          < 1001
   AND 0               = (SELECT /*+ driving_site(sa)*/ count(1)
                            FROM service_agreement@fokus sa
                           WHERE sa.subscriber_no = s.subscriber_no
                             AND sa.soc        LIKE 'MMS02%'
                             AND SYSDATE between sa.effective_date AND nvl(sa.expiration_date, sysdate + 1)
   )
;

UPDATE batch_add_soc_w_exp_date b
   set b.expiration_date = TO_DATE('2023-03-03','YYYY-MM-DD'), b.parameters = 'EMAIL=no.soup@for.you', b.process_time = NULL, b.process_status = 'WAITING'
 WHERE b.process_status  = 'PRSD_SUCCESS'
   and b.request_id      = 'HGU ' || to_char(SYSDATE,'YYYY-MM-DD')
;



-- Service Agreement; SOCs...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
     , a.loan_seq_no, a.trx_id
  FROM service_agreement@fokus a, users@fokus u
 WHERE a.subscriber_no = 'GSM047'||'92653600'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Service Feature; Feature parameters...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date --, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, a.ftr_add_sw_prm, a.ftr_exp_rsn_code
  FROM service_feature@fokus a
 WHERE a.subscriber_no = 'GSM047'||'92653600'
   AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
--   AND a.soc LIKE 'CL%'
--   AND a.feature_code LIKE 'F-SWC%' -- Switch
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
   AND a.ftr_add_sw_prm IS NOT NULL
ORDER BY A.ban, A.subscriber_no, A.soc, A.feature_code
;


WITH my_filter AS (SELECT b.subscriber_no, b.soc
                     FROM batch_add_soc_w_exp_date b
                    WHERE b.process_status = 'PRSD_SUCCESS'
                      and b.request_id     = 'HGU ' || to_char(SYSDATE,'YYYY-MM-DD'))
SELECT /*+ driving_site(sf)*/
       sf.ban, sf.subscriber_no, sf.soc, sf.ftr_effective_date
     , sf.ftr_expiration_date, sf.feature_code, sf.ftr_add_sw_prm, sf.ftr_exp_rsn_code
  FROM service_feature@fokus sf, my_filter mf
 WHERE sf.subscriber_no = mf.subscriber_no
   AND SYSDATE BETWEEN sf.ftr_effective_date AND NVL(sf.ftr_expiration_date, SYSDATE + 1)
   AND RTRIM(sf.soc) = mf.soc
   AND sf.ftr_add_sw_prm IS NOT NULL
ORDER BY sf.ban, sf.subscriber_no, sf.soc, sf.feature_code
;

-- Finally, memoes...
SELECT /*+ driving_site(a)*/
       a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus a, users@fokus u
 WHERE A.memo_subscriber = 'GSM047'||'92653600'
   AND A.memo_date       > trunc(SYSDATE)
--   AND a.memo_date       > TRUNC(SYSDATE, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE - 30, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE - 60, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE, 'YEAR')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;
