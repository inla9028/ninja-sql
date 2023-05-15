SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.sys_creation_date,
       a.feature_code, a.ftr_add_sw_prm, a.ftr_effective_date,
       a.ftr_expiration_date
  FROM dd.service_feature a
  WHERE a.soc            = 'VMMINI   '
    AND SYSDATE BETWEEN a.sys_creation_date AND a.ftr_expiration_date
    AND a.feature_code   = 'S-MCC'
    AND NVL(a.ftr_add_sw_prm, 'n/a') = 'n/a'
