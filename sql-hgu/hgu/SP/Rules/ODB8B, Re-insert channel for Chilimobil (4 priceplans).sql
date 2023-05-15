SELECT a.*
  FROM sub_typ_soc_channel a
 WHERE a.soc                  IN ('ODB8', 'ODB8B')
   AND a.subscription_type_id IN ('PVJA'||'REG1', 'PVJC'||'REG1', 'PVJD'||'REG1', 'PVJE'||'REG1')
   AND SYSDATE           BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;

INSERT INTO sub_typ_soc_channel
SELECT a.subscription_type_id, a.soc || 'B' AS SOC, a.channel_code,
       TO_DATE('2019-01-08', 'YYYY-MM-DD') AS EFFECTIVE_DATE,
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
 WHERE a.soc IN ('ODB8')
   AND a.channel_code IN ('Chilimobil')
;

SELECT a.*
  FROM sub_typ_soc_channel a
 WHERE a.soc                  IN ('ODB8', 'ODB8B')
   AND a.subscription_type_id IN ('PVJA'||'REG1', 'PVJC'||'REG1', 'PVJD'||'REG1', 'PVJE'||'REG1')
   AND SYSDATE           BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2
;
