/*******************************************************************************
****************************** SCHEMA: CONFIG **********************************
*******************************************************************************/

/*
**
** Create UPDATE-statements based on the content of the existing CAS-Ninja
** table NINJAPRDCONFIG.ninja_user
**
*/
select 'update ninja_dealer_fokus_user set fokus_user_id = ''' || a.fokus_logon || ''', ninja_comment = ''Fokus_User_Id copied from NINJAPRDCONFIG.ninja_user at '' || to_char(sysdate, ''YYYY-MM-DD HH24:MI'') where dealer_code =  ''' || a.username || ''' and fokus_user_id != ''' || a.fokus_logon || ''';' as "SQL"
  from ninja_user a
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
