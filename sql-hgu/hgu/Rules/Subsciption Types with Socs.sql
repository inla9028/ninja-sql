--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all socs (with features etc.) for a given subscription type.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscription_type_id AS "SUBSCR_TYPE", b.soc, e.soc_type, e.soc_group,
       b.feature_code, b.parameter_code, b.parameter_type, b.mandatory,
       b.displayable, b.default_value, b.validation_id, b.is_cloneable,
       d.description
  FROM subscription_types_socs a, feature_parameters b, feat_parms_parm_desc c,
       feature_parameter_desc d, socs e
  WHERE a.subscription_type_id IN ('PUMC'||'REG1', 'PUMD' || 'REG1')
    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
--    AND a.soc            LIKE 'FL_X'
    AND a.soc               = b.soc
    AND a.soc               = e.soc
    AND c.language_code     = 'EN' -- 'NO'
    AND b.soc               = c.soc
    AND b.feature_code      = c.feature_code
    AND b.parameter_code    = c.parameter_code
    AND c.parameter_name_id = d.parameter_name_id    
  ORDER BY a.subscription_type_id, b.soc, b.feature_code, b.parameter_code;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==  
--== List a priceplan (with its' name) and all available socs (with their names)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscription_type_id, b.description AS "PP_DESCRIPTION", a.soc, 
       d.description AS "SOC_DESCRIPTION", a.effective_date,
       a.expiration_date, a.displayable, a.add_mode, a.modify_mode,
       a.delete_mode, a.ninja_mode_activate, a.ninja_mode_change,
       a.ninja_mode_delete, a.ninja_replacement_soc, a.overidden_by_soc,
       a.additionally_adds_soc, a.ninja_default_soc
  FROM subscription_types_socs a, subscription_type_desc b, socs_soc_descriptions c, soc_descriptions d
  WHERE a.subscription_type_id IN ('PSUC'||'REG1')
    AND SYSDATE          BETWEEN a.effective_date AND a.expiration_date
    AND a.subscription_type_id = b.subscription_type_id(+)
    AND b.language_code        = 'NO'
    AND a.soc                  = c.soc(+)
    AND c.soc_name_id          = d.soc_name_id(+)
    AND d.language_code        = b.language_code
  ORDER BY a.subscription_type_id, a.soc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all socs (without features etc.) for a given subscription type.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscription_type_id AS "SUBSCR_TYPE", b.soc, d.description
  FROM subscription_types_socs a, feature_parameters b, feat_parms_parm_desc c,
       feature_parameter_desc d, socs e
  WHERE a.subscription_type_id IN ('PPTRREG1', 'PPTRSEG1', 'PPTRTEG1', 'PPTUREG1',
                                   'PPTVREG1', 'PPTWREG1', 'PPTXREG1', 'PPTYREG1')
--    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
--    AND a.soc            LIKE 'FL_X'
--    and a.soc              IN ('LEAS1', 'LEAS2')
    AND a.soc               = b.soc
    AND a.soc               = e.soc
    AND c.language_code     = 'EN' -- 'NO'
    AND b.soc               = c.soc
    AND b.feature_code      = c.feature_code
    AND b.parameter_code    = c.parameter_code
    AND c.parameter_name_id = d.parameter_name_id    
  ORDER BY a.subscription_type_id, b.soc, b.feature_code, b.parameter_code
