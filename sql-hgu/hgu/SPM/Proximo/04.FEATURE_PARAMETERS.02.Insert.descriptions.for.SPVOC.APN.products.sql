SELECT a.*
  FROM feat_parms_parm_desc a
 WHERE (a.soc IN ( 'SPAPN01', 'SPAPN02' ) OR a.soc LIKE 'SPVOC%')
   AND a.parameter_code IN ( 'NAME' )
ORDER BY 1,2,3,4
;


INSERT INTO feat_parms_parm_desc
SELECT 'SPVOC19' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_name_id, a.language_code
  FROM feat_parms_parm_desc a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feat_parms_parm_desc
SELECT 'SPVOC20' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_name_id, a.language_code
  FROM feat_parms_parm_desc a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feat_parms_parm_desc
SELECT 'SPVOC21' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_name_id, a.language_code
  FROM feat_parms_parm_desc a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feat_parms_parm_desc
SELECT 'SPVOC22' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_name_id, a.language_code
  FROM feat_parms_parm_desc a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feat_parms_parm_desc
SELECT 'SPVOC23' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_name_id, a.language_code
  FROM feat_parms_parm_desc a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feat_parms_parm_desc
SELECT 'SPVOC24' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_name_id, a.language_code
  FROM feat_parms_parm_desc a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;
