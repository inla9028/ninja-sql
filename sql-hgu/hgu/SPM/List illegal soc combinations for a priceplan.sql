SELECT m1.sp_code AS "SPM_CODE_1", sts1.soc AS "SOC_1"
     , m2.sp_code AS "SPM_CODE_2", sts2.soc AS "SOC_2"
     , sic.illegal_ind
  FROM subscription_types_socs sts1
     , subscription_types_socs sts2
     , soc_illegal_comb@fokus  sic
     , socs                    s1
     , socs                    s2
     , spm_service_mapping     m1
     , spm_service_mapping     m2
 WHERE sts1.subscription_type_id = 'PW20' || 'REG1'
   AND SYSDATE             BETWEEN sts1.effective_date AND sts1.expiration_date
   AND sts1.subscription_type_id = sts2.subscription_type_id
   AND SYSDATE             BETWEEN sts2.effective_date AND sts2.expiration_date
   AND sts1.soc                 != sts2.soc
   AND sts1.soc                 IN (RTRIM(sic.soc_first), RTRIM(sic.soc_second))
   AND sts2.soc                 IN (RTRIM(sic.soc_first), RTRIM(sic.soc_second))
   AND sic.illegal_ind           = 'Y'
   AND sts1.soc                  = s1.soc
   AND s1.soc_type               = m1.soc_type
   AND s1.soc_group              = m1.soc_group
   AND sts2.soc                  = s2.soc
   AND s2.soc_type               = m2.soc_type
   AND s2.soc_group              = m2.soc_group
ORDER BY 1,3
;

SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc || ' (' || sd1.description || ')' AS "SOC", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') || ' (' || sd2.description || ')' AS "PRICE_PLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping     sp
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd1
     , socs_descriptions       sd2
 WHERE sts.subscription_type_id LIKE 'PW20' || 'REG1'
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                  = s.soc
   AND s.soc                    = sd1.soc
   AND sd1.language_code        = 'NO'
   AND sts.add_mode             = 'O'
   AND sts.subscription_type_id = sd2.soc || 'REG1'
   AND sd2.language_code        = 'NO'
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
ORDER BY sp.sp_code, sts.subscription_type_id
;