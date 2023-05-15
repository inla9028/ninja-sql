  insert into ninja_dealer_fokus_user (
  select d1.dealer_code, user_id, user_full_name, 'A'
          from ninjarules.dealers d1, users@prod.world u where not exists
(select 1 from ninja_dealer_fokus_user d2
where d2.dealer_code=d1.dealer_code)
and user_short_name like rtrim(d1.dealer_code)||'%')
