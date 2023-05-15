--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the socs for a price plan.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.subscription_type_id, a.soc, b.soc_type, b.soc_group,
         a.effective_date, a.expiration_date, a.displayable, a.add_mode,
         a.modify_mode, a.delete_mode, a.ninja_mode_activate,
         a.ninja_mode_change, a.ninja_mode_delete, a.ninja_replacement_soc,
         a.overidden_by_soc, a.additionally_adds_soc, a.ninja_default_soc
    FROM subscription_types_socs a, socs b
   WHERE a.subscription_type_id IN ('PMAV' || 'REG1')
--     AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.soc = b.soc
--     AND a.soc IN ('CON09', 'HOMERUN')
--     AND b.soc_type IN ('GPRS')
--     AND b.soc_group IN ('BASIC_NEW', 'SMALL_PRIV')
     AND a.ninja_default_soc = 'Y'
ORDER BY a.subscription_type_id, a.soc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the socs for a price plan via a channel.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscription_type_id, a.soc, a.channel_code, a.effective_date,
       a.expiration_date, a.channel_mode_at_activation,
       a.channel_mode_for_addition, a.channel_mode_for_modification,
       a.channel_mode_for_deletion, a.channel_mode_display_mode
  FROM sub_typ_soc_channel a, socs b
   WHERE a.subscription_type_id IN ('PVSA' || 'REG1', 'PVSB' || 'REG1')
     AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
     AND a.channel_code         = 'Svea'
     AND a.soc = b.soc
--     AND a.soc IN ('CON09', 'HOMERUN')
--     AND b.soc_type IN ('GPRS', 'HOMERUN')
ORDER BY a.channel_code, a.subscription_type_id, a.soc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the socs for a price plan via a channel, with DESCRIPTION
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.channel_code AS "CHANNEL"
     , REPLACE(a.subscription_type_id, 'REG1', '') AS "PRICEPLAN"
     , a.soc
     , d.description
     , a.effective_date AS "SINCE"
     , a.expiration_date AS "UNTIL"
  FROM sub_typ_soc_channel a, socs b, socs_descriptions d
   WHERE a.subscription_type_id IN ('PVSA' || 'REG1', 'PVSB' || 'REG1')
     AND SYSDATE           BETWEEN a.effective_date AND a.expiration_date
     AND a.channel_code          = 'Svea'
     AND a.subscription_type_id != a.soc || 'REG1'
     AND a.soc                   = b.soc
     AND b.soc                   = d.soc
     AND d.language_code         = 'NO'
--     AND a.soc IN ('CON09', 'HOMERUN')
--     AND b.soc_type IN ('GPRS', 'HOMERUN')
ORDER BY 1,2,3
;
