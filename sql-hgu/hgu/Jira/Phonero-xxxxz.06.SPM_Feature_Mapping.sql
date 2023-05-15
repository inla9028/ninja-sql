SELECT a.sp_service_code, a.sp_param_code, a.ninja_parameter_code,
       a.mandatory_ind, a.ninja_feature_code
  FROM spm_feature_mapping a
;

/*
DELETE FROM spm_feature_mapping
;
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


