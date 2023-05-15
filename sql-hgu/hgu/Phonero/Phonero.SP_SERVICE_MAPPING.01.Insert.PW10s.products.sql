/*
** Display the current content...
*/
SELECT a.sp_code, a.soc_type, a.soc_group, a.effective_date,
       a.expiration_date, a.comments
  FROM spm_service_mapping a
ORDER BY 1
;

/*
** Empty the current content...
*/
DELETE FROM spm_service_mapping
;

/*
** Insert records based on the available socs for the priceplan PW10.
*/
INSERT INTO spm_service_mapping
SELECT * FROM (
SELECT DECODE(s.soc
              , 'HPAPN01',   'APN1'
              , 'HPAPN02',   'APN2'
              , 'HPAPN03',   'APN3'
              , 'HPAPN04',   'APN4'
              , 'HPAPN05',   'APN5'
              , 'HPBDA26',   'GSM_DATA_BDA26' --  DONE DONE DONE DONE DONE DONE DONE
              , 'HPCLIP',    'NUMBER_PRESENTATION'
              , 'HPCLIREST', 'HIDDEN_NUMBER'
              , 'HPCONF',    'KONFERANSE'
              , 'HPCTR01',   'CALL_TRANSFER'
              , 'HPCWA',     'CALL_WAIT'
              , 'HPIMS02',   'VOLTE'
              , 'HPISDN',    'GSM_DATA_ISDN' -- DONE DONE DONE DONE DONE DONE DONE
              , 'HPMBN01',   'MBN_USER'
              , 'HPNETPRIO', 'PRIORITY_VOICE_SIM'
              , 'HPSMSP01',  'SMS_COPY'
              , 'HPSMSS01',  'SMS_STORAGE'
              , 'ODB1',      'BAR_CALL_INCOMING'
              , 'ODB2',      'BAR_CALL_ROAMING_INCOMING'
              , 'ODB3',      'BAR_CALL_ROAMING'
              , 'ODB4',      'BAR_ALL_OUTGOING_CALLS'
              , 'ODB4B',     'BAR_ALL_OUTGOING_CALLS_EX_SMS'
              , 'ODB5',      'BAR_ALL_OUTGOING_INTERNATIONAL'
              , 'ODB6',      'BAR_OUTGOING_CALLS_EX_HOME'
              , 'ODB7',      'BAR_TELETORG_ALL'
              , 'ODB7B',     'BAR_TELETORG_820'
              , 'ODB7C',     'BAR_TELETORG_829'
              , 'ODB8',      'BAR_DATA_ALL'
              , 'ODB9',      'BAR_DATA_ROAMING'
              , 'ODBCF',     'BAR_CALL_FORWARDING'
              , 'ODBCPA',    'BAR_CPA_CONTENT'
              , 'ODBCPA1',   'BAR_CPA_AMOUNT_250'
              , 'ODBCPA2',   'BAR_CPA_AMOUNT_500'
              , 'ODBCPA3',   'BAR_CPA_AMOUNT_1000'
              , 'ODBCPA4',   'BAR_CPA_AMOUNT_100'
              , 'ODBCPA5',   'BAR_CPA_AMOUNT_2000'
              , 'ODBCPAG',   'BAR_CPA_GOODS_AND_SERVICES'
              , 'ODBP1',     'BAR_18XX'
              , 'ODBP2',     'BAR_8XX'
              , 'ODBP3',     'BAR_DONATION_NUMBERS'
              , 'ODBVVM',    'BAR_VISUAL_VOICEMAIL'
              , 'ODBWSMS',   'BAR_WELCOME_SMS'
              --
              -- My interpretations....
              --
              , 'HPFWBA01',  'BAR_CALL_FORWARD'
              , 'HPVMS01',   'VOICEMAIL'
--              , 'HPVMS01+',  'VOICEMAIL_PLUS'
              , 'HPVMS02',   'VOICEMAIL_BUSINESS'
              , 'HPVMS03',   'VOICEMAIL_SECURITY'
--              , '', ''
              --
              -- Missing according to Ninja Rules...
              --
              , 'HPFORW01', 'CALL_FORWARD'
              --
              -- Missing according to wiki vs Excel...
              --
--              , '', 'BAR_CPA_AGE'
              --
              -- Done...
              --
              , s.soc) AS "SP_CODE"
     , s.soc_type, s.soc_group, sts.effective_date, sts.expiration_date
     , NULL AS "COMMENT"
  FROM subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id  = 'PW10' || 'REG1'
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc                   = s.soc
   and sts.add_mode              = 'O'
   AND sts.subscription_type_id != s.soc || 'REG1'
ORDER BY 1,2,3
)
;

/*
** List the SP-codes and products available for a certain priceplan.
** NB! This does not check towards channel-access!
*/
SELECT sp.sp_code, 'maps to' AS "MAPS_TO", sp.soc_type, sp.soc_group, 'which points to' AS "POINTS_TO",
       s.soc, 'which is allowed on' AS "ALLOWED_ON", sts.subscription_type_id,
       'since' AS "SINCE", sts.effective_date, 'until' AS "UNTIL", sts.expiration_date
  FROM spm_service_mapping sp, subscription_types_socs sts, socs s
 WHERE sts.subscription_type_id = 'PW10' || 'REG1'
   AND SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.soc       = s.soc
   AND s.soc_type    = sp.soc_type
   AND s.soc_group   = sp.soc_group
ORDER BY 1
;
