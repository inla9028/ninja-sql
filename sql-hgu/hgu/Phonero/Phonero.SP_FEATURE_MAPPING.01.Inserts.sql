/*
** Display current content.
*/
SELECT a.sp_service_code, a.sp_param_code, a.ninja_parameter_code,
       a.mandatory_ind, a.ninja_feature_code
  FROM spm_feature_mapping a
;

/*
** Empty the current table..
*/
DELETE FROM spm_feature_mapping
;

/*
** Insert new rows, based on the existing displayable features in Ninja.
*/
INSERT INTO spm_feature_mapping
SELECT * FROM
(
    SELECT sm.sp_code        AS "SP_SERVICE_CODE"
         , fp.parameter_code AS "SP_PARAM_CODE"
         , fp.parameter_code AS "NINJA_PARAMETER_CODE"
         , fp.mandatory      AS "MANDATORY_IND"
         , DECODE(fp.feature_code -- Only add Ninja Feature Code for ISDN96
                , 'ISDN96', 'ISDN96'
                , 'B-DA26', 'B-DA26'
                , NULL)      AS "NINJA_FEATURE_CODE"
      FROM socs s, spm_service_mapping sm, feature_parameters fp, subscription_types_socs sts
     WHERE sts.subscription_type_id = 'PW10' || 'REG1'
       AND SYSDATE BETWEEN sts.effective_date AND NVL(sts.expiration_date, SYSDATE + 1)
       AND sts.soc        = s.soc
       AND sm.soc_type    = s.soc_type
       AND sm.soc_group   = s.soc_group
       AND SYSDATE BETWEEN sm.effective_date AND NVL(sm.expiration_date, SYSDATE + 1)
       AND s.soc          = fp.soc
       AND fp.displayable = 'Y'
    ORDER BY 1,2,3
);

/*
** Additional updates, easier here than above...
*/
UPDATE spm_feature_mapping sfm
   SET sfm.sp_param_code   = 'FORWARD-MSISDN'
 WHERE sfm.sp_service_code = 'SMS_COPY'
   AND sfm.sp_param_code   = 'MSISDN'
;

UPDATE spm_feature_mapping sfm
   SET sfm.sp_param_code   = 'MO-EMAIL'
 WHERE sfm.sp_service_code = 'SMS_STORAGE'
   AND sfm.sp_param_code   = 'MOEMAIL'
;

UPDATE spm_feature_mapping sfm
   SET sfm.sp_param_code   = 'MT-EMAIL'
 WHERE sfm.sp_service_code = 'SMS_STORAGE'
   AND sfm.sp_param_code   = 'MTEMAIL'
;

/*
** Finally, display the results...
*/
SELECT ssm.sp_code, 'maps to' AS "MAPS_TO", ssm.soc_type, ssm.soc_group
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
   AND sts.subscription_type_id = 'PW10' || 'REG1'
   AND SYSDATE            BETWEEN sts.effective_date AND NVL(sts.expiration_date, SYSDATE + 1)
   AND sts.soc                  = sd.soc
   AND sd.language_code         = 'NO'
;


