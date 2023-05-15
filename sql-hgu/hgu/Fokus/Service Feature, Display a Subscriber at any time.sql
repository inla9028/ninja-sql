--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.operator_id, a.application_id,
       a.campaign, a.feature_code, a.service_type, a.ftr_effective_date,
       a.ftr_expiration_date, a.ftr_add_sw_prm
  FROM service_feature@fokus a
 WHERE a.subscriber_no IN ('GSM047' || '97743103')
--   AND */a.ban = 113672505 AND a.subscriber_no = '0000000000'
   AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--   AND TO_DATE('2008-10-01', 'YYYY-MM-DD') BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--   AND a.service_type = 'P'
--   AND RTRIM(a.soc) IN ('TSIMA', 'TSIMB', 'TWINCON')
   AND RTRIM(a.soc) LIKE 'CONBC%'
ORDER BY a.subscriber_no, a.ban, a.campaign, a.service_type, a.soc, a.feature_code, a.ftr_effective_date
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including the operator that added it/them.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.operator_id, u.user_full_name, a.application_id,
       a.campaign, a.feature_code, a.service_type, a.ftr_effective_date,
       a.ftr_expiration_date, a.ftr_add_sw_prm
  FROM service_feature a, users u
 WHERE a.subscriber_no IN ('GSM047' || '40638113')
--   AND */a.ban = 113672505 AND a.subscriber_no = '0000000000'
   AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
   AND a.operator_id = u.user_id(+)
--   AND TO_DATE('2008-10-01', 'YYYY-MM-DD') BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--   AND a.service_type = 'P'
--   AND RTRIM(a.soc) IN ('VMMINI')
ORDER BY a.subscriber_no, a.ban, a.campaign, a.service_type, a.soc, a.feature_code, a.ftr_effective_date
;


