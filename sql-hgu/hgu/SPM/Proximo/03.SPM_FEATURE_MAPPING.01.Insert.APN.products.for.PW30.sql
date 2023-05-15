select a.*
  from spm_feature_mapping a
 where a.sp_service_code LIKE 'DATA_NGT%'
order by 1,2
;

/*
DATA_NGT_05MBPS
DATA_NGT_10MBPS
DATA_NGT_20MBPS
DATA_NGT_30MBPS
DATA_NGT_40MBPS
DATA_NGT_50MBPS
*/
INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_05MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_05MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_10MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_10MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_20MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_20MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_30MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_30MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_40MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_40MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;


INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_50MBPS' AS SP_SERVICE_CODE
     , 'APN1'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP01'          AS NINJA_FEATURE_CODE
  FROM dual
;

INSERT INTO spm_feature_mapping
SELECT 'DATA_NGT_50MBPS' AS SP_SERVICE_CODE
     , 'APN2'            AS SP_PARAM_CODE
     , 'NAME'            AS NINJA_PARAMETER_CODE
     , 'Y'               AS MANDATORY_IND
     , 'S-AP02'          AS NINJA_FEATURE_CODE
  FROM dual
;