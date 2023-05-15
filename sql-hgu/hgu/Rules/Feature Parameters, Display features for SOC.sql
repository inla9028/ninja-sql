--==
--== Display the features (including their descriptions) for soc(s).
--==
SELECT   a.soc, a.feature_code, a.parameter_code, a.parameter_type,
         a.mandatory, a.displayable, a.default_value, a.validation_id,
         a.is_cloneable, c.description
    FROM /* ninjarules. */ feature_parameters a,
         /* ninjarules. */ feat_parms_parm_desc b,
         /* ninjarules. */ feature_parameter_desc c
   WHERE a.soc              IN ('MTSIMAC')
     AND a.soc               = b.soc
     AND a.feature_code      = b.feature_code
     AND a.parameter_code    = b.parameter_code
     AND b.language_code     = 'NO'
--     AND b.language_code     = 'EN'
     AND b.parameter_name_id = c.parameter_name_id
     AND b.language_code     = c.language_code
ORDER BY a.soc, a.feature_code, a.parameter_code, a.parameter_type;


---
--==
--== Display the features (including their descriptions) for soc(s).
--==
SELECT   a.soc, a.feature_code, a.parameter_code, a.parameter_type,
         a.mandatory, a.displayable, a.default_value, a.validation_id,
         a.is_cloneable--, c.description
    FROM /* ninjarules. */ feature_parameters a--,
         /* ninjarules. */ -- feat_parms_parm_desc b,
         /* ninjarules. */ -- feature_parameter_desc c
   WHERE a.soc              IN ('MTSIMAC')
/*     AND a.soc               = b.soc
     AND a.feature_code      = b.feature_code
     AND a.parameter_code    = b.parameter_code
     AND b.language_code     = 'NO'
--     AND b.language_code     = 'EN'
     AND b.parameter_name_id = c.parameter_name_id
     AND b.language_code     = c.language_code*/
ORDER BY a.soc, a.feature_code, a.parameter_code, a.parameter_type;

--==
--== From NinjaFeatureParmsReferenceTable
--==
SELECT fp.soc
     , fp.feature_code
     , fp.parameter_code
     , fp.parameter_type
     , fp.mandatory
     , fp.displayable
     , fp.default_value
     , fp.validation_id
     , fp.is_cloneable
     , fp.modifiable
     , fpd.description
     , fppd.language_code
  FROM feature_parameters     fp,
       feat_parms_parm_desc   fppd,
       feature_parameter_desc fpd
 WHERE fppd.soc              (+)= fp.soc
   AND fppd.feature_code     (+)= fp.feature_code
   AND fppd.parameter_code   (+)= fp.parameter_code
   AND fpd.parameter_name_id (+)= fppd.parameter_name_id
   AND fpd.language_code     (+)= fppd.language_code
   -- Added for fun... :)
   AND fp.soc         LIKE 'M_SIMAC'
   AND fp.parameter_code = 'DESCRIPTION'
ORDER BY fp.soc, fp.feature_code, fp.parameter_code
;
