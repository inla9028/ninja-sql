/*
** Re-enable MVR...
*/
UPDATE spm_service_mapping a
   SET a.effective_date  = TO_DATE('2022-02-08', 'YYYY-MM-DD')
     , a.expiration_date = TO_DATE('4700-12-31', 'YYYY-MM-DD')
 WHERE a.sp_code         = 'MOBILE_VOICE_RECORDER'
   AND a.soc_type        = 'MVRC'
   AND a.soc_group       = 'MVRCVS'
;

/*
** Insert records based on the available socs for the priceplan PVJK.
*/
INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              --
              -- Regular socs...
              --
              , 'MPODV22',   'GPRS'
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, TRUNC(SYSDATE) AS "EFFECTIVE_DATE", sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  = 'PVJK' || 'REG1'
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND sts.subscription_type_id != s.soc || 'REG1'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping a
                                     WHERE a.soc_type  = s.soc_type
                                       AND a.soc_group = s.soc_group
                                       AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND s.soc_type                != 'WAP'
ORDER BY 1,2,3
)
--WHERE sp_code NOT IN (SELECT b.sp_code
--                        FROM spm_service_mapping b
--                       WHERE SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1))
;

/*
** List socs we were unable to add above...
*/
SELECT REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN"
     , s.soc, s.soc_type, s.soc_group, sd.description
  FROM subscription_types_socs sts, socs s, socs_descriptions sd
 WHERE sts.subscription_type_id  = 'PVJK' || 'REG1'
   AND sts.subscription_type_id != sts.soc || 'REG1'
   AND SYSDATE             BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND s.soc                     = sd.soc
   AND sd.language_code          = 'NO'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping a
                                     WHERE a.soc_type  = s.soc_type
                                       AND a.soc_group = s.soc_group)
ORDER BY 1,2
;

/*
** List the SP-codes and products available for a certain priceplan.
** NB! This does not check towards channel-access!
*/
SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, d.description AS "AKA", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping sp, subscription_types_socs sts, socs s, socs_descriptions d
 WHERE sts.subscription_type_id = 'PVJK' || 'REG1'
   AND SYSDATE   BETWEEN sts.effective_date AND sts.expiration_date
   and sts.add_mode    = 'O'
   AND sts.soc         = s.soc
   AND s.soc_type      = sp.soc_type
   AND s.soc_group     = sp.soc_group
   AND SYSDATE   BETWEEN sp.effective_date AND sp.expiration_date
   AND s.soc           = d.soc
   AND d.language_code = 'NO'
ORDER BY 1
;
