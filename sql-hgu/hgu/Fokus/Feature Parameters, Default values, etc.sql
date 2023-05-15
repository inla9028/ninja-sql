/*
** List a certain set of socs and a certain set of features and parameters for them.
*/
SELECT rf.soc, RTRIM(s.soc_description) AS "SOC_DESCRIPTION"
     , s.sys_creation_date, s.sale_exp_date, s.service_type, rf.feature_code
     , RTRIM(f.feature_desc) AS "FEATURE_DESC", f.revenue_code
     , f.switch_act_needed, f.feature_type, f.switch_code, f.def_sw_params
  FROM rated_feature rf, soc s, feature f
 WHERE 1 = 1
   AND rf.feature_code  LIKE 'S-BA%'
   AND rf.expiration_date IS NULL
   AND s.expiration_date  IS NULL
   AND s.soc               = rf.soc
   AND RTRIM(s.soc)       IN ('MBNPAUS01')
   AND rf.feature_code     = f.feature_code
ORDER BY rf.soc, rf.feature_code
;

/*
** Via db-link.
*/
SELECT /*+ driving_site(rf)*/
       rf.soc, RTRIM(s.soc_description) AS "SOC_DESCRIPTION"
     , s.sys_creation_date, s.sale_exp_date, s.service_type, rf.feature_code
     , RTRIM(f.feature_desc) AS "FEATURE_DESC", f.revenue_code
     , f.switch_act_needed, f.feature_type, f.switch_code, f.def_sw_params
  FROM rated_feature@fokus rf, soc@fokus s, feature@fokus f
 WHERE 1 = 1
   AND rf.feature_code  LIKE 'S-AP%'
   AND rf.expiration_date IS NULL
   AND s.expiration_date  IS NULL
   AND s.soc               = rf.soc
   AND RTRIM(s.soc)       IN ('SPVOC19')
   AND rf.feature_code     = f.feature_code
ORDER BY rf.soc, rf.feature_code
;
