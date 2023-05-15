/*
** List feature parameters mapped via SPM for a certain priceplan(s).
*/
SELECT UNIQUE ssm.sp_code, 'maps to' AS "MAPS_TO", ssm.soc_type, ssm.soc_group
     , 'which points to' AS "POINTS_TO", s.soc, sd.description AS "AKA"
     , 'with property' AS "WITH", sfm.sp_param_code AS "PROPERTY"
     , 'which is mapped to' AS "MAPPED_TO"
     , DECODE(
         sfm.ninja_feature_code
         , NULL, sfm.ninja_parameter_code
         , sfm.ninja_feature_code || '/' || ninja_parameter_code
       ) AS "FEATURE_PARAMETER"
     , DECODE(
         sfm.mandatory_ind
         , 'Y', 'which is mandatory'
         , 'which isn''t mandatory'
       ) AS "MANDATORY"
  FROM spm_feature_mapping     sfm
     , spm_service_mapping     ssm
     , spm_priceplan_mapping   spm
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd
 WHERE sfm.sp_service_code      = ssm.sp_code
   AND SYSDATE            BETWEEN ssm.effective_date AND NVL(ssm.expiration_date, SYSDATE + 1)
   AND ssm.soc_type             = s.soc_type
   AND ssm.soc_group            = s.soc_group
   AND s.soc                    = sts.soc
   AND sts.subscription_type_id LIKE 'PW2_' || 'REG1'
   AND SYSDATE            BETWEEN sts.effective_date AND nvl(sts.expiration_date, SYSDATE + 1)
   --
--   AND ssm.sp_code            LIKE '5G%'
--   AND ssm.sp_code            LIKE 'BAR%'
--   AND ssm.sp_code            LIKE 'MOBILE%'
--   AND sts.soc               LIKE 'MPOD%'
   --
   AND sts.soc                  = sd.soc
   AND sd.language_code         = 'NO'
ORDER BY 1,3,4,6,9
;

/*
** List feature parameters mapped via SPM for a certain priceplan(s),
** including the feature_parameter settings...
*/
SELECT UNIQUE ssm.sp_code, 'maps to' AS "MAPS_TO", ssm.soc_type, ssm.soc_group
     , 'points to' AS "POINTS_TO", s.soc, sd.description AS "AKA"
     , 'with property' AS "WITH", sfm.sp_param_code AS "PROPERTY"
     , 'maps to' AS "MAPPED_TO"
     , DECODE(
         sfm.ninja_feature_code
         , NULL, sfm.ninja_parameter_code
         , sfm.ninja_feature_code || '/' || ninja_parameter_code
       ) AS "FEATURE_PARAMETER"
     , DECODE(sfm.mandatory_ind, 'Y', 'Yes' , 'No') AS "MANDATORY"
     , fp.default_value, fp.validation_id, fp.modifiable
  FROM spm_feature_mapping     sfm
     , spm_service_mapping     ssm
     , spm_priceplan_mapping   spm
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd
     , feature_parameters      fp
 WHERE sfm.sp_service_code      = ssm.sp_code
   AND SYSDATE            BETWEEN ssm.effective_date AND NVL(ssm.expiration_date, SYSDATE + 1)
   AND ssm.soc_type             = s.soc_type
   AND ssm.soc_group            = s.soc_group
   AND s.soc                    = sts.soc
   AND sts.subscription_type_id LIKE 'PW2_' || 'REG1'
   AND SYSDATE            BETWEEN sts.effective_date AND nvl(sts.expiration_date, SYSDATE + 1)
   AND fp.soc                   = s.soc     
   --
--   AND ssm.sp_code            LIKE '5G%'
--   AND ssm.sp_code            LIKE 'BAR%'
--   AND ssm.sp_code            LIKE 'MOBILE%'
--   AND sts.soc               LIKE 'MPOD%'
   --
   AND sts.soc                  = sd.soc
   AND sd.language_code         = 'NO'
ORDER BY 1,3,4,6,9
;

/*
** Same as above but for ALL priceplans.
*/
SELECT UNIQUE ssm.sp_code, 'maps to' AS "MAPS_TO", ssm.soc_type, ssm.soc_group
     , 'which points to' AS "POINTS_TO", s.soc, sd.description AS "AKA"
     , 'with property' AS "WITH", sfm.sp_param_code AS "PROPERTY"
     , 'which is mapped to' AS "MAPPED_TO"
     , DECODE(
         sfm.ninja_feature_code
         , NULL, sfm.ninja_parameter_code
         , sfm.ninja_feature_code || '/' || ninja_parameter_code
       ) AS "FEATURE_PARAMETER"
     , DECODE(
         sfm.mandatory_ind
         , 'Y', 'which is mandatory'
         , 'which isn''t mandatory'
       ) AS "MANDATORY"
  FROM spm_feature_mapping     sfm
     , spm_service_mapping     ssm
     , spm_priceplan_mapping   spm
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd
 WHERE sfm.sp_service_code       = ssm.sp_code
   AND SYSDATE             BETWEEN ssm.effective_date AND NVL(ssm.expiration_date, SYSDATE + 1)
   AND ssm.soc_type              = s.soc_type
   AND ssm.soc_group             = s.soc_group
   AND s.soc                     = sts.soc
   AND sts.subscription_type_id IN (SELECT a.soc_code || 'REG1'
                                      FROM spm_priceplan_mapping a
                                     WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND SYSDATE             BETWEEN sts.effective_date AND NVL(sts.expiration_date, SYSDATE + 1)
   AND sts.soc                   = sd.soc
   AND sd.language_code          = 'NO'
ORDER BY 1,3,4,6,9
;
