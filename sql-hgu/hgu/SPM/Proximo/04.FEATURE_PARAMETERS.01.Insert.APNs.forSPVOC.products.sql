SELECT a.*
  FROM feature_parameters a
 WHERE (a.soc IN ( 'SPAPN01', 'SPAPN02' ) OR a.soc LIKE 'SPVOC%')
   AND a.parameter_code IN ( 'NAME', 'BANDWIDTHDOWN', 'BANDWIDTHUP' )
ORDER BY 1,2,3,4
;

/*
DATA_NGT_05MBPS	maps to	SPVOC	SPVOC19
DATA_NGT_10MBPS	maps to	SPVOC	SPVOC20
DATA_NGT_20MBPS	maps to	SPVOC	SPVOC21
DATA_NGT_30MBPS	maps to	SPVOC	SPVOC22
DATA_NGT_40MBPS	maps to	SPVOC	SPVOC23
DATA_NGT_50MBPS	maps to	SPVOC	SPVOC24
*/

INSERT INTO feature_parameters
SELECT 'SPVOC19' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_type, a.mandatory
     , a.displayable, a.default_value, a.validation_id, a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feature_parameters
SELECT 'SPVOC20' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_type, a.mandatory
     , a.displayable, a.default_value, a.validation_id, a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feature_parameters
SELECT 'SPVOC21' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_type, a.mandatory
     , a.displayable, a.default_value, a.validation_id, a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feature_parameters
SELECT 'SPVOC22' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_type, a.mandatory
     , a.displayable, a.default_value, a.validation_id, a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feature_parameters
SELECT 'SPVOC23' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_type, a.mandatory
     , a.displayable, a.default_value, a.validation_id, a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

INSERT INTO feature_parameters
SELECT 'SPVOC24' AS SOC
     , a.feature_code, a.parameter_code, a.parameter_type, a.mandatory
     , a.displayable, a.default_value, a.validation_id, a.is_cloneable, a.modifiable
  FROM feature_parameters a
 WHERE a.soc IN ( 'SPAPN01', 'SPAPN02' )
ORDER BY 1,2,3,4
;

-- Hide all irrelevant features...
UPDATE feature_parameters a
   SET a.displayable         = 'N'
     , a.modifiable          = 'N'
 WHERE a.soc                IN ( 'SPVOC19', 'SPVOC20', 'SPVOC21', 'SPVOC22', 'SPVOC23', 'SPVOC24' )
   AND a.parameter_code NOT IN ( 'NAME' )
;

-- Set the relevant speeds.
UPDATE feature_parameters a
   SET a.default_value       = DECODE(a.soc
                                    , 'SPVOC19', TO_CHAR( 5 * 1024 * 1024)
                                    , 'SPVOC20', TO_CHAR(10 * 1024 * 1024)
                                    , 'SPVOC21', TO_CHAR(20 * 1024 * 1024)
                                    , 'SPVOC22', TO_CHAR(30 * 1024 * 1024)
                                    , 'SPVOC23', TO_CHAR(40 * 1024 * 1024)
                                    , 'SPVOC24', TO_CHAR(50 * 1024 * 1024)
                                    , '0')
 WHERE a.soc                IN ( 'SPVOC19', 'SPVOC20', 'SPVOC21', 'SPVOC22', 'SPVOC23', 'SPVOC24' )
   AND a.parameter_code     IN ( 'BANDWIDTHDOWN', 'BANDWIDTHUP' )
;
