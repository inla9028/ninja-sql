select /*+ driving_site(a)*/ a.soc, a.soc_description, a.effective_date
  from soc@fokus a
 where RTRIM(a.soc) like 'SPVOC%'
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by 1;

select a.*
  from socs a
 where a.soc like 'SPVOC%'
   and sysdate < nvl(a.allow_manual_expiration_date, sysdate + 1)
order by 1;

/*
** List a set of socs, in Fokus, Ninja and SPM.
*/
select rtrim(f.soc) AS "SOC", f.soc_description, f.effective_date
     , decode(s.soc, NULL, 'Not in Ninja', 'Configured in Ninja') AS "NINJA_STATUS"
     , m.sp_code
  from soc@fokus f, socs s, spm_service_mapping m
 where RTRIM(f.soc) like 'SPVOC%'
   and sysdate   between f.effective_date and nvl(f.expiration_date, sysdate + 1)
   and RTRIM(f.soc)    = s.soc(+)
   and s.soc_type      = m.soc_type(+)
   and s.soc_group     = m.soc_group(+)
order by 1;


select a.*
  from spm_service_mapping a
 where a.sp_code = 'DATA_CHILI_1000GB_EU'
;
