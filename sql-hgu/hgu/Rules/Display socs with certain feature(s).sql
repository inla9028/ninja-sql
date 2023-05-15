--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all features for socs with a specific soc-type & group.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, a.feature_code, a.parameter_code, a.parameter_type,
       a.mandatory, a.displayable, a.default_value, a.validation_id,
       a.is_cloneable
  FROM feature_parameters a, socs b
  WHERE a.soc            = b.soc
    AND b.soc_type       = 'VOICEMAIL'
    AND b.soc_group      = 'VMS'
    AND a.parameter_code = 'WHO-CALLED'
  ORDER BY a.soc

--
SELECT a.soc, COUNT(*) AS "COUNT"
  FROM feature_parameters a, socs b
  WHERE a.soc            = b.soc
    AND b.soc_type       = 'VOICEMAIL'
  GROUP BY a.soc
  ORDER BY a.soc
