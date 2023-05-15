SELECT A.*
  FROM spm_feature_mapping A
 WHERE A.sp_service_code LIKE 'DATA_BITPRO%'
ORDER BY 1,2
;

/*
DATA_BITPRO_05MBPS
DATA_BITPRO_10MBPS
DATA_BITPRO_20MBPS
DATA_BITPRO_30MBPS
DATA_BITPRO_40MBPS
DATA_BITPRO_50MBPS
*/
INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_05MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_05MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_10MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_10MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_20MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_20MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_30MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_30MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_40MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_40MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_50MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_BITPRO_50MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;