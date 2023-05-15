SELECT A.*
  FROM spm_feature_mapping A
 WHERE A.sp_service_code LIKE 'DATA_NGT%'
ORDER BY 1,2
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_CABIN_30MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_CABIN_30MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_CABIN_50MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_CABIN_50MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_CABIN_100MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_CABIN_100MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;

/*
** Finally, display the results...
*/
SELECT UNIQUE ssm.sp_code, 'maps to' AS "MAPS_TO", ssm.soc_type, ssm.soc_group
     , 'which points to' AS "POINTS_TO", s.soc, sd.description AS "AKA"
     , 'with property' AS "WITH", sfm.sp_param_code, 'which is mapped to' AS "MAPPED_TO"
     , DECODE(
         sfm.ninja_feature_code
         , NULL, sfm.ninja_parameter_code
         , sfm.ninja_feature_code || '/' || ninja_parameter_code
       ) AS "FEATURE_PARAMETER"
     , 'which is' AS "WHICH_IS"
     , DECODE(
         sfm.mandatory_ind
         , 'Y', 'which is mandatory'
         , 'not mandatory'
       ) AS "MANDATORY"
  FROM spm_feature_mapping     sfm
     , spm_service_mapping     ssm
     , spm_priceplan_mapping   spm
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd
 WHERE sfm.sp_service_code      = ssm.sp_code
   AND ssm.soc_type             = s.soc_type
   AND ssm.soc_group            = s.soc_group
   AND s.soc                    = sts.soc
   AND sts.subscription_type_id IN ( 'PW30' || 'REG1' )
   AND SYSDATE            BETWEEN sts.effective_date AND NVL(sts.expiration_date, SYSDATE + 1)
   AND sts.soc                  = sd.soc
   AND sd.language_code         = 'NO'
ORDER BY 1,3,6,9
;

