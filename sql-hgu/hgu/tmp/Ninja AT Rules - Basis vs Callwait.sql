-- Get available socs. Note: this does not test the service mapping stuff.
SELECT	t6.channel_code, -- not in original query but let's us see where soc is available
        t1.subscription_type_id,
        t1.soc,
        t1.add_mode,
        t1.modify_mode,
        t1.delete_mode,
        t1.displayable,
        t1.ninja_mode_activate,
        t1.ninja_mode_change,
        t1.ninja_mode_delete,
        t1.ninja_replacement_soc,
        t1.overidden_by_soc,
        t1.additionally_adds_soc,
        t1.ninja_default_soc,
        t6.channel_mode_at_activation,
        t6.channel_mode_for_addition,
        t6.channel_mode_for_modification,
        t6.channel_mode_for_deletion,
        t6.channel_mode_display_mode,
        t2.soc_type,
        t2.soc_group,
        t4.language_code,
        t5.description
FROM subscription_types_socs t1,
     socs t2,
     socs_dealer_groups t3,
     socs_soc_descriptions t4,
     soc_descriptions t5,
     sub_typ_soc_channel t6
WHERE --t1.subscription_type_id = 'PTMCREG1' AND
      t1.subscription_type_id in ('PSFBREG1', 'PTSGBREG1') AND
      t1.soc in ('CALLWAIT', 'BASIS') AND -- not in original query but let's us see where it's available
      t2.soc = t1.soc AND
      t1.subscription_type_id = t6.subscription_type_id AND
      t1.soc = t6.soc AND
      t1.add_mode in ('A', 'O', 'R') AND
      t6.channel_code = 'DOWE' AND
      --t6.channel_code in ('BOL', 'MINBEDRIFT') AND
      sysdate BETWEEN t6.effective_date AND t6.expiration_date AND
      sysdate BETWEEN t1.effective_date AND t1.expiration_date AND
      t3.dealer_group = 'REGULAR' AND
      t3.soc = t2.soc AND
      t4.soc = t2.soc AND
      t4.language_code = 'NO' AND
      t5.soc_name_id = t4.soc_name_id
order by t6.channel_code, t1.subscription_type_id, t1.soc
