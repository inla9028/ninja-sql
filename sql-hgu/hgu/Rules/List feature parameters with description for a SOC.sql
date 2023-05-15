SELECT a.soc, a.feature_code, a.parameter_code, b.description,
       a.default_value, a.parameter_type, a.mandatory, a.displayable,
       a.validation_id, a.is_cloneable, a.modifiable
  FROM feature_parameters a, feature_parameter_desc b, feat_parms_parm_desc c
 WHERE a.soc            LIKE 'VMACC02%'
   AND a.soc               = c.soc
   AND a.feature_code      = c.feature_code
   AND a.parameter_code    = c.parameter_code
   AND c.language_code     = 'NO'
   AND c.parameter_name_id = b.parameter_name_id
ORDER BY 1,2,3
;
