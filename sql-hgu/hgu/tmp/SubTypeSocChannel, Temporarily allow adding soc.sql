SELECT a.subscription_type_id, a.soc, a.channel_code, a.effective_date,
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM ninjarules.sub_typ_soc_channel a
  WHERE a.soc = 'MCTB1'
    AND a.subscription_type_id IN ('PSTBREG1', 'PSTCREG1')
    AND a.channel_code = 'NINJAMASTER'

--== Reset the records that failed..
UPDATE ninjadata.master_transactions a
   SET a.process_status = 'WAITING',
       a.process_time = NULL,
       a.status_desc = NULL
 WHERE a.request_id IN ('LCE 28.09.09')
   AND a.process_status = 'PRSD_ERROR'
   AND a.status_desc LIKE '%is not Allowed to Activate Soc%'


--== Allow adding...
UPDATE ninjarules.sub_typ_soc_channel a
   SET a.channel_mode_for_addition = 'O'
 WHERE a.soc = 'MCTB1'
   AND a.subscription_type_id IN ('PSTBREG1', 'PSTCREG1')
   AND a.channel_code = 'NINJAMASTER'
   AND a.channel_mode_for_addition = 'N'


---== Disallow adding...
UPDATE ninjarules.sub_typ_soc_channel a
   SET a.channel_mode_for_addition = 'N'
 WHERE a.soc = 'MCTB1'
   AND a.subscription_type_id IN ('PSTBREG1', 'PSTCREG1')
   AND a.channel_code = 'NINJAMASTER'
   AND a.channel_mode_for_addition = 'O'


