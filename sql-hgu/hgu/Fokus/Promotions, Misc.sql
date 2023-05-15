 
select rtrim(sr.soc_dest) as soc_base, sr.relation_type,
       sr.src_effective_date, sr.dest_effective_date, sr.expiration_date,
       rtrim(s.soc) as soc_promo, s.soc_status, s.for_sale_ind,
       s.service_type,
       decode(service_type, 'S', 'Reduced SOC',
                            'M', 'Reduced Price Plan',
                            'Q', 'Special Promotion SOC (SOC Stunt)',
                            'N', 'Special Promotion Price Plan (PP Stunt)', '') as service_type_desc,
       s.effective_date, s.sale_eff_date, s.sale_exp_date, rtrim(s.soc_description) as soc_description, s.soc_level_code, s.customer_type, s.minimum_no_months,
       pt.duration, pt.duration_ind, pt.pp_ind, pt.auto_renewal_ind, pt.cut_date
from soc@fokus s, soc_relation@fokus sr, promotion_terms@fokus pt, soc_credit_class@fokus scc
where pt.soc = s.soc
  and sr.soc_src = s.soc
  and sr.relation_type = 'F'
  and sr.src_effective_date <= sysdate
  and scc.soc = s.soc
  and scc.credit_class >= 'X'
  and scc.effective_date = s.effective_date
  and sysdate between sr.dest_effective_date and nvl(sr.expiration_date, sysdate + 1)
  and sysdate between pt.effective_date      and nvl(pt.expiration_date, sysdate + 1)
  and sysdate between s.effective_date       and nvl(s.expiration_date,  sysdate + 1)
  -- and s.service_type in ('S', 'M', 'Q', 'N') -- doesn't include BOGOF
order by S.SOC_LEVEL_CODE asc, S.SOC asc

/*
This is a good start, although it probably needs some adjusting for what you want.
 
Some things to consider (not necessarily exhaustive):
- BOGOF is not included: we don't use it. I assume TeliaDK don't either...
- I'm not sure why we're linking to soc_credit_class, and why we're restricting it to 'X'
- you're probably going to want to play around with effective/expiry/sales effective/sales expiry dates. This in particular is a good reason to want to read the data from Fokus and not duplicate it elsewhere.
 
 
cheers
 
G
*/
