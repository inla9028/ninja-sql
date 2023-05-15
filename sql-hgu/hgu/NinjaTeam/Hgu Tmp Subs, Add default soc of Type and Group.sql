--DELETE FROM ninjateam.hgu_tmp_subs a;

SELECT a.subscriber_no, a.soc
  FROM ninjateam.hgu_tmp_subs a
;

SELECT t.subscriber_no, s.soc AS "VM_SOC"
  FROM ninjateam.hgu_tmp_subs t, subscription_types_socs sts, socs s, service_agreement@fokus sa
 WHERE t.subscriber_no = sa.subscriber_no
   AND SYSDATE   BETWEEN sa.effective_date AND NVL(sa.expiration_date, SYSDATE + 1)
   AND sa.service_type = 'P'
   AND RTRIM(sa.soc) || 'REG1' = sts.subscription_type_id
   AND SYSDATE   BETWEEN sts.effective_date AND NVL(sts.expiration_date, SYSDATE + 1)
   AND sts.soc         = s.soc
   AND s.soc_type      = 'VOICEMAIL2'
   AND s.soc_group     = 'VMS2'
; 
