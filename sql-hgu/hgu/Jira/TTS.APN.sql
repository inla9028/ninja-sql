/*
** Update the APN soc available to PW20 (TTS)
*/
update subscription_types_socs a
   set a.soc                     = REPLACE(a.soc, 'HPAPN', 'SPAPN')
 where a.soc                  like 'HPAPN%'
   and sysdate             between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
   and a.subscription_type_id    = 'PW20' || 'REG1'
;

update sub_typ_soc_channel a
   set a.soc                     = REPLACE(a.soc, 'HPAPN', 'SPAPN')
 where a.soc                  like 'HPAPN%'
   and sysdate             between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
   and a.subscription_type_id    = 'PW20' || 'REG1'
   and a.channel_code            = 'NewCo'
;

select a.subscription_type_id, a.effective_date, a.expiration_date, a.soc, d.description
  from subscription_types_socs a, socs_descriptions d
 where a.subscription_type_id LIKE 'PW20%'
   and sysdate             between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
   and a.soc                  like '%APN%'
   and a.soc                     = d.soc
   and d.language_code           = 'NO'
order by a.subscription_type_id, a.soc
;

select a.subscription_type_id, a.channel_code, a.effective_date, a.expiration_date, a.soc, d.description
  from sub_typ_soc_channel a, socs_descriptions d
 where a.subscription_type_id LIKE 'PW20%'
   and sysdate             between a.effective_date and NVL(a.expiration_date, SYSDATE + 1)
   and a.soc                  like '%APN%'
   and a.soc                     = d.soc
   and d.language_code           = 'NO'
order by a.subscription_type_id, a.channel_code, a.soc
;
