SELECT a.*
  FROM features a
 WHERE a.feature_code LIKE 'S-C%'
ORDER BY 1
;

INSERT INTO features
SELECT 'S-CLIR' AS "FEATURE_CODE"
  FROM dual
 WHERE 1 = 1
;

SELECT a.*
  FROM features a
 WHERE a.feature_code LIKE 'S-C%'
ORDER BY 1
;

SELECT a.soc, a.feature_code, a.feature_type
  FROM socs_features a
 WHERE a.soc IN ('CLIREST', 'HPCLIREST')
;

INSERT INTO socs_features
SELECT 'CLIREST' AS "SOC"
     , 'S-CLIR'  AS "FEATURE_CODE"
     , 'REGULAR' AS "FEATURE_TYPE"
  FROM dual
 WHERE 1 = 1
;

INSERT INTO socs_features
SELECT 'HPCLIREST' AS "SOC"
     , 'S-CLIR'    AS "FEATURE_CODE"
     , 'REGULAR'   AS "FEATURE_TYPE"
  FROM dual
 WHERE 1 = 1
;

SELECT a.soc, a.feature_code, a.feature_type
  FROM socs_features a
 WHERE a.soc IN ('CLIREST', 'HPCLIREST')
;

/*
DELETE
  FROM feature_parameters fp
 WHERE fp.soc IN ('CLIREST','HPCLIREST')
;
*/
SELECT fp.*
  FROM feature_parameters fp
 WHERE fp.soc IN ('CLIREST','HPCLIREST')
ORDER BY 1,2,3
;

/*
CLIREST      S-CLIR  MODE            nnn EN  MTAS Mode
CLIREST      S-CLIR  MODE            nnn NO  MTAS Modus
HPCLIREST    S-CLIR  MODE            nnn EN  MTAS Mode
HPCLIREST    S-CLIR  MODE            nnn NO  MTAS Modus
*/

INSERT INTO feature_parameters
SELECT 'HPCLIREST' AS "SOC"
     , 'S-CLIR'    AS "FEATURE_CODE"
     , 'MODE'      AS "PARAMETER_CODE"
     , 'MTAS_MODE' AS "PARAMETER_TYPE"
     , 'Y'         AS "MANDATORY"
     , 'N'         AS "DISPLAYABLE"
     , 'PERM'      AS "DEFAULT_VALUE" -- Telia: TEMPRES, Phonero: PERM
     , 'MTS_MODE'  AS "VALIDATION_ID"
     , 'N'         AS "IS_CLONEABLE"
     , 'Y'         AS "MODIFIABLE"    -- Displayable=N makes this impossible for clients...
  FROM DUAL
 WHERE 1 = 1
;
 
INSERT INTO feature_parameters
SELECT 'CLIREST'   AS "SOC"
     , 'S-CLIR'    AS "FEATURE_CODE"
     , 'MODE'      AS "PARAMETER_CODE"
     , 'MTAS_MODE' AS "PARAMETER_TYPE"
     , 'Y'         AS "MANDATORY"
     , 'N'         AS "DISPLAYABLE"
     , 'TEMPRES'   AS "DEFAULT_VALUE" -- Telia: TEMPRES, Phonero: PERM
     , 'MTS_MODE'  AS "VALIDATION_ID"
     , 'N'         AS "IS_CLONEABLE"
     , 'Y'         AS "MODIFIABLE"    -- Displayable=N makes this impossible for clients...
  FROM DUAL
 WHERE 1 = 1
;

SELECT fp.*
  FROM feature_parameters fp
 WHERE fp.soc IN ('CLIREST','HPCLIREST')
ORDER BY 1,2,3
;


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
