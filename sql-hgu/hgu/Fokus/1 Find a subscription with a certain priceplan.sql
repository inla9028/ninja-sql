SELECT /*+ driving_site(s)*/
       s.subscriber_no, s.customer_id, s.sub_status, s.sub_status_date, a1.soc AS "PP"
  FROM subscriber@fokus s, service_agreement@fokus a1
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND nvl(a1.expiration_date, SYSDATE + 1)
   AND a1.soc        LIKE 'PW20%'
   AND ROWNUM < 21
;

/*
GSM047580008971384	555974310	A	2021-01-19 00:00	PW30     
GSM047580008971378	282974310	A	2021-01-19 00:00	PW30     
GSM047580008971333	374974319	A	2021-01-18 00:00	PW30     
GSM047580008971427	913084315	A	2021-01-19 00:00	PW30     
GSM047580008972178	664349214	A	2021-02-05 00:00	PW30     
GSM047580008971462	944084318	A	2021-01-19 00:00	PW30     
GSM047580008971449	945974319	A	2021-01-19 00:00	PW30     
GSM047580008971440	634974315	A	2021-01-19 00:00	PW30     
GSM047580008972671	364974311	A	2021-02-24 00:00	PW30     
GSM047580008972523	793974312	A	2021-02-24 00:00	PW30     
GSM047580008971833	282974310	A	2021-02-02 00:00	PW30     
GSM047580008970376	512974312	A	2020-12-04 00:00	PW30     
GSM047580008970364	634974315	A	2020-12-04 00:00	PW30     
GSM047580008970402	742974314	A	2020-12-04 00:00	PW30     
GSM047580008971409	262974314	A	2021-01-19 00:00	PW30     
GSM047580008972145	914774310	A	2021-02-08 00:00	PW30     
GSM047580008970129	473974319	A	2020-11-26 00:00	PW30     
GSM047580008972102	388634214	A	2021-02-05 00:00	PW30     
GSM047580008970363	793974312	A	2020-12-04 00:00	PW30     
GSM047580008970396	196629216	A	2020-12-04 00:00	PW30       
*/

-- Subscriber; status
SELECT /*+ driving_site(a)*/
       a.subscriber_no, a.customer_id, a.sub_status, a.sub_status_date
     , a.operator_id, u.user_full_name, a.dealer_code, a.sales_agent
     , a.subscriber_id, RTRIM(a.publish_level) AS "PUBLISH_LEVEL"
 FROM subscriber@fokus a, users@fokus u
WHERE a.subscriber_no = 'GSM047'||'580004236367'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.operator_id   = u.user_id(+)
;

-- Service Agreement; SOCs...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
  FROM service_agreement@fokus a, users@fokus u
 WHERE a.subscriber_no = 'GSM047'||'580004236367'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Service Feature; Feature parameters...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date --, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, a.ftr_add_sw_prm, a.ftr_exp_rsn_code
  FROM service_feature@fokus a
 WHERE a.subscriber_no = 'GSM047'||'580004236367'
   AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
   AND a.soc LIKE 'SPVOC%'
--   AND a.feature_code LIKE 'F-SWC%' -- Switch
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
   AND a.ftr_add_sw_prm IS NOT NULL
ORDER BY a.ban, a.subscriber_no, a.soc, a.feature_code
;

-- Names & Addresses...
SELECT /*+ driving_site(s)*/
       anl.ban, anl.subscriber_no, anl.link_type, anl.birth_date
     , nd.tpid, nd.comp_reg_id, nd.first_name, nd.last_business_name, nd.additional_title
     , ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email
     , nd.name_format, ad.adr_type, nd.role_ind
--       , anl.name_id, anl.address_id
--       , nd.*
  FROM subscriber@fokus        s
     , address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
 WHERE s.subscriber_no    = 'GSM047'||'580004236367'
   AND s.ctn_seq_no       = (SELECT MAX(s2.ctn_seq_no)
                              FROM subscriber@fokus s2
                             WHERE s2.subscriber_no = s.subscriber_no)
   AND anl.ban            = s.customer_id 
   AND anl.subscriber_no IN ( '0000000000', s.subscriber_no )
   AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
ORDER BY anl.ban, anl.subscriber_no, anl.link_type
;

-- Finally, memoes...
SELECT /*+ driving_site(a)*/
       a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus a, users@fokus u
 WHERE a.memo_subscriber = 'GSM047'||'580004236367'
   AND a.memo_date       > TRUNC(SYSDATE - 60, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE, 'YEAR')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;

select s.*
  from suspend_bar s, service_agreement@fokus a
 where a.subscriber_no = 'GSM047'||'580004236367'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.service_type  = 'P'
   AND s.priceplan     = RTRIM(a.soc)
order by 1,2
;

select s.*
  from suspend_bar s
order by 1,2
;

