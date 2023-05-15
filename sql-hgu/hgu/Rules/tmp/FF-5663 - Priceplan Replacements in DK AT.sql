select a.*
  from priceplan_replacements a
 where 1 = 1
--   and 'GPBASSURF' in (a.org_soc, a.new_soc)
   and 'GPRS4U' in (a.new_soc)
   and 'GPRSPUALL' in (a.org_soc)
;

select b.*
  from priceplan_replacements_tmp b
 where 1 = 1
--   and 'GPBASSURF' in (b.org_soc, b.new_soc)
   and 'GPRS4U' in (b.new_soc)
   and 'GPRSPUALL' in (b.org_soc)
;

select i.*
  from icim_product i
 where i.
;

select s.soc, s.soc_type, s.soc_group, s.product_type, i.icim_product_code, i.comments
  from socs s, icim_product i
 where 1 = 1
   and s.soc               IN ( 'GPBASSURF', 'GPRSDAWAP', 'GPRS4U' )
   and s.soc_type          = i.soc_type
   and s.soc_group         = i.soc_group
--   and i.icim_product_code IN ( 'GPRS' )
--   and s.soc_type          = 'GPRS'
  order by s.soc, s.soc_type, s.soc_group;

select a.*
  from bml_additional_product_mapping a
  where 1 = 1
    and a.base_code = 'GPRS4U'
;

select a.*
  from subscription_types_socs a
 where a.soc = 'GPRS4U'
   and sysdate between a.effective_date and a.expiration_date
order by a.subscription_type_id
;