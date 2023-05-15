SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICE_PLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping sp, subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id IN (SELECT a.soc_code || 'REG1'
                                      FROM spm_priceplan_mapping a
                                     WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc       = s.soc
   AND sts.add_mode  = 'O'
   AND s.soc_type    = sp.soc_type
   AND s.soc_group   = sp.soc_group
ORDER BY sp.sp_code, sts.subscription_type_id
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
 WHERE sts.subscription_type_id IN (SELECT a.soc_code || 'REG1'
                                      FROM spm_priceplan_mapping a
                                     WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                  = s.soc
--   AND s.soc                 LIKE 'TWIN%'
   AND s.soc                    = sd1.soc
   AND sd1.language_code        = 'NO'
   AND sts.add_mode             = 'O'
   AND sts.subscription_type_id = sd2.soc || 'REG1'
   AND sd2.language_code        = 'NO'
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
--   AND s.soc IN ('ODB7', 'ODB7B', 'ODB7C', 'ODBP1', 'ODBP2', 'ODBP3', 'ODBP4')
--   AND s.soc IN ('ODB8', 'ODB8B')
--   AND s.soc_type IN ('SPVOC')
ORDER BY sp.sp_code, sts.subscription_type_id
;


/*
** List any mappings where the SP_CODE is corresponds to a SOC code.
*/
SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, 'which is allowed on' AS "ALLOWED_ON", 
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICE_PLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping sp, subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id IN (SELECT a.soc_code || 'REG1'
                                      FROM spm_priceplan_mapping a
                                     WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc       = s.soc
   AND s.soc_type    = sp.soc_type
   AND s.soc_group   = sp.soc_group
   AND sp.sp_code    IN (SELECT sts2.soc
                           FROM subscription_types_socs sts2
                          WHERE sts2.subscription_type_id = sts.subscription_type_id
                            AND SYSDATE             BETWEEN sts2.effective_date AND sts2.expiration_date
                            AND sts2.add_mode             = 'O')
ORDER BY sp.sp_code, sts.subscription_type_id
;

