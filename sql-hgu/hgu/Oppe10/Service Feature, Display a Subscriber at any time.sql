--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.feature_code, 
       a.ftr_effective_date, a.ftr_expiration_date, a.ftr_add_sw_prm
  FROM service_feature a
  WHERE a.subscriber_no IN ('GSM04740607139', 'GSM04741216618', 'GSM04793667760', 'GSM04793849416', 'GSM04795224142', 'GSM04799163306', 'GSM04793213668', 'GSM04745611177', 'GSM04795827645', 'GSM04798474460', 'GSM04798090216', 'GSM04793629049', 'GSM04793858588', 'GSM04746787369', 'GSM04799127399', 'GSM04747301303', 'GSM04791551250', 'GSM04795103565')
    AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2009-01-10', 'YYYY-MM-DD') BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--    AND a.service_type = 'P'
    AND RTRIM(a.soc) = 'BESTEVEN1'
  ORDER BY a.subscriber_no, a.ban, a.soc, a.feature_code, a.ftr_effective_date;


SELECT a.ban, a.subscriber_no, a.soc, a.feature_code, 
       a.ftr_effective_date, a.ftr_expiration_date, a.ftr_add_sw_prm
  FROM service_feature a
  WHERE a.ban = 681796504
    AND a.subscriber_no IN ('GSM04740019970')
    AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2009-01-10', 'YYYY-MM-DD') BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
--    AND a.service_type = 'P'
    AND RTRIM(a.soc) = 'VMBED'
  ORDER BY a.subscriber_no, a.ban, a.soc, a.feature_code, a.ftr_effective_date;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including account types.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including any prices.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

