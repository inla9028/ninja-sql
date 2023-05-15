select brand, billing_system, count(*) as "COUNT"
  from (
    select unique b.brand, b.billing_system, a.base_code
      from bml_additional_product_mapping a, bml_billing_system b
     where 1 = 1
       and a.billing_system_id = b.id
   )
group by brand, billing_system
order by brand, billing_system
;
