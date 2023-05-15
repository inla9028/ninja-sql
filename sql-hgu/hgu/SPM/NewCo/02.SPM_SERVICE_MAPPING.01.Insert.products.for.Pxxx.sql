/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, a.effective_date,
       a.expiration_date, a.comments
  FROM spm_service_mapping a
ORDER BY 1
;

/*
** Rename the existing MBN_USER entry to MBN_HLR_TRIGGER
*/
--UPDATE spm_service_mapping sm
--   SET sm.sp_code = 'MBN_HLR_TRIGGER'
-- WHERE sm.sp_code = 'MBN_USER'
--;

/*
** Expire the old MBN_USER.
*/
UPDATE spm_service_mapping sm
   SET sm.expiration_date = TRUNC(SYSDATE)
 WHERE sm.sp_code         = 'MBN_USER'
   AND sm.soc_group       = 'MBNU01'
;

/*
** Insert records based on the available socs for the priceplan PW20.
** Pro tip: Comment out the "INSERT INTO" row, and modify the query until
** there are no SOC codes displayed as SP_CODE, the uncomment the row and run.
*/
INSERT INTO spm_service_mapping
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

              --
              -- Roaming Data control
              --
              , 'MDRCC6',    'ROAMING_DATA_CONTROL_AMOUNT_199'
              --
              -- Multi SIM
              --
              , 'MSIMA',     'MULTI_SIM_A'
              , 'MSIMB',     'MULTI_SIM_B'
              --
              -- TwinCon....
              --
              , 'TWINCON02', 'MBB_SIM_B'
              , 'TWINCON03', 'MBB_SIM_C'
              , 'TWINCON04', 'MBB_SIM_D'
              , 'TWINCON05', 'MBB_SIM_E'
              --
              -- Data bucket - new soc with bucket size per feature parameter.
              --
              , 'HPTSP01',   'DATA_BUCKET'
              --
              -- MBN
              --
              --, 'HPMBN02',   'MBN_USER'
              , 'MBNU01',    'MBN_USER'
              , 'HPMBN03',   'MBN_MAIN_NUMBER'
              --
              -- Voicemail...
              --
              , 'VMACC02',   'VOICEMAIL_WITHOUT_CALL_FORWARD'
              --
              -- Missing according to Ninja Rules...
              --
              , 'HPMBN02',    'MBN_USER'
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, sts.effective_date, sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  = 'PW20' || 'REG1'
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
 WHERE sts.subscription_type_id  = 'PW20' || 'REG1'
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
UPDATE spm_service_mapping sm
   SET sm.sp_code = 'MBB_SIM_A'
 WHERE sm.sp_code = 'MBB_TWIN'
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
 WHERE sts.subscription_type_id = 'PW20' || 'REG1'
   AND SYSDATE            BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                  = s.soc
   AND s.soc_type               = sp.soc_type
   AND s.soc_group              = sp.soc_group
   AND s.soc                    = d.soc
   AND d.language_code          = 'NO'
ORDER BY 1
;
