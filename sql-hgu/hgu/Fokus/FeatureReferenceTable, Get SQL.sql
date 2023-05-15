--==
--== The SQL used within class Ninja's FeatureReferenceTable
--==
SELECT /*+ driving_site(rf)*/
       RTRIM (rf.soc)                AS "SOC"
     , RTRIM (f.feature_code)        AS "FEATURE_CODE"
     , RTRIM (f.mps_feature_code)    AS "MPS_FEATURE_CODE"
     , f.service_level
     , RTRIM (f.feature_desc)        AS "FEATURE_DESC"
     , RTRIM (f.switch_code)         AS "SWITCH_CODE"
     , f.csm_param_req_ind
     , RTRIM (f.def_sw_params)       AS "DEF_SW_PARAMS"
     , RTRIM (f.feature_type)        AS "FEATURE_TYPE"
     , f.msisdn_criteria
     , RTRIM (f.tn_class_cd)         AS "TN_CLASS_CD"
     , rf.rc_info_ind
     , ft.mutual_exclus_ind
     , RTRIM (ft.switch_code)        AS "TYPE_SWITCH_CODE"
     , RTRIM (rf.fr_fm_plan_cd)      AS "FR_FM_PLAN_CD"
     , NVL (rf.max_members, 0)       AS "MAX_MEMBERS"
     , NVL (rf.fr_fm_free_digits, 0) AS "FR_FM_FREE_DIGITS"
  FROM rated_feature@fokus rf
     , feature@fokus       f
     , feature_types@fokus ft
 WHERE f.feature_code  = rf.feature_code
   AND f.feature_group = 'SF'
   AND ft.feature_type = f.feature_type
   AND SYSDATE   BETWEEN rf.effective_date AND nvl (rf.expiration_date, SYSDATE + 1)
   AND rf.SOC         IN ( 'PW10', 'PW11' )
ORDER BY soc, feature_code
;

--==
--== TSame as above, but not via a db-link...
--==
SELECT RTRIM (rf.soc)                AS "SOC",
       RTRIM (f.feature_code)        AS "FEATURE_CODE",
       RTRIM (f.mps_feature_code)    AS "MPS_FEATURE_CODE",
       f.service_level,
       RTRIM (f.feature_desc)        AS "FEATURE_DESC",
       RTRIM (f.switch_code)         AS "SWITCH_CODE",
       f.csm_param_req_ind,
       RTRIM (f.def_sw_params)       AS "DEF_SW_PARAMS",
       RTRIM (f.feature_type)        AS "FEATURE_TYPE",
       f.msisdn_criteria,
       RTRIM (f.tn_class_cd)         AS "TN_CLASS_CD",
       rf.rc_info_ind,
       ft.mutual_exclus_ind,
       RTRIM (ft.switch_code)        AS "TYPE_SWITCH_CODE",
       RTRIM (rf.fr_fm_plan_cd)      AS "FR_FM_PLAN_CD",
       NVL (rf.max_members, 0)       AS "MAX_MEMBERS",
       NVL (rf.fr_fm_free_digits, 0) AS "FR_FM_FREE_DIGITS"
  FROM rated_feature rf, feature f, feature_types ft
 WHERE f.feature_code  = rf.feature_code
   AND f.feature_group = 'SF'
   AND ft.feature_type = f.feature_type
   AND SYSDATE BETWEEN rf.effective_date AND NVL (rf.expiration_date, SYSDATE + 1)
ORDER BY soc, feature_code
;

--==
--== Same as above, but with filters for certain socs, features, etc...
--==
SELECT * FROM (
    SELECT RTRIM (rf.soc)                AS "SOC",
           RTRIM (f.feature_code)        AS "FEATURE_CODE",
           RTRIM (f.mps_feature_code)    AS "MPS_FEATURE_CODE",
           f.service_level,
           RTRIM (f.feature_desc)        AS "FEATURE_DESC",
           RTRIM (f.switch_code)         AS "SWITCH_CODE",
           f.csm_param_req_ind,
           RTRIM (f.def_sw_params)       AS "DEF_SW_PARAMS",
           RTRIM (f.feature_type)        AS "FEATURE_TYPE",
           f.msisdn_criteria,
           RTRIM (f.tn_class_cd)         AS "TN_CLASS_CD",
           rf.rc_info_ind,
           ft.mutual_exclus_ind,
           RTRIM (ft.switch_code)        AS "TYPE_SWITCH_CODE",
           RTRIM (rf.fr_fm_plan_cd)      AS "FR_FM_PLAN_CD",
           NVL (rf.max_members, 0)       AS "MAX_MEMBERS",
           NVL (rf.fr_fm_free_digits, 0) AS "FR_FM_FREE_DIGITS"
      FROM rated_feature rf, feature f, feature_types ft
     WHERE f.feature_code  = rf.feature_code
       AND f.feature_group = 'SF'
       AND ft.feature_type = f.feature_type
       AND SYSDATE BETWEEN rf.effective_date AND NVL (rf.expiration_date, SYSDATE + 1)
) WHERE 1 = 1
    AND soc IN ('PAGESEP')
ORDER BY 1,2
;

--==
--== Same as above, but via db-link.
--==
SELECT * FROM (
    SELECT /*+ driving_site(rf)*/
           RTRIM (rf.soc)                AS "SOC",
           RTRIM (f.feature_code)        AS "FEATURE_CODE",
           RTRIM (f.mps_feature_code)    AS "MPS_FEATURE_CODE",
           f.service_level,
           RTRIM (f.feature_desc)        AS "FEATURE_DESC",
           RTRIM (f.switch_code)         AS "SWITCH_CODE",
           f.csm_param_req_ind,
           RTRIM (f.def_sw_params)       AS "DEF_SW_PARAMS",
           RTRIM (f.feature_type)        AS "FEATURE_TYPE",
           f.msisdn_criteria,
           RTRIM (f.tn_class_cd)         AS "TN_CLASS_CD",
           rf.rc_info_ind,
           ft.mutual_exclus_ind,
           RTRIM (ft.switch_code)        AS "TYPE_SWITCH_CODE",
           RTRIM (rf.fr_fm_plan_cd)      AS "FR_FM_PLAN_CD",
           NVL (rf.max_members, 0)       AS "MAX_MEMBERS",
           nvl (rf.fr_fm_free_digits, 0) AS "FR_FM_FREE_DIGITS"
      FROM rated_feature@fokus rf
         , feature@fokus       f
         , feature_types@fokus ft
     WHERE f.feature_code  = rf.feature_code
       AND f.feature_group = 'SF'
       AND ft.feature_type = f.feature_type
       AND SYSDATE BETWEEN rf.effective_date AND NVL (rf.expiration_date, SYSDATE + 1)
) WHERE 1 = 1
    AND soc IN ('PAGESEP')
ORDER BY 1,2
;
