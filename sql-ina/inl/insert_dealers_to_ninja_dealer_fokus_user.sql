
  
  delete ninja_dealer_fokus_user;
  insert into ninja_dealer_fokus_user (select dealer_code, 200900, null, 'A' from ninjarules_pt.dealers);
commit;
