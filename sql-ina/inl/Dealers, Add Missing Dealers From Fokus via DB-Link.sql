/*******************************************************************************
****************************** SCHEMA: CONFIG **********************************
*******************************************************************************/

/*
**
** Copy the ninja fokus dealers from Fokus not yet in the current environment,
** but use one dummy-Fokus User Id...
**
*/
insert into ninja_dealer_fokus_user 
  select rtrim(a.dealer) as "DEALER_CODE",
         30000 as "FOKUS_USER",
         'HGU: Copied from Fokus (DK AT) at ' || to_char(sysdate, 'YYYY-MM-DD HH24:MI') as "NINJA_COMMENT", 
         'DFLT' as "DEFAULT_SALES_AGENT_CODE"
    from dealer_profile@fokus a
   where not exists (
     select ' '
       from ninja_dealer_fokus_user b
      where b.dealer_code = rtrim(a.dealer)
   )
;


/*******************************************************************************
****************************** SCHEMA: RULES ***********************************
*******************************************************************************/

/*
**
** Insert dealers into ninjarules.dealers table that are in the table 
** ninjaconfig.ninja_dealer_fokus_user but are not present.
**
*/
insert into dealers
  select a.dealer_code, 'REGULAR' as "DEALER_GROUP"
    from ninja_dealer_fokus_user a
   where not exists (
     select ' '
       from dealers b
      where b.dealer_code = a.dealer_code
   )
;

/*
**
** List dealers in configured Ninja but not in Fokus.
**
*/
select a.dealer_code, a.fokus_user_id, a.default_sales_agent_code, a.ninja_comment
  from ninja_dealer_fokus_user a
 where not exists (
   select ' '
     from dealer_profile@fokus b
      where rtrim(b.dealer) = a.dealer_code 
   )
order by a.dealer_code
;