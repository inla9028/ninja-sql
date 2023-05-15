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

