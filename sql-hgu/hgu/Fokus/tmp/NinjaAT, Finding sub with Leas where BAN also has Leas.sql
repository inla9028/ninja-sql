SELECT /*+ driving_site(s)*/
       s.subscriber_no, s.customer_id, s.sub_status
     , a1.soc AS "SUB_SOC", TO_CHAR(a1.effective_date, 'YYYY-MM-DD') AS "SUB_EFF_DATE"
     , a2.soc AS "BAN_SOC", TO_CHAR(a2.effective_date, 'YYYY-MM-DD') AS "BAN_EFF_DATE"
     , a2.soc_seq_no
  FROM subscriber@fokus s, service_agreement@fokus a1, service_agreement@fokus a2
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.service_type  = 'G'
   AND s.customer_id    = a2.ban
   AND a2.subscriber_no = '0000000000'
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND a2.service_type  = 'G'
   AND ROWNUM < 11
;

/*
GSM04741425299	100101112	A	LOPFLX01 	2019-08-15	LR10296A 	2019-06-03	230875688
GSM04745268168	100101112	A	LOPFLX01 	2020-04-02	LR10296A 	2019-06-03	230875688
GSM04741425299	100101112	A	LOPFLX01 	2019-08-15	LR08856A 	2019-06-03	230875690
GSM04745268168	100101112	A	LOPFLX01 	2020-04-02	LR08856A 	2019-06-03	230875690
GSM04746520336	100108315	A	LR05976A 	2019-02-18	LR12456A 	2019-05-31	230775556
GSM04746520336	100108315	A	LR05976A 	2019-02-18	LOPFLX01 	2020-01-21	240750992
*GSM04740785940	100710011	A	LR11736A 	2019-03-12	LR08856A 	2018-06-28	217469202
GSM04799227777	101643211	A	LOPFLX01 	2019-10-02	LR10536A 	2018-10-23	222157209
GSM04740191179	104082417	A	LOPFLX01 	2019-03-19	LR09336A 	2019-09-09	235226190
GSM04797530923	104082417	A	LOPFLX01 	2020-04-02	LR09336A 	2019-09-09	235226190
*/

SELECT /*+ driving_site(s)*/
       s.subscriber_no, s.customer_id, s.sub_status
     , a1.soc AS "SUB_SOC", TO_CHAR(a1.effective_date, 'YYYY-MM-DD') AS "SUB_EFF_DATE"
     , a2.soc AS "BAN_SOC", TO_CHAR(a2.effective_date, 'YYYY-MM-DD') AS "BAN_EFF_DATE"
     , a2.soc_seq_no
  FROM subscriber@fokus s, service_agreement@fokus a1, service_agreement@fokus a2
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc           = 'PPEQ'
   AND 0                = (SELECT COUNT(1)
                             FROM service_agreement@fokus a3
                            WHERE a3.ban           = s.customer_id 
                              AND a3.subscriber_no = s.subscriber_no 
                              AND SYSDATE    BETWEEN a3.effective_date AND NVL(a3.expiration_date, SYSDATE + 1)
                              AND a3.service_type  = 'G')
   AND s.customer_id    = a2.ban
   AND a2.subscriber_no = '0000000000'
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND a2.service_type  = 'G'
   AND ROWNUM < 11
;

/*
*GSM04796749368	202920310	A	PPEQ     	2019-09-20	LR07656A 	2019-01-26	226363365
*GSM04795111786	102480316	A	PPEQ     	2019-11-06	LEASYU   	2019-08-16	233930039
*GSM04740643038	172302317	A	PPEQ     	2019-11-27	LR09336A 	2019-10-11	236849777
*GSM04740245646	684149404	A	PPEQ     	2019-12-22	LR11736A 	2019-12-20	239869916
*GSM04794785101	442972311	A	PPEQ     	2019-06-18	LR07656A 	2019-02-12	226948670
GSM04740607209	598382315	A	PPEQ     	2019-10-31	LR11736A 	2018-09-20	220603332
GSM04741230823	937053312	A	PPEQ     	2019-12-11	LR07896A 	2019-10-01	236379681
GSM04793958722	470763319	A	PPEQ     	2019-12-13	LR09576A 	2018-12-04	224222123
GSM04796913135	664563319	A	PPEQ     	2019-02-15	LR08856A 	2019-02-04	226667748
GSM04798410015	836456111	A	PPEQ     	2019-08-15	LR13416A 	2019-10-22	237270662
*/

-- BAN; status, account types...
SELECT /*+ driving_site(b)*/
       b.ban, b.curr_root_ban, b.sys_creation_date, b.ban_status
     , b.account_type, b.account_sub_type, b.operator_id, u.user_full_name
     , b.credit_class, b.bill_cycle, b.bl_last_prod_date, b.bl_prt_category
  FROM billing_account@fokus b, subscriber@fokus a, users@fokus u
WHERE a.subscriber_no = 'GSM047'||'45268168'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.customer_id   = b.ban
  AND b.operator_id   = u.user_id(+)
;

SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
  FROM service_agreement@fokus a, users@fokus u
 WHERE a.subscriber_no = 'GSM047'||'45268168'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Service Feature; Feature parameters...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date --, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, a.ftr_add_sw_prm
  FROM service_feature@fokus a
 WHERE a.subscriber_no = 'GSM047'||'45268168'
   AND   SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
--   AND a.soc LIKE '%MBN%'
--   AND a.feature_code LIKE 'F-SWC%' -- Switch
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
   AND a.ftr_add_sw_prm IS NOT NULL
ORDER BY a.ban, a.subscriber_no, a.soc, a.feature_code
;