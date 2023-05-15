SELECT a.subscription_type_id, s.soc_type, count(*)
  FROM subscription_types_socs a, socs s
  where s.soc=a.soc
  --and a.ninja_default_soc !='Y'
  group by a.subscription_type_id, s.soc_type
  having count(*) = 1
  
