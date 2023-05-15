/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, a.effective_date,
       a.expiration_date, a.comments
  FROM spm_service_mapping a
ORDER BY 1
;

/*
** Insert records based on the available socs for the priceplan PVEE.
** Pro tip: Comment out the "INSERT INTO" row, and modify the query until
** there are no SOC codes displayed as SP_CODE, the uncomment the row and run.
*/
INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              --
              -- Missing according to Ninja Rules...
              --
              , 'SPFAST04',  'NGT_DATA_PACK_1'
              , 'SPFAST05',  'NGT_DATA_PACK_2'
              , 'SPFAST06',  'NGT_DATA_PACK_3'
              , 'SPFAST07',  'NGT_DATA_PACK_4'
              , 'SPFAST08',  'NGT_DATA_PACK_5'
              , 'SPQOS02',   'NGT_SPEED_20MBPS'
              , 'SPQOS03',   'NGT_SPEED_30MBPS'
              , 'SPQOS04',   'NGT_SPEED_40MBPS'
              , 'SPQOS05',   'NGT_SPEED_50MBPS'
              , 'SPQOS06',   'NGT_SPEED_60MBPS'
              , 'SPVOL01ER', 'DATA_NGT_1GB_RLH_EU_ROD'
              , 'SPVOL01EU', 'DATA_NGT_1GB_RLH_EU'
              , 'SPVOL01R',  'DATA_NGT_1GB_ROD'
              , 'SPVOL02',   'DATA_NGT_3GB'
              , 'SPVOL02EU', 'DATA_NGT_3GB_RLH_EU'
              , 'SPVOL02R',  'DATA_NGT_3GB_ROD'
              , 'SPVOL03',   'DATA_NGT_5GB'
              , 'SPVOL03ER', 'DATA_NGT_5GB_RLH_EU_ROD'
              , 'SPVOL03EU', 'DATA_NGT_5GB_RLH_EU'
              , 'SPVOL03R',  'DATA_NGT_5GB_ROD'
              , 'SPVOL04',   'DATA_NGT_10GB'
              , 'SPVOL04ER', 'DATA_NGT_10GB_RLH_EU_ROD'
              , 'SPVOL04EU', 'DATA_NGT_10GB_RLH_EU'
              , 'SPVOL04R',  'DATA_NGT_10GB_ROD'
              , 'SPVOL05',   'DATA_NGT_15GB'
              , 'SPVOL05ER', 'DATA_NGT_15GB_RLH_EU_ROD'
              , 'SPVOL05EU', 'DATA_NGT_15GB_RLH_EU'
              , 'SPVOL05R',  'DATA_NGT_15GB_ROD'
              , 'SPVOL06',   'DATA_NGT_20GB'
              , 'SPVOL06ER', 'DATA_NGT_20GB_RLH_EU_ROD'
              , 'SPVOL06EU', 'DATA_NGT_20GB_RLH_EU'
              , 'SPVOL06R',  'DATA_NGT_20GB_ROD'
              , 'SPVOL07',   'DATA_NGT_25GB'
              , 'SPVOL07ER', 'DATA_NGT_25GB_RLH_EU_ROD'
              , 'SPVOL07EU', 'DATA_NGT_25GB_RLH_EU'
              , 'SPVOL07R',  'DATA_NGT_25GB_ROD'
              , 'SPVOL08',   'DATA_NGT_30GB'
              , 'SPVOL08ER', 'DATA_NGT_30GB_RLH_EU_ROD'
              , 'SPVOL08EU', 'DATA_NGT_30GB_RLH_EU'
              , 'SPVOL08R',  'DATA_NGT_30GB_ROD'
              , 'SPVOL09',   'DATA_NGT_50GB'
              , 'SPVOL09EU', 'DATA_NGT_50GB_RLH_EU'
              , 'SPVOL09R',  'DATA_NGT_50GB_ROD'
              , 'SPVOL10',   'DATA_NGT_100GB'
              , 'SPVOL10EU', 'DATA_NGT_100GB_RLH_EU'
              , 'SPVOL10R',  'DATA_NGT_100GB_ROD'
              , 'TUVS01',    'DATA_SHAPING_1GB_10MBPS'
              , 'TUVS01EU',  'DATA_SHAPING_1GB_10MBPS_RLH_EU'
              , 'TUVS02',    'DATA_SHAPING_1GB_40MBPS'
              , 'TUVS03',    'DATA_SHAPING_2GB_10MBPS'
              , 'TUVS04',    'DATA_SHAPING_2GB_40MBPS'
              , 'TUVS05',    'DATA_SHAPING_3GB_10MBPS'
              , 'TUVS06',    'DATA_SHAPING_3GB_40MBPS'
              , 'TUVS07',    'DATA_SHAPING_5GB_10MBPS'
              , 'TUVS07EU',  'DATA_SHAPING_5GB_10MBPS_RLH_EU'
              , 'TUVS08',    'DATA_SHAPING_5GB_40MBPS'
              , 'TUVS09',    'DATA_SHAPING_8GB_40MBPS'
              , 'TUVS10',    'DATA_SHAPING_15GB_40MBPS'
              --
              -- Ouch...
              --
              , 'VMMINIVS',  'VOICEMAIL_MINI'
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, sts.effective_date, sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  IN ( 'PVEE' || 'REG1' )
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND sts.subscription_type_id != s.soc || 'REG1'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping a
                                     WHERE a.soc_type    = s.soc_type
                                       AND a.soc_group   = s.soc_group
                                       AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND s.soc_type               != 'WAP'
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
 WHERE sts.subscription_type_id  IN ( 'PVEE' || 'REG1' )
   AND sts.subscription_type_id != sts.soc || 'REG1'
   AND SYSDATE             BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND s.soc                     = sd.soc
   AND sd.language_code          = 'NO'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping a
                                     WHERE a.soc_type    = s.soc_type
                                       AND a.soc_group   = s.soc_group
                                       AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
ORDER BY 1,2
;

/*
** Rename the existing MBB_TWIN entry to MBB_SIM_A
*/
/*
UPDATE spm_service_mapping sm
   SET sm.sp_code = 'MBB_SIM_A'
 WHERE sm.sp_code = 'MBB_TWIN'
;
*/

/*
** List the SP-codes and products available for a certain priceplan.
** NB! This does not check towards channel-access!
*/
SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, d.description AS "AKA", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping sp, subscription_types_socs sts, socs s, socs_descriptions d
 WHERE sts.subscription_type_id IN ( 'PVEE' || 'REG1' )
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.add_mode             = 'O'
   AND sts.soc                  = s.soc
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
   AND s.soc                    = d.soc
   AND d.language_code          = 'NO'
ORDER BY 1
;
