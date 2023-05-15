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
INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
SELECT 'HPSMSP01'
     , 'S-SMSP'
     , 'COPY-MSISDN'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'Copy to Mobile'
           AND language_code = 'EN')
     , 'EN'
FROM DUAL;

INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
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
-- FEATURE_PARAMETER_DESC
--
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'EN'
  , 'Copy to Email'
);
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'NO'
  , 'Copy to Email'
);
   
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'EN'
  , 'Copy to Email'
);
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'NO'
  , 'Kopi til Email'
);

--
-- FEAT_PARMS_PARM_DESC
--
INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
SELECT 'HPSMSP01'
     , 'S-SMSP'
     , 'COPY-EMAIL'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'Copy to Email'
           AND language_code = 'EN')
     , 'EN'
FROM DUAL;

INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
SELECT 'HPSMSP01'
     , 'S-SMSP'
     , 'COPY-EMAIL'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'Kopi til Email'
           AND language_code = 'NO')
     , 'NO'
FROM DUAL
;

--
-- FEATURE_PARAMETER_DESC
--
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'EN'
  , 'Auto Reply Message'
);
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'NO'
  , 'Auto Reply Message'
);
   
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'EN'
  , 'Auto Reply Message'
);
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'NO'
  , 'Auto Svar Melding'
);

--
-- FEAT_PARMS_PARM_DESC
--
INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
SELECT 'HPSMSP01'
     , 'S-SMSP'
     , 'AUTO-REPLY-MSG'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'Auto Reply Message'
           AND language_code = 'EN')
     , 'EN'
FROM DUAL;

INSERT INTO feat_parms_parm_desc(soc, feature_code, parameter_code, parameter_name_id, language_code)
SELECT 'HPSMSP01'
     , 'S-SMSP'
     , 'AUTO-REPLY-MSG'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'Auto Svar Melding'
           AND language_code = 'NO')
     , 'NO'
FROM DUAL
;

--
-- FEATURE_PARAMETER_DESC
--
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'EN'
  , 'Copy to SMS'
);
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'NO'
  , 'Copy to SMS'
);
   
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'EN'
  , 'Copy to SMS'
);
INSERT INTO feature_parameter_desc(parameter_name_id, language_code, description) VALUES(
  (SELECT MAX(parameter_name_id) + 1 FROM feature_parameter_desc)
  , 'NO'
  , 'Kopi til SMS'
);

--
-- FEAT_PARMS_PARM_DESC
--
INSERT INTO FEAT_PARMS_PARM_DESC(SOC, FEATURE_CODE, PARAMETER_CODE, PARAMETER_NAME_ID, LANGUAGE_CODE)
SELECT 'HPSMSP01'
     , 'S-SMSP'
     , 'SMS-COPY'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'Copy to SMS'
           AND language_code = 'EN')
     , 'EN'
FROM DUAL;

INSERT INTO FEAT_PARMS_PARM_DESC(SOC, FEATURE_CODE, PARAMETER_CODE, PARAMETER_NAME_ID, LANGUAGE_CODE)
SELECT 'HPSMSP01'
     , 'S-SMSP'
     , 'SMS-COPY'
     , (SELECT MAX(parameter_name_id)
          FROM feature_parameter_desc
         WHERE description   = 'Kopi til SMS'
           AND language_code = 'NO')
     , 'NO'
FROM DUAL
;

--
-- Insert new feature code
--
/*
INSERT INTO features(feature_code)
SELECT 'S-SMCP'
  FROM DUAL
;

SELECT a.*
  FROM features a
 WHERE a.feature_code LIKE 'S-SM%'
;
*/

--
-- Update the feature code of the 'HPSMSP01' soc
--
/*
UPDATE feat_parms_parm_desc a
   SET a.feature_code = 'S-SMCP'
 WHERE a.soc          = 'HPSMSP01'
   AND a.feature_code = 'S-SMSP'
;

UPDATE feature_parameters a
   SET a.feature_code = 'S-SMCP'
 WHERE a.soc          = 'HPSMSP01'
   AND a.feature_code = 'S-SMSP'
;

UPDATE socs_features a
   SET a.feature_code = 'S-SMCP'
 WHERE a.soc          = 'HPSMSP01'
   AND a.feature_code = 'S-SMSP'
;
*/

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
