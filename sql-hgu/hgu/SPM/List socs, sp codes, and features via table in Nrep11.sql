SELECT UNIQUE
       a.subscriber_no, a.ban, RTRIM(f.soc) AS "SOC"
     , m.sp_code, f.ftr_add_sw_prm
  FROM tmp_msisdns_w_status_pp@nrep11 a,
       data_no.service_feature@nrep11 f,
       socs                           s,
       spm_service_mapping            m
 WHERE a.subscriber_no = f.subscriber_no
   AND a.ban           = f.ban
   AND SYSDATE   BETWEEN f.ftr_effective_date AND NVL(f.ftr_expiration_date, SYSDATE + 1)
   AND RTRIM(f.soc)    = s.soc
   AND s.soc_type      = m.soc_type
   AND s.soc_group     = m.soc_group
--   AND ROWNUM < 11
;
