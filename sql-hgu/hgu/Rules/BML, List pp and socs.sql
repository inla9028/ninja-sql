/*
** Simple display of BML mappings...
*/
select a.order_type, a.offering_code as "PP_ICIM", a.base_code as "PP_SOC", a.campaign
     , b.offering_code as "PRODUCT_ICIM", b.base_code as "PRODUCT_SOC"
  from bml_main_product_mapping a, bml_additional_product_mapping b
 where 1 = 1
--   and a.base_code = 'SIMALONE'
   and b.bundle  like a.base_code || '.%'
   and b.base_code like 'BASIS%'
;
