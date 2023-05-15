--
-- List the result _before_ the updates.
--
SELECT a.soc
     , a.feature_code
     , a.parameter_code
     , a.parameter_name_id
     , a.language_code
     , b.description
  FROM feat_parms_parm_desc a, feature_parameter_desc b
 WHERE a.soc IN ('CLIREST', 'HPCLIREST')
   AND a.parameter_name_id = b.parameter_name_id
   AND a.language_code     = b.language_code
ORDER BY 1,2,3,4,5
;

--
-- Insert the new feature parameters manually.
--
-- FEATURE_PARAMETER_DESC
--
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'EN'
  , 'MTAS Mode'
);
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'NO'
  , 'MTAS Modus'
);
   
--
-- FEAT_PARMS_PARM_DESC
--
-- CLIREST
--
INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
SELECT 'CLIREST'
     , 'S-CLIR'
     , 'MODE'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'MTAS Mode'
           AND language_code = 'EN')
     , 'EN'
FROM DUAL;

INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
SELECT 'CLIREST'
     , 'S-CLIR'
     , 'MODE'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'MTAS Modus'
           AND language_code = 'NO')
     , 'NO'
FROM DUAL;

--
-- HPCLIREST
--
INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
SELECT 'HPCLIREST'
     , 'S-CLIR'
     , 'MODE'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'MTAS Mode'
           AND language_code = 'EN')
     , 'EN'
FROM DUAL
;

INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
SELECT 'HPCLIREST'
     , 'S-CLIR'
     , 'MODE'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'MTAS Modus'
           AND language_code = 'NO')
     , 'NO'
FROM DUAL;

--
-- List result...
--
SELECT a.soc
     , a.feature_code
     , a.parameter_code
     , a.parameter_name_id
     , a.language_code
     , b.description
  FROM feat_parms_parm_desc a, feature_parameter_desc b
 WHERE a.soc IN ('CLIREST', 'HPCLIREST')
   AND a.parameter_name_id = b.parameter_name_id
   AND a.language_code     = b.language_code
ORDER BY 1,2,3,4,5
;
