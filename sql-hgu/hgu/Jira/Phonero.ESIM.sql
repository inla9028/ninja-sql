/*
** Update soc-type & group for Phonero/TTS voicemails...
*/
update socs a
   set a.soc_type  = 'VOICEMAIL2'
     , a.soc_group = 'VMS2'
 where a.soc       = 'HPVMS02'
;

update socs a
   set a.soc_type  = 'VOICEMAIL2'
 where a.soc       = 'HPVMS03'
;

/*
** Remove HPVMS01 as available since it's old.
*/
update subscription_types_socs a
   set a.expiration_date         = TRUNC(SYSDATE)
 where a.soc                     = 'HPVMS01'
   and sysdate             between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
   and a.subscription_type_id LIKE 'PW%'
;

update sub_typ_soc_channel a
   set a.expiration_date         = TRUNC(SYSDATE)
 where a.soc                     = 'HPVMS01'
   and sysdate             between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
   and a.subscription_type_id LIKE 'PW%'
;

/*
** Update the SPM mappings for Phonero and Voicemail.
*/
update spm_service_mapping a
   set a.expiration_date = TRUNC(SYSDATE)
 where a.sp_code         = 'VOICEMAIL_BUSINESS'
   and sysdate     between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
;

update spm_service_mapping a
   set a.soc_type    = 'VOICEMAIL2'
 where a.sp_code     = 'VOICEMAIL_SECURITY'
   and sysdate between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
;

select a.*
  from spm_service_mapping a
 where a.sp_code LIKE 'VOICEMAIL%'
;

select a.subscription_type_id, a.effective_date, a.expiration_date, a.soc, d.description
  from subscription_types_socs a, socs s, socs_descriptions d
 where a.subscription_type_id LIKE 'PW10%'
   and sysdate             between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
   and a.soc                     = s.soc
   and s.soc_type                = 'VOICEMAIL'
   and s.soc_group               = 'VMS'
   and s.soc                     = d.soc
   and d.language_code           = 'NO'
order by 1,2
;

select a.subscription_type_id, a.channel_code, a.effective_date, a.expiration_date, a.soc, d.description
  from sub_typ_soc_channel a, socs s, socs_descriptions d
 where a.subscription_type_id LIKE 'PW10%'
   and sysdate             between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
   and a.soc                     = s.soc
   and s.soc_type                = 'VOICEMAIL'
   and s.soc_group               = 'VMS'
   and s.soc                     = d.soc
   and d.language_code           = 'NO'
order by a.subscription_type_id, a.channel_code, a.soc
;
