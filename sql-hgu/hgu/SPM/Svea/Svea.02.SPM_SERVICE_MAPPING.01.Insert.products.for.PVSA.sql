/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, a.effective_date,
       a.expiration_date, a.comments
  FROM spm_service_mapping a
ORDER BY 1
;

/*
** Insert records based on the available socs for the priceplan PVSA.
** Pro tip: Comment out the "INSERT INTO" row, and modify the query until
** there are no SOC codes displayed as SP_CODE, the uncomment the row and run.
*/
--INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              --
              -- Barring (aka ODB%) 
              --
              --
              -- Regular socs...
              --             
              --
              -- Data shaping
              --
              --
              -- Data packages...
              --
              , 'SPVOSH01',  'DATA_SVEA_2GB'
              , 'SPVOSH02',  'DATA_SVEA_10GB'
              , 'SPVOSH03',  'DATA_SVEA_20GB'
              , 'SPVOSH04',  'DATA_SVEA_30GB'
              , 'SPVOSH05',  'DATA_SVEA_40GB'
              , 'SPVOSH06',  'DATA_SVEA_50GB'
              , 'SPVOSH07',  'DATA_SVEA_60GB'
              , 'SPVOSH08',  'DATA_SVEA_70GB'
              , 'SPVOSH09',  'DATA_SVEA_80GB'
              , 'SPVOSH10',  'DATA_SVEA_90GB'
              , 'SPVOSH11',  'DATA_SVEA_100GB'

              , 'SPVOSH12',  'DATA_SVEA_HUDYA_0MB'
              , 'SPVOSH13',  'DATA_SVEA_HUDYA_300MB'
              , 'SPVOSH14',  'DATA_SVEA_HUDYA_500MB'
              , 'SPVOSH15',  'DATA_SVEA_HUDYA_1GB'
              , 'SPVOSH16',  'DATA_SVEA_HUDYA_2GB'
              , 'SPVOSH17',  'DATA_SVEA_HUDYA_3GB'
              , 'SPVOSH18',  'DATA_SVEA_HUDYA_6GB'
              , 'SPVOSH19',  'DATA_SVEA_HUDYA_12GB'
              , 'SPVOSH20',  'DATA_SVEA_HUDYA_30GB'

              , 'SPVOSV01',  'DATA_SVEA_2GB_WITH_ROD_RLH_TOPUP'
              , 'SPVOSV02',  'DATA_SVEA_4GB_WITH_ROD_RLH_TOPUP'
              , 'SPVOSV03',  'DATA_SVEA_8GB_WITH_ROD_RLH_TOPUP'
              , 'SPVOSV04',  'DATA_SVEA_15GB_WITH_ROD_RLH_TOPUP'
              , 'SPVOSV05',  'DATA_SVEA_32GB_WITH_ROD_RLH_TOPUP'
              --
              -- Roaming Data control
              --
              , 'TSIMAVS',   'TRILLING_SIM_A'
              , 'TSIMBVS',   'TRILLING_SIM_B'
              --
              -- Missing according to Ninja Rules...
              --
              , 'VO2MMS',    'VOICEMAIL_TO_MMS'
              , 'IMSVS',     'VOLTE' 
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, TRUNC(SYSDATE) AS "EFFECTIVE_DATE", sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  = 'PVSA' || 'REG1'
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND sts.subscription_type_id != s.soc || 'REG1'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping ssm
                                     WHERE ssm.soc_type  = s.soc_type
                                       AND ssm.soc_group = s.soc_group)
   AND s.soc_type                != 'WAP'
ORDER BY 1,2,3
)
--WHERE sp_code NOT IN (SELECT b.sp_code
--                        FROM spm_service_mapping b
--                       WHERE SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1))
;

/*
** List socs we were unable to add above...
*/
SELECT REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN"
     , s.soc, s.soc_type, s.soc_group, sd.description
  FROM subscription_types_socs sts, socs s, socs_descriptions sd
 WHERE sts.subscription_type_id  = 'PVSA' || 'REG1'
   AND sts.subscription_type_id != sts.soc || 'REG1'
   AND SYSDATE             BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND s.soc                     = sd.soc
   AND sd.language_code          = 'NO'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping a
                                     WHERE a.soc_type  = s.soc_type
                                       AND a.soc_group = s.soc_group)
ORDER BY 1,2
;

/*
** List the SP-codes and products available for a certain priceplan.
** NB! This does not check towards channel-access!
*/
SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, d.description AS "AKA", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping sp, subscription_types_socs sts, socs s, socs_descriptions d
 WHERE sts.subscription_type_id = 'PVSA' || 'REG1'
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc       = s.soc
   AND s.soc_type    = sp.soc_type
   AND s.soc_group   = sp.soc_group
   AND s.soc           = d.soc
   AND d.language_code = 'NO'
ORDER BY 1
;
