select count(1) as "COUNT" from priceplan_replacements;
select count(1) as "COUNT_TMP" from priceplan_replacements_tmp;

select a.*
  from tmp_pp_replace_driver a
 where a.billing_code = 'GPRSDAWAP'
order by a.price_plan, a.sid_code, a.billing_code
;

select a.*
  from priceplan_replacements_tmp a
 where 1 = 1
--   and a.new_soc = 'GPRSDAWAP'
   and a.org_priceplan = '*'
   and a.new_priceplan = 'GO4U'
   and a.org_soc       = 'GPRSMEDAR'
order by a.org_priceplan, a.new_priceplan, a.new_soc, a.org_soc
;

select "ORG_PRICEPLAN", "NEW_PRICEPLAN", "ORG_SOC", "NEW_SOC", "REPLACEMENT_MODE"
from (
select '*'            as "ORG_PRICEPLAN", 
       a.price_plan   as "NEW_PRICEPLAN",
       b.billing_code as "ORG_SOC", 
       a.billing_code as "NEW_SOC",
      'R'             as "REPLACEMENT_MODE"
  from tmp_pp_replace_driver a, tmp_pp_replace_driver b
 where a.sid_code      = b.sid_code
   and a.price_plan   != b.price_plan -- We should not need to double-check...?
   and a.billing_code != b.billing_code
   -- TEMP
   and a.price_plan    = 'GO4U'
   --and a.billing_code = 'GPRS4U'
)
group by "ORG_PRICEPLAN", "NEW_PRICEPLAN", "ORG_SOC", "NEW_SOC", "REPLACEMENT_MODE"
order by "ORG_PRICEPLAN", "NEW_PRICEPLAN", "ORG_SOC", "NEW_SOC", "REPLACEMENT_MODE"
;






select "ORG_PRICEPLAN", "NEW_PRICEPLAN", "ORG_SOC", "NEW_SOC", "REPLACEMENT_MODE"
from (
select b.price_plan   as "ORG_PRICEPLAN", --'*'            as "ORG_PRICEPLAN",-- b.price_plan   as "ORG_PRICEPLAN", -- This works but causes loads of extra lines
       a.price_plan   as "NEW_PRICEPLAN",
       b.billing_code as "ORG_SOC", 
       a.billing_code as "NEW_SOC",
      'R'             as "REPLACEMENT_MODE"
  from tmp_pp_replace_driver a, feature_parameters f1, feature_parameters f2, tmp_pp_replace_driver b
 where 1 = 1
   and a.billing_code     = f1.soc
   and f1.feature_code    = f2.feature_code
   and f1.parameter_code  = f2.parameter_code
   and f1.parameter_type  = f2.parameter_type
   and f1.soc            != f2.soc
   and f2.soc             = b.billing_code
   and a.price_plan      != b.price_plan
/*   and 0 = (
       select count(1)
         from tmp_pp_replace_driver c
        where c.price_plan   = a.price_plan 
          and c.billing_code = b.billing_code
   )*/
   -- <TEMP>
   and a.price_plan       = 'GO4U'  -- New PP
   and b.price_plan       = '4YOU1' -- Old PP
   and a.billing_code like 'GPR%'
   -- </TEMP>
)
group by "ORG_PRICEPLAN", "NEW_PRICEPLAN", "ORG_SOC", "NEW_SOC", "REPLACEMENT_MODE"
order by "ORG_PRICEPLAN", "NEW_PRICEPLAN", "NEW_SOC", "ORG_SOC", "REPLACEMENT_MODE"
;


select a.*, f.feature_code, f.parameter_code, f.parameter_type
  from tmp_pp_replace_driver a, feature_parameters f
 where 1 = 1
--   and a.price_plan IN ( 'GO4U', '4YOU1', 'SIMALONE' )
   and a.billing_code = 'GPRSORWAP' -- like 'GPR%'
   and a.billing_code = f.soc
order by a.price_plan, a.sid_code, a.billing_code
;

select a.*
  from priceplan_replacements a
 where  1 = 1
   and a.new_priceplan IN ( 'GO4U', '4YOU1', 'SIMALONE' )
   and a.new_soc like 'GPRS%'
;

select s.*
  from socs s
 where s.soc in ('GPRS4U', 'GPRSDAWAP', 'P_GP300S', 'GPRSMEDAR')
order by s.soc
;

select s.*
  from soc@fokus s
 where rtrim(s.soc) in ('GPRS4U', 'GPRSDAWAP', 'P_GP300S', 'GPRSMEDAR')
   and sysdate between s.effective_date and nvl(s.expiration_date, sysdate + 1)
order by s.soc
;



select a.*, s.soc_type, s.soc_group, s.soc_type_old, s.soc_group_old
  from tmp_pp_replace_driver a, socs s
 where 1 = 1
   and a.price_plan   = '4YOU1'
--   and a.sid_code     = 'GPRS'
   and a.billing_code = s.soc
   and a.billing_code like 'GPR%'
order by a.price_plan, a.sid_code, a.billing_code
;


select f.*
  from feature_parameters f
 where f.soc = 'UNLTDGPR'
;

select f1.soc as "SOC_ORIG", f2.soc as "SOC_COPY", count(1) as "COUNT"
  from feature_parameters f1, feature_parameters f2
 where 1 = 1
   and 'GPRS4U'           = f1.soc
   and f1.feature_code    = f2.feature_code
   and f1.parameter_code  = f2.parameter_code
   and f1.parameter_type  = f2.parameter_type
   and f1.soc            != f2.soc
group by f1.soc, f2.soc
order by f1.soc, f1.soc
;

select TRIM(substr(a.bundle || '.*', 0, instr(a.bundle || '.*', '.*') - 1))  as "PRICE_PLAN"
     , a.offering_code as "SID_CODE", a.base_code as "BILLING_CODE"
  from bml_additional_product_mapping a
 where 1 = 1
--   and a.offering_code        = 'GPRS' -- To be removed once finished debugging...
   and a.offering_code     like '%+%' -- To be removed once finished debugging...
   and a.bundle              != '*'
--   and a.billing_system_id    = 3 -- Fokus
   -- Filter:Begin
   and (
       a.bundle not like 'CLASSR_DE'
   )
;

select a.*
  from bml_main_product_mapping a
 where a.billing_system_id    = 3
   and a.offering_code     like '%+%' -- To be removed once finished debugging...
   -- Filter:Begin
   and (
       a.base_code not like 'CLASSR_DE'
   )
   -- Filter:End
order by a.base_code
;


select a.*
  from tmp_pp_codes_driver a
 where a.price_plan like '%+%'
;

select a.*
  from priceplan_replacements a
  -- from priceplan_replacements_tmp a
 where 1 = 1
   and a.new_priceplan = 'UNKNOWN'
order by a.org_priceplan, a.new_priceplan, a.new_soc, a.org_soc
;