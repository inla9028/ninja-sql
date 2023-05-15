--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.operator_id, a.application_id,
       a.campaign, a.feature_code, a.service_type, a.ftr_effective_date,
       a.ftr_expiration_date, a.ftr_add_sw_prm
 FROM service_feature@fokus a
  WHERE a.subscriber_no = 'GSM047' || '47526944'
    AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2012-03-12', 'YYYY-MM-DD') BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--    AND a.service_type = 'P'
    AND RTRIM(a.soc) IN ('INSURNDF')
  ORDER BY a.subscriber_no, a.ban, a.campaign, a.service_type, a.soc, a.feature_code, a.ftr_effective_date;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including the operator that added it/them.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.operator_id, u.user_full_name, a.application_id,
       a.campaign, a.feature_code, a.service_type, a.ftr_effective_date,
       a.ftr_expiration_date, a.ftr_add_sw_prm
 FROM service_feature@fokus a, users@fokus u
  WHERE a.subscriber_no = 'GSM047' || '46547038'
    AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.operator_id = u.user_id(+)
--    AND TO_DATE('2008-10-01', 'YYYY-MM-DD') BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--    AND a.service_type = 'P'
    AND RTRIM(a.soc) IN ('VMMINI')
  ORDER BY a.subscriber_no, a.ban, a.campaign, a.service_type, a.soc, a.feature_code, a.ftr_effective_date;


