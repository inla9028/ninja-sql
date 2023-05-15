SELECT a.subscription_type_id, a.soc, a.effective_date,
       a.expiration_date, a.displayable, a.add_mode, a.modify_mode,
       a.delete_mode, a.ninja_mode_activate, a.ninja_mode_change,
       a.ninja_mode_delete, a.ninja_replacement_soc, a.overidden_by_soc,
       a.additionally_adds_soc, a.ninja_default_soc
  FROM subscription_types_socs a
 WHERE a.subscription_type_id = 'PW20'||'REG1'
   AND a.soc                  = 'HPTSP01'
ORDER BY 1,2
;

SELECT a.subscription_type_id, a.soc, a.channel_code, a.effective_date,
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
 WHERE a.subscription_type_id = 'PW20'||'REG1'
   AND a.soc                  = 'HPTSP01'
;

SELECT MAX (a.parameter_name_id)
  FROM feature_parameter_desc a
;

SELECT s.soc || ' (' || sd1.description || ')' AS "SOC", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') || ' (' || sd2.description || ')' AS "PRICE_PLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM subscription_types_socs sts
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
ORDER BY 3,1
;

SELECT fp.*, fpd.description
  FROM feature_parameters fp, feature_parameter_desc fpd, feat_parms_parm_desc fppd
 WHERE fp.soc                 = 'HPTSP01'
   AND fp.soc                 = fppd.soc
   AND fp.feature_code        = fppd.feature_code
   AND fp.parameter_code      = fppd.parameter_code
   AND fppd.parameter_name_id = fpd.parameter_name_id
   AND fppd.language_code     = fpd.language_code
   AND fpd.language_code      = 'EN'
ORDER BY 1,2,3
;

