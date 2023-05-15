SELECT /*+ driving_site(s)*/
       s.subscriber_no, s.customer_id, s.sub_status, s.sub_status_date, a1.soc
     , a1.effective_date
  FROM subscriber@fokus s, service_agreement@fokus a1
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc        LIKE 'NSHAPB073%'
   AND ROWNUM < 11
;

/*
GSM047580004227309	672183415	A	2019-12-19 00:00	HPTSP01  	2019-12-19 00:00
GSM047580009994811	413406414	A	2019-08-27 00:00	HPTSP01  	2020-02-25 00:00
GSM04740813790	191406412	A	2020-04-20 00:00	HPTSP01  	2020-04-20 00:00
GSM047580004227161	152406419	A	2019-09-27 00:00	HPTSP01  	2019-09-27 00:00
GSM047580009994655	203406418	A	2019-08-27 00:00	HPTSP01  	2020-02-25 00:00
GSM047580004227165	132406414	A	2019-09-27 00:00	HPTSP01  	2019-09-27 00:00
GSM04740813628	691406417	A	2020-02-11 00:00	HPTSP01  	2020-02-11 00:00
GSM047580004253022	443406418	A	2020-03-06 00:00	HPTSP01  	2020-03-06 00:00
GSM047580004252771	943406413	A	2020-03-06 00:00	HPTSP01  	2020-03-06 00:00
GSM047580009989753	902406412	A	2019-11-21 00:00	HPTSP01  	2019-11-21 00:00
*/

-- Subscriber; status
SELECT /*+ driving_site(a)*/
       a.subscriber_no, a.customer_id, a.sub_status, a.sub_status_date
     , a.operator_id, u.user_full_name, a.dealer_code, a.sales_agent
     , a.subscriber_id, RTRIM(a.publish_level) AS "PUBLISH_LEVEL"
 FROM subscriber@fokus a, users@fokus u
WHERE a.subscriber_no = 'GSM047'||'98029026'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.operator_id   = u.user_id(+)
;

-- BAN; status, account types...
SELECT /*+ driving_site(b)*/
       b.ban, b.curr_root_ban, b.sys_creation_date, b.ban_status
     , b.account_type, b.account_sub_type, b.operator_id, u.user_full_name
     , b.credit_class, b.bill_cycle, b.bl_last_prod_date, b.bl_prt_category
  FROM billing_account@fokus b, subscriber@fokus a, users@fokus u
WHERE a.subscriber_no = 'GSM047'||'98029026'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.customer_id   = b.ban
  AND b.operator_id   = u.user_id(+)
;

-- Service Agreement; SOCs...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
  FROM service_agreement@fokus a, users@fokus u
 WHERE a.subscriber_no = 'GSM047'||'98029026'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Service Feature; Feature parameters...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date --, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, a.ftr_add_sw_prm, a.ftr_exp_rsn_code
  FROM service_feature@fokus a
 WHERE a.subscriber_no = 'GSM047'||'98029026'
   AND   SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
--   AND a.soc LIKE '%MBN%'
--   AND a.feature_code LIKE 'F-SWC%' -- Switch
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
   AND a.ftr_add_sw_prm IS NOT NULL
ORDER BY a.ban, a.subscriber_no, a.soc, a.feature_code
;

-- Soc Loan; Loans, Leases, Switches...
SELECT /*+ driving_site(a)*/
       s.subscriber_no, a.subscriber_id, a.sys_creation_date, a.loan_seq_no
     , a.handle_ind, a.soc, a.full_amt, a.first_install_rate
     , a.other_install_rate, a.last_install_rate, a.no_of_installments
     , a.expiration_date, a.ud_last_date_crg, a.last_date_of_crg
  FROM subscriber_loan@fokus a, subscriber@fokus s
 WHERE a.subscriber_id = s.subscriber_id
   AND s.subscriber_no = 'GSM047'||'98029026'
   AND s.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = s.subscriber_no)
ORDER BY s.subscriber_no, a.loan_seq_no
;

-- Finally, memoes...
SELECT /*+ driving_site(a)*/
       a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus a, users@fokus u
 WHERE a.memo_subscriber = 'GSM047'||'98029026'
   AND a.memo_date       > TRUNC(SYSDATE - 60, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE, 'YEAR')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;

select s.*
  from suspend_bar s, service_agreement@fokus a
 where a.subscriber_no = 'GSM047'||'98029026'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.service_type  = 'P'
   AND s.priceplan     = RTRIM(a.soc)
order by 1,2
;

select s.*
  from suspend_bar s
order by 1,2
;

