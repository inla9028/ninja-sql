SELECT b.*
  FROM billing_account b
WHERE b.customer_id   IN ( 614406411 )
ORDER BY b.customer_id 
;

SELECT a.*
  FROM service_agreement a
 WHERE a.customer_id IN ( 614406411 )
   AND a.subscriber_no = '0000000000'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2,3
;

SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, a.ftr_add_sw_prm
  FROM service_feature a
 WHERE a.subscriber_no = '0000000000'
   AND a.customer_id IN ( 614406411 )
   AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
--   AND a.soc LIKE 'VM%'
   AND a.feature_code LIKE 'F-SWC%'
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
ORDER BY 1,2,3,8
;

SELECT a.memo_id, a.memo_ban, a.memo_subscriber, a.memo_date
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo a, users u
 WHERE a.memo_subscriber IS NULL
   AND a.memo_ban        IN ( 614406411 )
--   AND a.memo_date > TRUNC(SYSDATE - 90, 'MON')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;


