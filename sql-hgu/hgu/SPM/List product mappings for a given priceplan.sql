SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, d.description AS "AKA", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping sp, subscription_types_socs sts, socs s, socs_descriptions d
 WHERE sts.subscription_type_id IN ( 'PVKA' || 'REG1' )
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                  = s.soc
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
   AND s.soc                    = d.soc
   AND d.language_code          = 'NO'
ORDER BY 1
;

/*
** Same as above but with descriptions.
*/
SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc || ' (' || sd1.description || ')' AS "SOC", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') || ' (' || sd2.description || ')' AS "PRICE_PLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping     sp
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd1
     , socs_descriptions       sd2
 WHERE sts.subscription_type_id IN ( 'PVKA' || 'REG1' )
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

/*
** Without soc-type & group.
*/
SELECT sp.sp_code, 'maps to soc' AS "MAPS_TO", s.soc, sd1.description AS "SOC_DESCRIPTION"
     , 'on' AS "ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') || ' (' || sd2.description || ')' AS "PRICE_PLAN",
       'since' AS "SINCE", sts.effective_date
  FROM spm_service_mapping     sp
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd1
     , socs_descriptions       sd2
 WHERE sts.subscription_type_id IN ( 'PVKA' || 'REG1' )
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

SELECT a.*
  FROM spm_service_mapping a
 WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY 1,2,3
;
