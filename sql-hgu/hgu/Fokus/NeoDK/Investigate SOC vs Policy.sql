/*
** List the socs we anticipate issues with.
*/
select rtrim(a.soc) as "SOC", a.soc_description, a.effective_date, /*a.expiration_date,*/
       a.sale_eff_date, a.sale_exp_date, a.soc_group, p.regular_ind, p.optional_ind
  from soc a, soc_group_policy p
 where rtrim(a.soc) in (
     'TEL2TEL', 'FRIFAST', 'SPOTBTC', 'SPOTMIN06', 'SPOTMIN12', 'SPOTORDER',
     'SA10GB', 'SA1GB', 'SA300MB', 'SAMMS100', 'SAMMS50', 'SAMMSFRI',
     'SASMS200', 'SASMS500', 'SASMSFRI', 'SAVOI10', 'SAVOI12', 'SAVOI2',
     'SAVOI20', 'SAVOI5', 'SAVOI50', 'MMS', 'MMSBTB'
   )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   and a.soc_group = p.soc_group
order by a.soc
;


select rtrim(a.soc) as "SOC", a.soc_description, a.effective_date, a.expiration_date,
       a.sale_eff_date, a.sale_exp_date, a.soc_group 
  from soc a
 where sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
   --and a.soc like 'MMS%'
   and lower(a.soc_description) like '%qos%'
order by a.soc
;


/*
** List soc group policy...
*/
select p.*
  from soc_group_policy p
 where p.soc_group in ( 'FRI2FA', 'DUMMY', 'TEL2TE' ) 
;
