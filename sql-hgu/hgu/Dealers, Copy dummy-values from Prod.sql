/*******************************************************************************
****************************** SCHEMA: CONFIG **********************************
*******************************************************************************/
/*
** Copy the ninja fokus dealers from production not yet in the current
** environment, but use a dummy-Fokus User Id...
*/
insert into ninja_dealer_fokus_user 
  select a.dealer_code, 200900 as "FOKUS_USER", a.ninja_comment, a.default_sales_agent_code
    from ninja_dealer_fokus_user@ninjacstaging a
   where not exists (
     select ' '
       from ninja_dealer_fokus_user b
      where b.dealer_code = a.dealer_code
   )
;

/*******************************************************************************
****************************** SCHEMA: RULES ***********************************
*******************************************************************************/
/*
** Copy the dealer groups from production not yet in the current environment.
*/
insert into dealer_groups
  select a.dealer_group, a.description
    from ninjarules.dealer_groups@ninjamain a
   where not exists (
     select ' '
       from dealer_groups b
      where b.dealer_group = a.dealer_group
   )
;

/*
** Copy the dealers from production not yet in the current environment.
*/
insert into dealers
  select a.dealer_code, a.dealer_group
    from ninjarules.dealers@ninjamain a
   where not exists (
     select ' '
       from dealers b
      where b.dealer_code = a.dealer_code
   )
;
