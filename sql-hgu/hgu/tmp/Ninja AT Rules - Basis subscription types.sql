SELECT a.subscription_type_id, a.soc, a.channel_code, a.effective_date,
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a
  WHERE a.soc                  IN ('BASIS')
    AND a.expiration_date         > SYSDATE

--==
SELECT distinct substr(a.subscription_type_id, 0, LENGTH(a.subscription_type_id) - 4) AS priceplan
  FROM sub_typ_soc_channel a
  WHERE a.soc                  IN ('BASIS')
    AND a.expiration_date         > SYSDATE


