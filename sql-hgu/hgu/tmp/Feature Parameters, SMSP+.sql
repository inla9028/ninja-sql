SELECT a.soc, a.feature_code, a.parameter_code, a.parameter_type,
       a.mandatory, a.displayable, a.default_value, a.validation_id,
       a.is_cloneable, c.description
  FROM ninjarules.feature_parameters a, ninjarules.feat_parms_parm_desc b,
       ninjarules.feature_parameter_desc c
  WHERE a.soc               = 'SMSP+'
    AND b.language_code     = 'EN'
    AND a.soc               = b.soc
    AND a.feature_code      = b.feature_code
    AND a.parameter_code    = b.parameter_code
    AND b.parameter_name_id = c.parameter_name_id    
  ORDER BY a.soc, a.feature_code, a.parameter_code
