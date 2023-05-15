SELECT pm.service_provider_code AS "SERVICE_PROVIDER"
     , pm.sp_priceplan_code AS "SPM_TYPE", pm.soc_code AS "PP_SOC"
     , sp.sp_code AS "SPM_SERVICE", sts.soc, sts.effective_date AS "SOC_EFF_DATE"
     , d.description AS "SOC_DESC"
  FROM spm_priceplan_mapping   pm
     , spm_service_mapping     sp
     , subscription_types_socs sts
     , socs                    s
     , socs_descriptions       d
 WHERE pm.service_provider_code = 'Intility'
   AND SYSDATE            BETWEEN pm.effective_date AND NVL(pm.expiration_date, SYSDATE + 1)
   AND pm.soc_code || 'REG1'    =  sts.subscription_type_id
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.add_mode             = 'O'
   --
--   AND pm.soc_code              = 'PVJA'
   --
   --
--   AND sp.sp_code            LIKE '5G%'
--   AND sp.sp_code            LIKE 'BAR%'
--   AND sp.sp_code            LIKE 'DATA_CHILI_25GB_EU'
--   AND sp.sp_code              IN ( '5G_300_MBPS', '5G_UNLIMITED_SPEED', '5G_ENABLED' )
--   AND sts.soc               LIKE 'SPVOC07%'
   AND SYSDATE            BETWEEN sp.effective_date AND NVL(sp.expiration_date, SYSDATE + 1)
   --
   AND sts.soc                  = s.soc
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
   AND s.soc                    = d.soc
   AND d.language_code          = 'NO'
   --
--   AND sp.sp_code               = '5G'
--   AND sp.sp_code            LIKE 'DATA_CHILI_5GB_EU'
ORDER BY 1,3,2,4
;

-- Same as above, but descriptions fetched from Fokus...
WITH spm_filter AS (
  SELECT pm.service_provider_code AS "SERVICE_PROVIDER"
       , pm.sp_priceplan_code     AS "SPM_TYPE",    pm.soc_code        AS "PP_SOC"
       , sts.soc, sp.sp_code      AS "SPM_SERVICE", sts.effective_date AS "SOC_EFF_DATE"
    FROM spm_priceplan_mapping   pm
       , spm_service_mapping     sp
       , subscription_types_socs sts
       , socs                    s
 WHERE pm.service_provider_code = 'Intility'
   AND SYSDATE            BETWEEN pm.effective_date AND NVL(pm.expiration_date, SYSDATE + 1)
   AND pm.soc_code || 'REG1'    =  sts.subscription_type_id
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.add_mode             = 'O'
   --
--   AND pm.soc_code             IN ( 'PVJA', 'PVJK' )
--   AND pm.soc_code             IN ( 'PVKA' )
   --
   --
   AND sp.sp_code            LIKE '%APN%'
--   AND (sp.sp_code            LIKE '5G%' OR sp.sp_code            LIKE 'APN%' )
--   AND sp.sp_code            LIKE 'VOICEMAIL%'
--   AND sp.sp_code            LIKE 'BAR%'
--   AND sp.sp_code            LIKE 'MMS%'
--   AND sp.sp_code              IN ( 'DATA_CHILI_1000GB_UNLIMITED_SPEED_EU' )
   AND SYSDATE            BETWEEN sp.effective_date AND NVL(sp.expiration_date, SYSDATE + 1)
   --
--   AND sts.soc               LIKE '%VMACC%'
--   AND sts.soc               IN ( 'SPAPN01', 'SPNOLIM' )
   --
   AND sts.soc                  = s.soc
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group)
SELECT /*+ driving_site(s)*/
       spm.service_provider, spm.spm_type, spm.pp_soc, spm.spm_service, spm.soc, spm.soc_eff_date
     , RTRIM(s.soc_description) AS "SOC_DESC"
  FROM spm_filter spm, soc@fokus s
 WHERE spm.soc = rtrim(s.soc)
   AND SYSDATE BETWEEN s.effective_date AND NVL(s.expiration_date, SYSDATE + 1)
ORDER BY 1,3,2,4
;

 -- List _all_ Service Providers, descriptions fetched from Fokus...
WITH sp_filter as (select a.service_provider_code
                     from service_providers a
                    where sysdate < nvl(a.expiration_date, sysdate + 1)
                   order by 1)
, spm_filter AS (
  SELECT pm.service_provider_code AS "SERVICE_PROVIDER"
       , pm.sp_priceplan_code     AS "SPM_TYPE",    pm.soc_code        AS "PP_SOC"
       , sts.soc, sp.sp_code      AS "SPM_SERVICE", sts.effective_date AS "SOC_EFF_DATE"
    FROM spm_priceplan_mapping   pm
       , spm_service_mapping     sp
       , subscription_types_socs sts
       , socs                    s
       , sp_filter               sps
 WHERE pm.service_provider_code = sps.service_provider_code
   AND SYSDATE            BETWEEN pm.effective_date AND NVL(pm.expiration_date, SYSDATE + 1)
   AND pm.soc_code || 'REG1'    =  sts.subscription_type_id
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.add_mode             = 'O'
   --
--   AND pm.soc_code              = 'PVJA'
   --
   --
   AND sp.sp_code            LIKE '%APN%'
--   AND sp.sp_code            LIKE '5G%'
--   AND sp.sp_code            LIKE 'BAR%'
--   AND sp.sp_code            LIKE '%ROAMING%'
--   AND sp.sp_code              IN ( 'DATA_CHILI_10GB', 'DATA_CHILI_12GB_EU', 'DATA_CHILI_20GB_EU_BEDRIFT' )
--   AND sts.soc               LIKE 'HPTSP01%'
   AND SYSDATE            BETWEEN sp.effective_date AND NVL(sp.expiration_date, SYSDATE + 1)
   --
   AND sts.soc                  = s.soc
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group)
SELECT /*+ driving_site(s)*/
       spm.service_provider, spm.spm_type, spm.pp_soc, spm.spm_service, spm.soc, spm.soc_eff_date
     , RTRIM(s.soc_description) AS "SOC_DESC"
  FROM spm_filter spm, soc@fokus s
 WHERE spm.soc = rtrim(s.soc)
   AND SYSDATE BETWEEN s.effective_date AND NVL(s.expiration_date, SYSDATE + 1)
ORDER BY 1,3,2,4
;
