/*
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
 WHERE a.soc IN ('HPSMSP01', 'SMSP+')
   AND a.parameter_name_id = b.parameter_name_id
   AND a.language_code     = b.language_code
ORDER BY 1,2,3,4,5
;

--
-- Copy all features from 'SMSP+' which are missing on 'HPSMSP01'
--
INSERT INTO feat_parms_parm_desc
SELECT 'HPSMSP01' AS "SOC"
     , a.feature_code
     , a.parameter_code
     , (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc) AS "PARAMETER_NAME_ID"
     , a.language_code
  FROM feat_parms_parm_desc a
 WHERE a.soc = 'SMSP+'
   AND (a.feature_code, a.parameter_code, a.language_code) NOT IN (
    SELECT b.feature_code, b.parameter_code, b.language_code
      FROM feat_parms_parm_desc b
     WHERE b.soc = 'HPSMSP01')
;

--
-- Copy the id's as well
--
INSERT INTO feature_parameter_desc
SELECT a.parameter_name_id, d.language_code
     , REPLACE(REPLACE(d.description, 'NetCom', 'Phonero'), 'Telia', 'Phonero') AS "DESCRIPTION"
  FROM feat_parms_parm_desc a, feat_parms_parm_desc b, feature_parameter_desc d
 WHERE a.soc               = 'HPSMSP01'
   AND (a.parameter_name_id, a.language_code) NOT IN (
    SELECT c.parameter_name_id, c.language_code
      FROM feature_parameter_desc c)
   AND b.soc = 'SMSP+'
   AND a.feature_code      = b.feature_code
   AND a.parameter_code    = b.parameter_code
   AND a.language_code     = b.language_code
   AND b.parameter_name_id = d.parameter_name_id
   AND b.language_code     = d.language_code
;

--
-- Insert the new feature parameters manually.
--
-- FEATURE_PARAMETER_DESC
--
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'EN'
  , 'Copy to Mobile'
);
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'NO'
  , 'Copy to Mobile'
);
   
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'EN'
  , 'Copy to Mobile'
);
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'NO'
  , 'Kopi til Mobil'
);

--
-- FEAT_PARMS_PARM_DESC
--
INSERT INTO FEAT_PARMS_PARM_DESC(SOC, FEATURE_CODE, PARAMETER_CODE, PARAMETER_NAME_ID, LANGUAGE_CODE)
SELECT 'HPSMSP01'
     , 'S-SMSP'
     , 'COPY-MSISDN'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'Copy to Mobile'
           AND language_code = 'EN')
     , 'EN'
FROM DUAL;

INSERT INTO FEAT_PARMS_PARM_DESC(SOC, FEATURE_CODE, PARAMETER_CODE, PARAMETER_NAME_ID, LANGUAGE_CODE)
SELECT 'HPSMSP01'
     , 'S-SMSP'
     , 'COPY-MSISDN'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'Kopi til Mobil'
           AND language_code = 'NO')
     , 'NO'
FROM DUAL
;

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
 WHERE a.soc IN ('HPSMSP01', 'SMSP+')
   AND a.parameter_name_id = b.parameter_name_id
   AND a.language_code     = b.language_code
ORDER BY 1,2,3,4,5
;
*/
