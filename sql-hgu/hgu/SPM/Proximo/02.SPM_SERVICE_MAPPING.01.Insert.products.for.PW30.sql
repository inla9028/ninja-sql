/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, a.effective_date,
       a.expiration_date, a.comments
  FROM spm_service_mapping a
ORDER BY 1
;

/*
** Insert records based on the available socs for the priceplan PW30.
** Pro tip: Comment out the "INSERT INTO" row, and modify the query until
** there are no SOC codes displayed as SP_CODE, the uncomment the row and run.
*/
INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              --
              -- Missing according to Ninja Rules...
              --
--              , 'SPVOC19',   'DATA_PROXIMO_05MBPS'
--              , 'SPVOC20',   'DATA_PROXIMO_10MBPS'
--              , 'SPVOC21',   'DATA_PROXIMO_20MBPS'
--              , 'SPVOC22',   'DATA_PROXIMO_30MBPS'
--              , 'SPVOC23',   'DATA_PROXIMO_40MBPS'
--              , 'SPVOC24',   'DATA_PROXIMO_50MBPS'
              , 'SPVOC25',   'DATA_BITPRO_05MBPS'
              , 'SPVOC26',   'DATA_BITPRO_10MBPS'
              , 'SPVOC27',   'DATA_BITPRO_20MBPS'
              , 'SPVOC28',   'DATA_BITPRO_30MBPS'
              , 'SPVOC29',   'DATA_BITPRO_40MBPS'
              , 'SPVOC30',   'DATA_BITPRO_50MBPS'
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, sts.effective_date, sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  IN ( 'PW30' || 'REG1' )
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
 WHERE sts.subscription_type_id  IN ( 'PW30' || 'REG1' )
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

update spm_service_mapping a
   set a.sp_code = replace(a.sp_code, 'PROXIMO', 'NGT')
     , a.comments = 'Renamed from ''' || a.sp_code || ''' per request from Tor Olav Mattsson'
 where a.sp_code LIKE 'DATA_PROXIMO%'
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
 WHERE sts.subscription_type_id IN ( 'PW30' || 'REG1' )
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.add_mode             = 'O'
   AND sts.soc                  = s.soc
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
   AND s.soc                    = d.soc
   AND d.language_code          = 'NO'
ORDER BY 1
;
