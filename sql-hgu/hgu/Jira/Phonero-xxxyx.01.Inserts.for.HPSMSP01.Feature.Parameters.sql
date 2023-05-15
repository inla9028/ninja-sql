/*
DELETE
  FROM feature_parameters fp
 WHERE fp.soc          = 'HPSMSP01'
;
*/
SELECT fp.*
  FROM feature_parameters fp
 WHERE fp.soc          = 'HPSMSP01'
   AND fp.feature_code = 'S-SMSP'
ORDER BY 1,2,3
;

/*
HPSMSP01    S-SMCP  AUTO-REPLY-MSG  885 EN  Auto Reply Message                    
HPSMSP01    S-SMCP  AUTO-REPLY-MSG  886 NO  Auto Svar Melding                     
HPSMSP01    S-SMCP  COPY-EMAIL      881 EN  Copy to Email                         
HPSMSP01    S-SMCP  COPY-EMAIL      882 NO  Kopi til Email                        
HPSMSP01    S-SMCP  COPY-MSISDN     877 EN  Copy to Mobile                        
HPSMSP01    S-SMCP  COPY-MSISDN     878 NO  Kopi til Mobil                        
*/

INSERT INTO feature_parameters
SELECT 'HPSMSP01' AS "SOC"
     , 'S-SMSP'   AS "FEATURE_CODE"
     , DECODE(fp.parameter_code
                , 'COPY',   'SMS-COPY'
                , 'MSISDN', 'COPY-MSISDN'
                , fp.parameter_code) AS "PARAMETER_CODE"
     , fp.parameter_type
     , fp.mandatory
     , DECODE(fp.parameter_code
                , 'AUTO-REPLY-MSG', 'N'
                , fp.displayable) AS "DISPLAYABLE"
     , fp.default_value
     , fp.validation_id
     , fp.is_cloneable
     , fp.modifiable
  FROM feature_parameters fp
 WHERE fp.soc             = 'SMS+'
   AND fp.feature_code    = 'S-SMSP'
   AND fp.parameter_code IN ('AUTO-REPLY-MSG', 'COPY-EMAIL', 'COPY', 'MSISDN')
 ;

/*
Current parameters:
    AUTO-REPLY=N@FORWARD-IND=N@COPY=N@COPY-EMAIL=berntsenmorten83#gmail.com@

Additional parameters:
    SMS-COPY=Y@COPY-MSISDN=04747230001@
*/

/*
INSERT INTO feature_parameters
SELECT * FROM
(
    SELECT 'HPSMSP01' AS "SOC"
         , 'S-SMCP' AS "FEATURE_CODE"
         , fp.parameter_code
         , fp.parameter_type
         , fp.mandatory
         , DECODE(fp.parameter_code
                , 'AUTO-REPLY-MSG', 'N'
                , fp.displayable) AS "DISPLAYABLE"
         , fp.default_value
         , fp.validation_id
         , fp.is_cloneable
         , fp.modifiable
      FROM feature_parameters fp
     WHERE fp.soc          = 'SMS+'
       AND fp.feature_code = 'S-SMSP'
    ORDER BY 1,2,3
);
*/

/*
INSERT INTO feature_parameters
SELECT * FROM
(
    SELECT fp.soc
         , 'S-SMCP' AS "FEATURE_CODE"
         , DECODE(fp.parameter_code
                , 'COPY',   'SMS-COPY'
                , 'MSISDN', 'COPY-MSISDN'
                , fp.parameter_code) AS "PARAMETER_CODE"
         , fp.parameter_type
         , fp.mandatory
         , fp.displayable
         , fp.default_value
         , fp.validation_id
         , fp.is_cloneable
         , fp.modifiable
      FROM feature_parameters fp
     WHERE fp.soc          = 'HPSMSP01'
       AND fp.feature_code = 'S-SMCP'
       AND fp.parameter_code IN ( 'COPY', 'MSISDN' )
    ORDER BY 1,2,3
);
*/

SELECT fp.*
  FROM feature_parameters fp
 WHERE fp.soc          = 'HPSMSP01'
   AND fp.feature_code = 'S-SMSP'
ORDER BY 1,2,3
;


