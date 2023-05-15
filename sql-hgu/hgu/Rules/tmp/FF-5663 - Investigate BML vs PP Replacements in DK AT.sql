select a.*, TRIM(substr(a.bundle || '.*', 0, instr(a.bundle || '.*', '.*') - 1)) as "PP"
  from bml_additional_product_mapping a
  where 1 = 1
--    and a.base_code = 'GPRS4U'
    and length(TRIM(substr(a.bundle || '.*', 0, instr(a.bundle || '.*', '.*') - 1))) > 9
;

select trim(a.base_code) as price_plan, length(trim(a.base_code)) as char_length, lengthb(trim(a.base_code)) as byte_length
     , a.*
  from bml_main_product_mapping a
 where (length(trim(a.base_code))> 9 or lengthb(trim(a.base_code)) > 9)
;

select trim(a.base_code) as price_plan, length(trim(a.base_code)) as char_length, lengthb(trim(a.base_code)) as byte_length
     , a.*
  from bml_main_product_mapping a
 where a.offering_code not like a.base_code || '%'
order by price_plan
;

select a.*
  from bml_main_product_mapping a
;

select a.*
  from bml_additional_product_mapping a
-- where a.base_code like 'GPRSDAWAP'
where a.bundle = 'UNKNOWN'
;

select count(1) from tmp_pp_codes_driver;

select a.*
  from priceplan_replacements_tmp a
order by a.org_priceplan, a.new_priceplan, a.org_soc, a.new_soc
;

/*
create table priceplan_replacements_prev as 
select a.*
  from priceplan_replacements a
order by a.org_priceplan, a.new_priceplan, a.org_soc, a.new_soc
;
*/

select a.*
--  from PRICEPLAN_REPLACEMENTS a
--  from PRICEPLAN_REPLACEMENTS_PREV a
  from PRICEPLAN_REPLACEMENTS_tmp a
 where 1 = 1
--   and a.org_soc = 'GPRSDAWAP'
--   and a.new_soc = 'GPRS4U'
   and a.new_priceplan in (/*'GO4U', 'FLEXPA24',*/ 'SIMALONE')
order by a.org_priceplan, a.new_priceplan, a.org_soc, a.new_soc
;

select count(1)
  from priceplan_replacements a
 where a.new_soc = 'GPRS4U'
;

/******************************************************************************
************************************ FOKUS ************************************
*******************************************************************************/
select a.soc, a.effective_date, a.expiration_date, a.sale_eff_date, a.sale_exp_date, a.soc_status, a.soc_type_ind 
  from soc a
 where RTRIM(a.soc) in (
   'SPMOBFL12', 'SPMOBIZ', 'BASIC2.0', 'CLASSRØDE', 'RINGO_M', 'SPMOBFL24',
   'TALK', 'TALK1', 'XPRESS2.0'
 )
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.soc, a.effective_date, nvl(a.expiration_date, sysdate + 1)
;

select a.*
  from soc a
 where UPPER(a.soc) like 'XPRESS2%'
   and sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by a.soc, a.effective_date, nvl(a.expiration_date, sysdate + 1)
;