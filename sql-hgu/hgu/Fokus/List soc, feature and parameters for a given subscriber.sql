SELECT a.*
  FROM service_agreement a
 WHERE a.subscriber_no = 'GSM047'||'99468084'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2,3
;

SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.sys_creation_date, a.feature_code, a.ftr_add_sw_prm
  FROM service_feature a
 WHERE a.subscriber_no = 'GSM047'||'99468084'
   AND SYSDATE   BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
   AND a.soc        LIKE '%VMB%'
ORDER BY 1,2,3
;
