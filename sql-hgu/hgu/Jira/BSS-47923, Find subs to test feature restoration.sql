/*
** PT
*/
select a.*
  from socs_descriptions a
 where a.soc LIKE 'P%'
   and LENGTH(a.soc) = 4
order by 1,2
;

select a.*
  from feature_expiration_rules a
 where a.soc1 = 'PPUS'
   and a.soc2 = 'VMB2C01'
order by 1,2,3,4
;

/*
PANA	S-PERS	VMFREE+	S-VF	1
PANA	S-PERS	VMFREE	S-VF	1
PANA	S-PERS	VMPOSTF01	S-VF	1
PANA	S-PERS	VMPOST01	S-VF	1
*/

SELECT /*+ driving_site(s) */
       s.subscriber_no, s.sub_status, RTRIM(sa1.soc) AS "PP_SOC"
  FROM subscriber@fokus s, service_agreement@fokus sa1
 WHERE RTRIM(sa1.soc) = 'PSPE'
   AND SYSDATE BETWEEN sa1.effective_date AND NVL(sa1.expiration_date, SYSDATE + 1)
   AND sa1.subscriber_no = s.subscriber_no
   AND s.sub_status      = 'A'
   AND 0                != (SELECT COUNT(1)
                              FROM service_agreement@fokus sa2
                             WHERE sa2.ban           = sa1.ban
                               AND sa2.subscriber_no = sa1.subscriber_no
                               AND RTRIM(sa2.soc) LIKE 'VMACC%' -- Not with this soc
                               AND SYSDATE     BETWEEN sa2.effective_date AND NVL(sa2.expiration_date, SYSDATE + 1))
   AND ROWNUM < 11
;
/*
PT
GSM04795087833	A	PPUS
GSM04741561540	A	PPUS
GSM04792418088	A	PPUS
GSM04745022325	A	PPUS
GSM04793899493	A	PPUS
GSM04793222403	A	PPUS
GSM04792023157	A	PPUS
GSM04745480556	A	PPUS
GSM04797470058	A	PPUS
GSM04792678801	A	PPUS
*/

-- Service Agreement; SOCs...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
  FROM service_agreement@fokus a, users@fokus u
 WHERE a.subscriber_no = 'GSM047'||'93222403'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Service Feature; Feature parameters...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date --, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, a.ftr_add_sw_prm
  FROM service_feature@fokus a
 WHERE a.subscriber_no = 'GSM047'||'93222403'
   AND   SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
--   AND a.soc LIKE '%MBN%'
   AND RTRIM(a.feature_code) IN ( 'S-PERS', 'S-VF', 'S-VF1' )
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
--   AND a.ftr_add_sw_prm IS NOT NULL
ORDER BY a.ban, a.subscriber_no, a.soc, a.feature_code
;

select a.*
  from subscription_types_socs a
 where a.subscription_type_id = 'PANA'||'REG1'
   and SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   and a.soc like 'MP%'
order by 1,2
;

select /*+ driving_site(a)*/
       a.*
  from soc_illegal_comb@fokus a
 where 'PANA'   IN (rtrim(a.soc_first), rtrim(a.soc_second))
   and 'MPOD08' IN (rtrim(a.soc_first), rtrim(a.soc_second))
order by 1,2
;
