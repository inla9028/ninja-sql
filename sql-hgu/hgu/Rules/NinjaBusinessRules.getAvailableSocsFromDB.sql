SELECT sts.subscription_type_id
     , sts.soc
     , sts.add_mode
     , sts.modify_mode
     , sts.delete_mode
     , sts.displayable
     , sts.ninja_mode_activate
     , sts.ninja_mode_change
     , sts.ninja_mode_delete
     , sts.ninja_replacement_soc
     , sts.overidden_by_soc
     , sts.additionally_adds_soc
     , sts.ninja_default_soc
     , stsc.channel_mode_at_activation
     , stsc.channel_mode_for_addition
     , stsc.channel_mode_for_modification
     , stsc.channel_mode_for_deletion
     , stsc.channel_mode_display_mode
     , s.soc_type
     , s.soc_group
     , s.allow_manual_expiration_date
     , sd.language_code
     , sd.description
  FROM subscription_types_socs sts
     , socs                    s
     , socs_descriptions       sd
     , sub_typ_soc_channel     stsc
 WHERE sts.subscription_type_id IN ( 'PPFD'||'REG1' )
   AND s.soc                    = sts.soc
   AND sts.subscription_type_id = stsc.subscription_type_id
   AND sts.soc                  = stsc.soc
   AND sts.add_mode            IN ('A','O','R')
   AND stsc.channel_code        = 'NINJAMASTER' -- See table CHANNELS
   AND SYSDATE BETWEEN stsc.effective_date AND stsc.expiration_date
   AND SYSDATE BETWEEN sts.effective_date  AND sts.expiration_date
   AND sd.soc                   = s.soc
   AND sd.language_code         = 'NO'
   --
   -- Add any filtering for investigations etc.
   --
   AND s.soc                    IN ( 'BASIS', 'CALLWAIT' )
ORDER BY 1,2
;

select a.*
  from channels a
order by 1
;