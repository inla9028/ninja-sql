SELECT sa.subscriber_no, sa.soc, sp.sp_code AS "SPM_CODE"
     , sa.effective_date, sa.expiration_date
  FROM service_agreement@fokus sa
     , spm_service_mapping     sp
     , socs                    s
 WHERE sa.subscriber_no = 'GSM047'||'48956390'
   AND SYSDATE   BETWEEN sa.effective_date AND NVL(sa.expiration_date, SYSDATE + 1)
--   AND SYSDATE - 1  BETWEEN sa.effective_date AND NVL(sa.expiration_date, SYSDATE + 1)
   AND RTRIM(sa.soc)   = s.soc
   AND s.soc_type      = sp.soc_type
   AND s.soc_group     = sp.soc_group
ORDER BY 1,2,3
;