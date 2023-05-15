/*
** Delete all existing SPVOC since they changed the sizes
** and they should be re-entered.
*/
DELETE
  FROM spm_service_mapping a
 WHERE a.soc_type = 'SPVOC'
;

/*
** Insert records based on the available socs for the priceplan PVJB.
*/
-- INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              --
              -- Barring (aka ODB%) 
              --
              --
              -- Regular socs...
              --
              , 'NETPRIOVS', 'PRIORITY_VOICE_SIM'
              --
              -- Data shaping
              --
              /*
                SPVOC02EU   Datastruping 250MB EU Chili     Datastruping 500MB EU Chili     Different
                SPVOC05EU   Datastruping 10GB EU Chili      Datastruping 12 GB EU Chili     Different
                SPVOC06EU   Datastruping 25GB EU Chili      Datastruping 30GB EU Chili      Different
              */
              , 'SPVOC01EU', 'DATA_CHILI_1GB_EU'
              , 'SPVOC02',   'DATA_CHILI_250MB'  
              , 'SPVOC02EU', 'DATA_CHILI_500MB_EU' -- Fokus: Datastruping 500MB EU Chili
              , 'SPVOC03',   'DATA_CHILI_2GB' 
              , 'SPVOC03EU', 'DATA_CHILI_2GB_EU'
              , 'SPVOC04',   'DATA_CHILI_5GB'
              , 'SPVOC04EU', 'DATA_CHILI_5GB_EU'
              , 'SPVOC05',   'DATA_CHILI_10GB'
              , 'SPVOC05EU', 'DATA_CHILI_12GB_EU'  -- Fokus: Datastruping 12 GB EU Chili
              , 'SPVOC06',   'DATA_CHILI_25GB'
              , 'SPVOC06EU', 'DATA_CHILI_30GB_EU'  -- Fokus: Datastruping 30GB EU Chili
              , 'SPVOC07EU', 'DATA_CHILI_3GB_EU'
              , 'SPVOC08EU', 'DATA_CHILI_6GB_EU'
              , 'SPVOC09EU', 'DATA_CHILI_1000GB_EU'
              , 'SPVOC10EU', 'DATA_CHILI_25GB_EU'  -- Fokus: Datastruping 25GB EU Chili
              --
              , 'SPVOC17EU', 'DATA_CHILI_40GB_EU'
              , 'SPVOC18EU', 'DATA_CHILI_50GB_EU'
              --
              -- APN...
              --
              , 'M2MAPNW',    'M2M_APN_VPN'  -- Fokus: "Default APN for VPN customer"
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, TRUNC(SYSDATE) AS "EFFECTIVE_DATE", sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  = 'PVJB' || 'REG1'
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND sts.subscription_type_id != s.soc || 'REG1'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping a
                                     WHERE a.soc_type  = s.soc_type
                                       AND a.soc_group = s.soc_group
                                       AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
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
 WHERE sts.subscription_type_id  = 'PVJB' || 'REG1'
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
 WHERE sts.subscription_type_id = 'PVJB' || 'REG1'
   AND SYSDATE   BETWEEN sts.effective_date AND sts.expiration_date
   and sts.add_mode    = 'O'
   AND sts.soc         = s.soc
   AND s.soc_type      = sp.soc_type
   AND s.soc_group     = sp.soc_group
   AND SYSDATE   BETWEEN sp.effective_date AND sp.expiration_date
   AND s.soc           = d.soc
   AND d.language_code = 'NO'
ORDER BY 1
;
