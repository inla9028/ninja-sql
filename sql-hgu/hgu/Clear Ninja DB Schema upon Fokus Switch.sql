/*
           ##    #    #   #####   ####   #    #    ##     #####     #     ####
          #  #   #    #     #    #    #  ##  ##   #  #      #       #    #    #
         #    #  #    #     #    #    #  # ## #  #    #     #       #    #
         ######  #    #     #    #    #  #    #  ######     #       #    #
         #    #  #    #     #    #    #  #    #  #    #     #       #    #    #
         #    #   ####      #     ####   #    #  #    #     #       #     ####
*/

/*
** Reserved numbers...
*/
DELETE
FROM
  reserved_numbers rno
WHERE
  ctn IN
  (
    SELECT
      rn.ctn
    FROM
      reserved_numbers rn,
      tn_inv@fokus tn
    WHERE
      tn.ctn        = rn.ctn
    AND ctn_status != 'AR'
  )
OR NOT EXISTS
  (
    SELECT
      ''
    FROM
      tn_inv@fokus tn
    WHERE
      tn.ctn = rno.ctn
  );

/*
** XLDB...
*/
delete from xldb_additional_info_details;
delete from xldb_address_name_details;
delete from xldb_ban_details;
delete from xldb_credit_check_details;
delete from xldb_equipment_details;
delete from xldb_np_details;
delete from xldb_service_params;
delete from xldb_services;
delete from xldb_subscription_details;
delete from xldb_master_transactions;
commit work;

/*
** Porting...
*/
delete from ninja_time_port_adt_info;
delete from ninja_time_port_adt_nos;
delete from ninja_time_port_equipment;
delete from ninja_time_port_services;
delete from ninja_time_port_srv_ftr_prms;
delete from ninja_time_port_sub_info;
delete from ninja_time_port;
commit work;

/*
** SP (can not be done in it's entirety, since we can't create/copy actual BANs)
*/
delete from sp_activation_bans where service_provider_code in (select service_provider_code from service_providers);
commit work;

/*
                 #    #    ##    #    #  #    #    ##    #
                 ##  ##   #  #   ##   #  #    #   #  #   #
                 # ## #  #    #  # #  #  #    #  #    #  #
                 #    #  ######  #  # #  #    #  ######  #
                 #    #  #    #  #   ##  #    #  #    #  #
                 #    #  #    #  #    #   ####   #    #  ######
*/

/*
** Dealer codes :: 1. Manually run this code to get the current default Fokus User ID (aka Operator ID) 
*/
select fokus_user_id from (
  select a.fokus_user_id, count(1) as "CNT"
    from ninja_dealer_fokus_user
  a group by a.fokus_user_id
) where cnt > 100;

/*
** Dealer codes :: 2.1. Apply the Fokus User ID from the statement above
**              :: 2.2. Apply the correct environment in the comment.
**              :: 2.3. Apply the correct Sales Agent (No: A, DK: DFLT)
*/   
insert into ninja_dealer_fokus_user 
  select rtrim(a.dealer) as "DEALER_CODE",
         200900 as "FOKUS_USER",
         'Ninja: Copied from Fokus (NO AT) at ' || to_char(sysdate, 'YYYY-MM-DD HH24:MI') as "NINJA_COMMENT", 
         'A' as "DEFAULT_SALES_AGENT_CODE"
    from dealer_profile@fokus a
   where not exists (
     select ' '
       from ninja_dealer_fokus_user b
      where b.dealer_code = rtrim(a.dealer)
   )
;

/*
** Dealer codes :: 3. Insert dealers into ninjarules.dealers table that are in the table 
**                    ninjaconfig.ninja_dealer_fokus_user but are not present.
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
** Pat yourself on your back, you're done.
*/
commit work;

/*
      #     #    #    #     # #     #    #    #                        #####
      ##   ##   # #   ##    # #     #   # #   #                #    # #     #
      # # # #  #   #  # #   # #     #  #   #  #                #    #       #
      #  #  # #     # #  #  # #     # #     # #                #    #  #####
      #     # ####### #   # # #     # ####### #                #    # #
      #     # #     # #    ## #     # #     # #                 #  #  #
      #     # #     # #     #  #####  #     # #######            ##   #######
*/

/*
** Run these in the environment we're pointing towards, and run the
** generated statements in the existing.
*/

select   'update service_providers set root_ban = ' || a.root_ban || ', current_active_ban = ' || a.current_active_ban || ' where service_provider_code = ''' || a.service_provider_code || ''';' AS "SQL"
    from service_providers a
order by a.service_provider_code
;

select   'insert into sp_activation_bans (service_provider_code, ban, in_use_id) values (''' || a.service_provider_code || ''', ' || a.ban || ', NULL);'  as "SQL" 
    from sp_activation_bans a
order by a.service_provider_code
;