SELECT A.*
  FROM spm_feature_mapping A
 WHERE A.sp_service_code LIKE 'DATA_BITPRO%'
    OR A.sp_service_code LIKE 'DATA_NGT%'
ORDER BY 1,2
;

/*
-------  ----------------------------  -------------------------  ----------  ------  -------------------
SOC      SOC_DESCRIPTION               DESC_TEXT SALE_            EFF_DATE    RC_FTR  SPM
-------  ----------------------------  -------------------------  ----------  ------  -------------------
SPVOC38  SP NextGenTel FWA 75 Mbit/s   NextGenTel FWA 75 Mbit/s   2021-03-16  SPPWM   DATA_NGT_75MBPS
SPVOC39  SP NextGenTel FWA 100 Mbit/s  NextGenTel FWA 100 Mbit/s  2021-03-16  SPPWN   DATA_NGT_100MBPS
SPVOC40  SP NextGenTel FWA 200 Mbit/s  NextGenTel FWA 200 Mbit/s  2021-03-16  SPPWO   DATA_NGT_200MBPS
SPVOC41  SP NextGenTel FWA 300 Mbit/s  NextGenTel FWA 300 Mbit/s  2021-03-16  SPPWP   DATA_NGT_300MBPS
SPVOC42  SP Bitpro FWA 75 Mbit/s       Bitpro FWA 75 Mbit/s       2021-03-16  SPPWQ   DATA_BITPRO_75MBPS
SPVOC43  SP Bitpro FWA 100 Mbit/s      Bitpro FWA 100 Mbit/s      2021-03-16  SPPWR   DATA_BITPRO_100MBPS
SPVOC44  SP Bitpro FWA 200 Mbit/s      Bitpro FWA 200 Mbit/s      2021-03-16  SPPWS   DATA_BITPRO_200MBPS
SPVOC45  SP Bitpro FWA 300 Mbit/s      Bitpro FWA 300 Mbit/s      2021-03-16  SPPWT   DATA_BITPRO_300MBPS
-------  ----------------------------  -------------------------  ----------  ------  -------------------
*/
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
