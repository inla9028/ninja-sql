SELECT a.soc
     , m.sp_code
     , COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc_fp@nrep11 a, spm_service_mapping m, socs s
 WHERE a.soc       = s.soc
   AND s.soc_type  = m.soc_type(+)
   AND s.soc_group = m.soc_group(+)
GROUP BY a.soc, m.sp_code
ORDER BY a.soc, m.sp_code
;

SELECT a.price_plan, p.sp_priceplan_code, a.soc, m.sp_code, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc_fp@nrep11 a, spm_priceplan_mapping p, spm_service_mapping m, socs s
 WHERE a.soc        = s.soc
   AND s.soc_type   = m.soc_type(+)
   AND s.soc_group  = m.soc_group(+)
   AND a.price_plan = p.soc_code(+)
GROUP BY a.price_plan, p.sp_priceplan_code, a.soc, m.sp_code
ORDER BY a.price_plan, p.sp_priceplan_code, a.soc, m.sp_code
;

SELECT a.subscriber_no, a.ban, a.sub_status, a.price_plan, a.soc, m.sp_code, a.effective_date
  FROM tmp_msisdns_w_status_pp_soc_fp@nrep11 a, spm_service_mapping m, socs s
 WHERE a.soc       = s.soc(+)
   AND s.soc_type  = m.soc_type
   AND s.soc_group = m.soc_group
ORDER BY a.soc, a.sub_status, a.subscriber_no
;

SELECT a.subscriber_no
     , a.sub_status
     , a.sim_number
     , a.imsi
     , a.price_plan
     , NVL(p.sp_priceplan_code, 'VOICE') AS "SP_PRICEPLAN_CODE"
     , a.soc
     , NVL(
           DECODE(m.sp_code
                , 'M2M_APN_VPN', 'APN' || SUBSTR(a.feature_code, LENGTH(a.feature_code))
                , m.sp_code),
           DECODE(a.soc
                , 'IMS01',     'VOLTE'
                , 'M2MAFIXIP', 'APN1'
                , 'M2MAPN1',   'APN1'
                , '??? ' || a.soc
           )
       ) AS "SP_CODE"
     , a.effective_date
     , a.ftr_add_sw_prm
  FROM tmp_msisdns_w_status_pp_soc_fp@nrep11 a, spm_priceplan_mapping p, spm_service_mapping m, socs s
 WHERE a.soc      NOT IN ( 'BASIS' )
   AND a.soc           = s.soc
   AND s.soc_type      = m.soc_type(+)
   AND s.soc_group     = m.soc_group(+)
   AND a.price_plan    = p.soc_code(+)
--   AND a.subscriber_no IN ( 'GSM04740813822', 'GSM047580009980148' )
--ORDER BY p.sp_priceplan_code, a.soc, m.sp_code, a.subscriber_no
ORDER BY 1,8
;
