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


