SELECT a.subscriber_no, a.soc, a.feature_code, a.ftr_effective_date, a.ftr_expiration_date,
       SUBSTR(a.ftr_add_sw_prm, INSTR(a.ftr_add_sw_prm, 'SIM=') + 4, 20) AS "FTR_ADD_SW_PRM"
 FROM service_feature@fokus a
  WHERE a.subscriber_no IN ('GSM047' || '41144376')
--    AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, TO_DATE('4701', 'YYYY'))
    AND RTRIM(a.soc) IN ('TSIMA', 'TSIMB', 'TWINCON', 'TWINCONF')
    AND RTRIM(a.feature_code) IN ('S-DUOA', 'S-DUOB', 'S-TWIN')
  ORDER BY a.subscriber_no, a.ban, a.campaign, a.service_type, a.soc, a.feature_code, a.ftr_effective_date;

