--==
--== Used by Ninja's ChargeInfoReferenceTable
--==
SELECT RTRIM(FEATURE_CODE)         AS "FEATURE_CODE",
       RTRIM(CHARGE_TYPE)          AS "CHARGE_TYPE",
       RTRIM(FTR_REVENUE_CODE)     AS "FTR_REVENUE_CODE",
       RTRIM(MANUAL_OC_CREATE_IND) AS "MANUAL_OC_CREATE_IND",
       RTRIM(MNL_OC_TXT_OVRD_IND)  AS "MNL_OC_TXT_OVRD_IND"
  FROM charge_info
;

SELECT * FROM (
SELECT RTRIM(ci.feature_code)         AS "FEATURE_CODE",
       RTRIM(ci.Charge_Type)          AS "CHARGE_TYPE",
       RTRIM(ci.ftr_revenue_code)     AS "FTR_REVENUE_CODE",
       RTRIM(ci.manual_oc_create_ind) AS "MANUAL_OC_CREATE_IND",
       RTRIM(ci.mnl_oc_txt_ovrd_ind)  AS "MNL_OC_TXT_OVRD_IND"
  FROM /*+ driving_site(ci)*/ charge_info@fokus ci
 WHERE ci.feature_code = 'REACT'
)
;

SELECT * FROM (
SELECT ci.*
  FROM /*+ driving_site(ci)*/ charge_info@fokus ci
 WHERE ci.feature_code = 'REACT'
)
;