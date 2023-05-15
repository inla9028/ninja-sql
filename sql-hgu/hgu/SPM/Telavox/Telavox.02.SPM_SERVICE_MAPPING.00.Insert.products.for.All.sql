/*
** Insert records based on the available socs for the priceplan PVGA.
*/
INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              --
              -- Barring (aka ODB%) 
              --
              , 'ODBP4',     'BAR_5_DIGIT_NUMBERS'
              , 'ODBTOPUP',  'BAR_TOPUP'
              , 'ODBVMS',    'BAR_VOICEMAIL'
              , 'ODBVVM',    'BAR_VISUAL_VOICEMAIL'
              , 'ODBWHO',    'BAR_WHO_CALLED'
              , 'ODBWSMS',   'BAR_WELCOME_SMS'
              --
              -- Regular socs...
              --             
              , 'CLIPREFRI', 'NUMBER_PRESENTATION'
              , 'KONFERVS',  'CONFERENCE'
              , 'DATAVHH',   'GSM_DATA'
              , 'FAXVHH',    'FAX'
              , 'SPSTOPSMS', 'STOP_SMS_QUOTA_NOTIFICATION'
              , 'SPFAST01',  'FIXED_PRICE'
              , 'TWINCONVS', 'MBB_TWIN'
              , 'VMSP01',    'VOICEMAIL'
              , 'WDFVGA',    'DATA_SERVICE'
              --
              -- Data shaping
              --
              , 'TUVS11',    'DATA_SHAPING_10MBPS'
              , 'TUVS12',    'DATA_SHAPING_20MBPS'
              , 'TUVS13',    'DATA_SHAPING_40MBPS'
              --
              -- Data packages...
              --
              , 'CONV52',    'SURF_PACK_SMALL'
              , 'CONV53',    'SURF_PACK_MEDIUM'
              , 'CONV54',    'SURF_PACK_LARGE'
              , 'CONV55',    'SURF_PACK_XL'
              , 'CONV56',    'DATA_SMALL'
              , 'CONV57',    'DATA_MEDIUM'
              , 'CONV58',    'DATA_LARGE'
              , 'CONV59',    'DATA_XL'
              --
              -- Roaming Data control
              --
              , 'MDRCC1',    'ROAMING_DATA_CONTROL_AMOUNT_1000'
              , 'MDRCC2',    'ROAMING_DATA_CONTROL_AMOUNT_3000'
              , 'MDRCC3',    'ROAMING_DATA_CONTROL_AMOUNT_5000'
              , 'MDRCC4',    'ROAMING_DATA_CONTROL_AMOUNT_10000'
              , 'MDRCC5',    'ROAMING_DATA_CONTROL_AMOUNT_50000'
              , 'MDRCCEU',   'ROAMING_DATA_CONTROL_EU_DEFAULT'
              , 'MDRCCNO',   'ROAMING_DATA_CONTROL_AMOUNT_NO_LIMIT'
              --
              -- Missing according to Ninja Rules...
              --
              , 'MMSVGA',    'MMS'
              , 'MPODV15',   'GPRS'
              , 'MVRCVS',    'MOBILE_VOICE_RECORDER'
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, TRUNC(SYSDATE) AS "EFFECTIVE_DATE", sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  = 'PVGA' || 'REG1'
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

INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              --
              -- Barring (aka ODB%) 
              --
              -- N/A
              --
              -- Regular socs...
              -- 
              -- N/A
              --
              -- Data shaping
              --
              -- N/A
              --
              -- Data packages...
              --
              , 'CONV61', 'DATA_5GB'
              , 'CONV62', 'DATA_10GB'
              , 'CONV63', 'DATA_20GB'
              , 'CONV64', 'DATA_100GB'
              --
              -- Roaming Data control
              --
              -- N/A
              --
              -- Missing according to Ninja Rules...
              --
              -- N/A
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, TRUNC(SYSDATE) AS "EFFECTIVE_DATE", sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  = 'PVGC' || 'REG1'
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
