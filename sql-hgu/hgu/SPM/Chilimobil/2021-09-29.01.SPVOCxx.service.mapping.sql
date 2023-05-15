/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, a.effective_date,
       a.expiration_date, a.comments
  FROM spm_service_mapping a
ORDER BY 1
;

/*
** Delete an old mapping that was changed in Fokus.
*/
DELETE
  FROM spm_service_mapping ssm
 WHERE ssm.sp_code = 'DATA_CHILI_12GB_EU'
;

/*
** Insert records based on the available socs for the priceplan PVJF.
** Pro tip: Comment out the "INSERT INTO" row, and modify the query until
** there are no SOC codes displayed as SP_CODE, the uncomment the row and run.
*/
INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              --
              -- Regular socs...
              --             
              , 'SPVOC65',    'DATA_CHILI_8GB_EU'  -- Datastruping 8 GB EU Chili
              , 'SPVOC66',    'DATA_CHILI_9GB_EU'  -- Datastruping 9 GB EU Chili
              , 'SPVOC67',    'DATA_CHILI_12GB_EU' -- Datastruping 12 GB EU Chili
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, sts.effective_date, sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  = 'PVJA' || 'REG1'
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND sts.subscription_type_id != s.soc || 'REG1'
   AND 0                         = (SELECT COUNT(1)
                                      FROM spm_service_mapping a
                                     WHERE a.soc_type    = s.soc_type
                                       AND a.soc_group   = s.soc_group
                                       AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1))
   AND s.soc_type           NOT IN ( 'MVRC', 'WAP' )
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
 WHERE sts.subscription_type_id  = 'PVJA' || 'REG1'
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
** List the SP-codes and products available for a certain priceplan.
** NB! This does not check towards channel-access!
*/
SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, d.description AS "AKA", 'which is allowed on' AS "ALLOWED_ON",
       REPLACE(sts.subscription_type_id, 'REG1', '') AS "PRICEPLAN",
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping sp, subscription_types_socs sts, socs s, socs_descriptions d
 WHERE sts.subscription_type_id = 'PVJA' || 'REG1'
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.add_mode             = 'O'
   AND sts.soc                  = s.soc
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
   AND s.soc                    = d.soc
   AND d.language_code          = 'NO'
ORDER BY 1
;
