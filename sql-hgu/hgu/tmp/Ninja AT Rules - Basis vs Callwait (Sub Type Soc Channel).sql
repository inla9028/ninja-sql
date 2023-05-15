SELECT a.subscription_type_id, a.soc, a.channel_code, a.effective_date,
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
  WHERE /*a.subscription_type_id IN ('PSFBREG1', 'PSGBREG1')
    AND a.channel_code            = 'NINJAMASTER'
    AND */a.soc                  IN ('CALLWAIT', 'BASIS')
    AND a.expiration_date         > SYSDATE

--== Change...
UPDATE sub_typ_soc_channel a
--  SET a.channel_mode_for_addition = 'A' -- 'A'utomatic by Ninja
  SET a.channel_mode_for_addition = 'O' -- May be added by end-user
  WHERE a.subscription_type_id IN ('PSFBREG1', 'PSGBREG1')
    AND a.channel_code            = 'NINJAMASTER'
    AND a.soc                  IN ('CALLWAIT', 'BASIS')
    AND a.expiration_date         > SYSDATE
