SELECT A.*
  FROM spm_service_mapping A
 WHERE A.sp_code LIKE '5G%'
ORDER BY 1,2
;


SELECT A.*
  FROM socs A
 WHERE A.soc IN (
      'SP10', 'SP100', 'SP200', 'SP300', 'SPNOLIM',
      'SPVOC38', 'SPVOC39', 'SPVOC40', 'SPVOC41', 'SPVOC42', 'SPVOC43', 'SPVOC44', 'SPVOC45'
--      , 'BASIS'
  ) OR A.soc BETWEEN 'SPVOC19' AND 'SPVOC30'
--    or a.soc like 'SP%'
ORDER BY 1,2,3,4
;

SELECT A.*
  FROM socs A
 WHERE A.soc_type IN ( 'SP5G_SPEED_LIM' )
ORDER BY 1,2,3,4
;

--
-- Make 5G_ENABLED (SOC: SP5G) effective again.
--
UPDATE spm_service_mapping sm
   SET sm.effective_date  = to_date('2021-03-22', 'YYYY-MM-DD')
     , sm.expiration_date = to_date('4700-12-31', 'YYYY-MM-DD')
 WHERE sm.sp_code        IN    ( '5G_ENABLED' )
   AND sm.expiration_date < SYSDATE 
;

--
-- Update spm service mapping to expire the rows with old soc-types.
--
UPDATE spm_service_mapping A
   SET A.expiration_date = to_date('2021-03-22', 'YYYY-MM-DD')
 WHERE A.soc_type = 'SP5G_SPEED_LIM'
;

--
-- Insert the new rows
--
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('5G_100_MBPS','SP_SPEED_LIM','SP100',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('5G_10_MBPS','SP_SPEED_LIM','SP10',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('5G_200_MBPS','SP_SPEED_LIM','SP200',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('5G_300_MBPS','SP_SPEED_LIM','SP300',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('5G_UNLIMITED_SPEED','SP_SPEED_LIM','SPNOLIM',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);

INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('DATA_BITPRO_75MBPS','SP_SPEED_LIM','SPVOC42',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('DATA_BITPRO_100MBPS','SP_SPEED_LIM','SPVOC43',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('DATA_BITPRO_200MBPS','SP_SPEED_LIM','SPVOC44',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('DATA_BITPRO_300MBPS','SP_SPEED_LIM','SPVOC45',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);

INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('DATA_NGT_75MBPS','SP_SPEED_LIM','SPVOC38',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('DATA_NGT_100MBPS','SP_SPEED_LIM','SPVOC39',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('DATA_NGT_200MBPS','SP_SPEED_LIM','SPVOC40',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);
INSERT INTO spm_service_mapping (sp_code,soc_type,soc_group,effective_date,expiration_date,comments)
VALUES ('DATA_NGT_300MBPS','SP_SPEED_LIM','SPVOC41',to_date('2021-03-22','YYYY-MM-DD'),to_date('4700-12-31','YYYY-MM-DD'),NULL);

--
-- Insert feature mapping.
--
INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_75MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_75MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_100MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_100MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_200MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_200MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_300MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_300MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_75MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_75MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_100MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_100MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_200MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_200MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_300MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_300MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;
