--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the price plan for the soc(s).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   c.soc AS "PRICE_PLAN", c.description AS "PP_DESC", a.soc, b.soc_type, b.soc_group,
         a.effective_date, a.expiration_date, a.displayable, a.add_mode,
         a.modify_mode, a.delete_mode, a.ninja_mode_activate,
         a.ninja_mode_change, a.ninja_mode_delete, a.ninja_replacement_soc,
         a.overidden_by_soc, a.additionally_adds_soc, a.ninja_default_soc
    FROM subscription_types_socs a, socs b, socs_descriptions c
   WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.soc = b.soc
     AND a.soc IN ('NSHPPUR')
--     AND b.soc_type IN ('GPRS', 'MMS', 'VOICEMAIL', 'WAP')
     AND SUBSTR (a.subscription_type_id, 1, LENGTH (a.subscription_type_id) - 4) = c.soc
     AND c.language_code = 'NO' 
--     and c.soc in ('PPUR', 'PPUV')
ORDER BY a.subscription_type_id, a.soc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the price plan for the soc(s) via a channel.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscription_type_id, a.soc, a.channel_code, a.effective_date,
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a, socs b
   WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.channel_code         = 'NINJAMASTER'
     AND a.soc = b.soc
     AND a.soc IN ('M2MVPN')
--     AND b.soc_type IN ('GPRS', 'HOMERUN')
ORDER BY a.channel_code, a.subscription_type_id, a.soc;
