select a.subscription_type_id, count(1) as "COUNT"
  from bill_agr_types_sub_types a
 where a.new_priceplan = 'SIMALONE'
   and sysdate between a.effective_date and a.expiration_date
group by a.subscription_type_id
order by a.subscription_type_id
;

select s.*
  from subscription_types_socs s, bill_agr_types_sub_types b
 where b.new_priceplan = 'SIMALONE'
   and sysdate between b.effective_date and b.expiration_date
   and b.subscription_type_id = s.subscription_type_id
   and sysdate between s.effective_date and s.expiration_date
order by s.subscription_type_id, s.soc
;