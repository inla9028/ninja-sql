/* Formatted on 2019-02-19 15:35:50 (QP5 v5.160) */
SELECT sf.ban,
       sf.subscriber_no,
       sf.soc,
       sf.ftr_add_sw_prm,
       pd.imsi
  FROM service_feature sf, physical_device pd
 WHERE sf.soc           = 'MAPNPTEK'
   AND SYSDATE    BETWEEN sf.ftr_effective_date AND NVL (sf.ftr_expiration_date, SYSDATE + 1)
   AND sf.feature_code  = 'S-AP01'
   AND sf.subscriber_no = pd.subscriber_no
   AND sf.ban           = pd.customer_id
   AND SYSDATE    BETWEEN pd.effective_date AND NVL (pd.expiration_date, SYSDATE + 1)
   AND equipment_level  = '1'
ORDER BY 2,1
;
