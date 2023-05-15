select a.*
  from system_defaults a
 where a.key LIKE 'XIL%'
order by 1
;

insert into system_defaults
select a.key || '_NEW'
     , a.value
     , a.value_type
     , a.description
  FROM system_defaults a
 where a.key = 'XIL_URL'
;

update system_defaults a
   set a.value = (select b.value from system_defaults b where b.key = 'XIL_URL_OLD')
 where a.key   = 'XIL_URL'
;