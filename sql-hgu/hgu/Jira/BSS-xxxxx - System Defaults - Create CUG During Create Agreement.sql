select a.*
  from system_defaults a
 where a.key = 'CREATE_NEW_PNI_FOR_AGREEMENT'
;

update system_defaults a
   set a.value = 'Y'
 where a.key   = 'CREATE_NEW_PNI_FOR_AGREEMENT'
   and a.value = 'N'
;