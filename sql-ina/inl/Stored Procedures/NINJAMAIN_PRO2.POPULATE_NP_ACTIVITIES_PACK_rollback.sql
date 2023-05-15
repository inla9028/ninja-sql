-- Start of DDL Script for Package Body NINJAMAIN_PRO2.POPULATE_NP_ACTIVITIES_PACK
-- Generated 31-mai-2010 13:10:56 from NINJAMAIN_PRO2@NINJAT
CREATE OR REPLACE 
PACKAGE populate_np_activities_pack AS
    PROCEDURE POPULATE_NP_BEST_RESEND;
    PROCEDURE POPULATE_PORTING_REMINDER;
    PROCEDURE POPULATE_PORT_IN_ABORT;
    PROCEDURE POPULATE_PORT_OUT_PENALTY;
    PROCEDURE POPULATE_PORT_OUT_CLOSE_CASE;
    PROCEDURE POPULATE_WELCOME_SMS;
END populate_np_activities_pack ;
/

CREATE OR REPLACE 
PACKAGE body populate_np_activities_pack AS

-- Populate table for resending NP_BEST transactions
 PROCEDURE POPULATE_NP_BEST_RESEND IS

   act_seq number(2);
   trx_no number(9);
   ninja_user number(9);
   
   cursor c1 is

   select port_number, np.operator_id, np.int_order_id,ext_order_id, trx_code
   from np_trx_detail@FOKUS nt,
        np_number_info@FOKUS np,
        np_order_data@FOKUS nd
   where port_ind in ('Y','B','P','I')
     --and port_request_date > sysdate -30
     --and nvl(expiration_date,TO_DATE('47001231000000','YYYYMMDDHH24MISS')) > sysdate
     and (expiration_date is null or expiration_date = TO_DATE('47001231000000','YYYYMMDDHH24MISS'))
     and nd.int_order_id=np.int_order_id
     and order_status in ('O','J')
     and nt.int_order_id=np.int_order_id
     and main_number = port_number
     and trx_status in ('S')
     and ext_order_id > 0
     and trx_code in (105,108 )
     and trx_source='INT'
     and request_exec_date between (sysdate-5) and sysdate
     and nt.int_trx_seq = (select max(int_trx_seq )
			   from np_trx_detail@FOKUS nt2
			   where nt2.trx_code in (105,108 ) 
			     and nt2.int_order_id=np.int_order_id)
     and not exists (select 1
                       from batch_np_activities bnp
                      where bnp.port_number = '047'||np.port_number
                        and bnp.int_order_id=np.int_order_id
                        and process_status='WAITING');
			     
   update_row1 c1%ROWTYPE;

   BEGIN

   select fokus_user_id into ninja_user
   from ninja_dealer_fokus_user
   where dealer_code = 'NENI';

   FOR update_row1 in c1 LOOP

     act_seq:=0;

     -- Check if there is an open case for resending BEST for this number
     BEGIN
        select TRANSACTION_NUMBER, ACTION_SEQ into trx_no,act_seq
        from   batch_np_activities
        where  port_number = '047'||update_row1.port_number
         and  expiration_date is null
         and action='B';
       
        EXCEPTION
         WHEN no_data_found THEN
            act_seq:=0;
     END;
     
     IF (act_seq = 0) THEN -- no open case exists

        insert into batch_np_activities values (
        null,
        '047'||update_row1.port_number,
        null,
        'REORD1',
        'B',
        null,
        null,
        null,
        null,
        1,
        update_row1.int_order_id,
        null);

      ELSIF ((act_seq = 1) AND (update_row1.operator_id) = ninja_user) THEN --there is an open case and BEST has been resent once

          update batch_np_activities
             set expiration_date = sysdate
           where TRANSACTION_NUMBER = trx_no;

           insert into batch_np_activities values (
                  null,
                  '047'||update_row1.port_number,
                  null,
                  'REORD2',
                  'B',
                  null,
                  null,
                  null,
                  null,
                  2,
                  update_row1.int_order_id,
                  null);

	ELSIF ((act_seq = 2) AND (update_row1.operator_id) = ninja_user) THEN --there is an open case and BEST has been resent twice, create a FU

          update batch_np_activities
             set expiration_date = sysdate
           where TRANSACTION_NUMBER = trx_no;

           insert into batch_np_activities values (
                  null,
                  '047'||update_row1.port_number,
                  null,
                  'EMAIL',
                  'B',
                  null,
                  null,
                  null,
                  null,
                  3,
                  update_row1.int_order_id,
                  null);

        ELSIF ((act_seq != 0) AND (update_row1.operator_id) != ninja_user) THEN --there is an open case for the number, but this is an other sequence of BEST resend. Start sequence from the beginning

          update batch_np_activities
             set expiration_date = sysdate
           where TRANSACTION_NUMBER = trx_no;

           insert into batch_np_activities values (
                  null,
                  '047'||update_row1.port_number,
                  null,
                  'REORD1',
                  'B',
                  null,
                  null,
                  null,
                  null,
                  1,
                  update_row1.int_order_id,
                  null);
     END IF;

   commit;

   end loop;  
 end POPULATE_NP_BEST_RESEND;
 
-- Populate table for sending an SMS to remind the customer about
-- being ported to Netcom
 PROCEDURE POPULATE_PORTING_REMINDER IS
 cursor c1 is
    select  port_number, np.int_order_id,ext_order_id
    from    np_trx_detail@FOKUS nt,
            np_number_info@FOKUS np
    where port_ind in ('Y','B','P','I')
      and np.number_type = 'P' -- Primary number
      and port_request_date >= sysdate
      and request_exec_date >= sysdate
      and nvl(np.expiration_date,TO_DATE('47001231000000','YYYYMMDDHH24MISS')) > sysdate
      and nt.int_order_id=np.int_order_id
      and trx_status='S'
      and trx_code = 112
      and trx_source = 'INT'
      and not exists(select 1
                       from  batch_np_activities ba
                      where  ba.port_number = '047'||np.port_number
                        and  ba.int_order_id=np.int_order_id
                        and activity_code = 'IVERSM')
      -- next lines of the select are temporary for the first days of switching
      -- from the old scripts.
      --AND    NOT EXISTS ( SELECT /*+ HASH_AJ */ SUBSCRIBER_NO
       --                   FROM   SMS_SENT_TO_NP3@prod sm
       --                   WHERE  sm.SUBSCRIBER_NO = 'GSM047'||np.port_number
       --                   AND    sms_send_date >= sysdate-5)
        ;
      
 update_row1 c1%ROWTYPE;

  BEGIN
    FOR update_row1 in c1 LOOP
        insert into batch_np_activities values (
            null,
            '047'||update_row1.port_number,
            null,
            'IVERSM',
            'S',
            null,
            null,
            null,
            null,
            1,
            update_row1.int_order_id,
            null);
    commit;

   END LOOP;
 END POPULATE_PORTING_REMINDER;

-- Populate table for sending an SMS to notify the customer about
-- port in proccess cancellation by Netcom
 PROCEDURE POPULATE_PORT_IN_ABORT IS
 cursor c1 is
    select  port_number, np.int_order_id,ext_order_id
    from    np_trx_detail@FOKUS nt,
            np_number_info@FOKUS np
    where port_ind in ('Y','B','P','I')
      and np.number_type = 'P' -- Primary number
      and request_exec_date > sysdate
      and nt.int_order_id=np.int_order_id
      and trx_status='S'
      and trx_code = 129
      and trx_source='INT'
      and not exists(select 1
                       from batch_np_activities ba
                      where ba.port_number = '047'||np.port_number
                        and ba.int_order_id=np.int_order_id );

 update_row1 c1%ROWTYPE;

  BEGIN
    FOR update_row1 in c1 LOOP
        insert into batch_np_activities values (
            null,
            '047'||update_row1.port_number,
            null,
            'FIVESM',
            'S',
            null,
            null,
            null,
            null,
            1,
            update_row1.int_order_id,
            null);
    commit;

   END LOOP;
 END POPULATE_PORT_IN_ABORT;
 
-- Populate table for sending Penalty SMS to customers that want
-- to be ported out, but still have a commitment
 PROCEDURE POPULATE_PORT_OUT_PENALTY IS
 cursor c1 is
    select  port_number, np.int_order_id,ext_order_id
    from    np_trx_detail@FOKUS nt,
            subscriber@FOKUS s,
            np_number_info@FOKUS np
    where port_ind = 'E'
      and np.number_type = 'P' -- Primary number
      and port_request_date > sysdate
      and nt.request_exec_date > sysdate
      and nvl(np.expiration_date,TO_DATE('47001231000000','YYYYMMDDHH24MISS')) > sysdate
      and nt.int_order_id=np.int_order_id
      and trx_status='S'
      and trx_code = 111 -- NP_GODK
      and trx_source='INT'
      and subscriber_no='GSM047'||np.port_number
      and sub_status in ('A','S')
      and s.COMMIT_END_DATE IS NOT NULL
      and trunc(s.COMMIT_END_DATE) > trunc(nt.REQUEST_EXEC_DATE)  -- Not finished commitment
      and not exists(select 1
                       from batch_np_activities bnp
                      where bnp.port_number = '047'||np.port_number
                        and bnp.int_order_id=np.int_order_id )
      -- next lines of the select are temporary for the first days of switching
      -- from the old scripts.
      --AND    NOT EXISTS ( SELECT /*+ HASH_AJ */ SUBSCRIBER_NO
       --                   FROM   SMS_SENT_TO_NP@prod sm
       --                   WHERE  sm.SUBSCRIBER_NO = 'GSM047'||nt.MAIN_NUMBER
       --                   AND    sms_send_date >= sysdate-5)
        ;
                        
 update_row1 c1%ROWTYPE;

  BEGIN
    FOR update_row1 in c1 LOOP
        insert into batch_np_activities values (
            null,
            '047'||update_row1.port_number,
            null,
            'PENSMS',
            'S',
            null,
            null,
            null,
            null,
            1,
            update_row1.int_order_id,
            null);
    commit;

   END LOOP;
 END POPULATE_PORT_OUT_PENALTY;
 
-- Populate table for not finished port out cases with overdue port date
  PROCEDURE POPULATE_PORT_OUT_CLOSE_CASE IS
 cursor c1 is
    select  port_number, np.int_order_id,ext_order_id
    from    np_trx_detail@FOKUS nt,
            np_number_info@FOKUS np,
            np_order_data@FOKUS nd
    where port_ind = 'E'
      and nt.request_exec_date < sysdate
      and nvl(np.expiration_date,TO_DATE('47001231000000','YYYYMMDDHH24MISS')) > sysdate
      and nt.int_order_id=np.int_order_id
      and trx_status='S'
      and trx_code = 111 -- NP_GODK
      and trx_source='INT'
      and nd.int_order_id=np.int_order_id
      and order_status in ('C') -- GODK
      and nt.int_trx_seq = (select max(nt2.int_trx_seq)
                            from np_trx_detail@FOKUS nt2
                            where nt2.int_order_id=nt.int_order_id
                            and   nt2.trx_code= 111 --NP_GODK
                            and   nt2.trx_status = 'S'
                            and   nt2.trx_source='INT')
      and not exists (select 1
                       from batch_np_activities bnp
                      where bnp.port_number = '047'||np.port_number
                        and bnp.int_order_id=np.int_order_id
                        and bnp.process_status = 'WAITING');

 update_row1 c1%ROWTYPE;

  BEGIN
    FOR update_row1 in c1 LOOP
        insert into batch_np_activities values (
            null,
            '047'||update_row1.port_number,
            null,
            'PORTOU',
            'C',
            null,
            null,
            null,
            null,
            1,
            update_row1.int_order_id,
            null);
    commit;

   END LOOP;
 END POPULATE_PORT_OUT_CLOSE_CASE;
 
 -- Populate table for sending welcome SMS to ported customers
  PROCEDURE POPULATE_WELCOME_SMS IS
  
  activityCode char(6);
  
  cursor c1 is
    SELECT    port_number, ni.int_order_id
       FROM   np_number_info@FOKUS ni,
              np_order_data@FOKUS nd
       WHERE  port_ind in ('Y','B','P','I')
       and    number_type='P'
       AND    ni.effective_date = (SELECT MAX(effective_date)
                                   FROM   NP_NUMBER_INFO@FOKUS WHERE PORT_NUMBER = ni.PORT_NUMBER)
       and nvl(ni.expiration_date,TO_DATE('47001231000000','YYYYMMDDHH24MISS')) >= ni.PORT_REQUEST_DATE
       AND    ni.PORT_REQUEST_DATE < SYSDATE
       AND    ni.PORT_REQUEST_DATE >= SYSDATE-2
       --AND    TRUNC(np.SYS_CREATION_DATE) = SYSDATE - 1    --Run once per day
       AND    ni.INT_ORDER_ID = nd.INT_ORDER_ID
       AND    nd.ORDER_STATUS = 'L'
       and not exists(select 1
                       from batch_np_activities bnp
                      where bnp.port_number = '047'||ni.port_number
                        and bnp.int_order_id=ni.int_order_id
                        and activity_code in ('WLCSMV','WLCSMS') )
       -- next lines of the select are temporary for the first days of switching
       -- from the old scripts.
       --AND    NOT EXISTS ( SELECT /*+ HASH_AJ */ SUBSCRIBER_NO
       --                    FROM   SMS_SENT_TO_NP2@prod sm
       --                    WHERE  sm.SUBSCRIBER_NO = 'GSM047'||ni.PORT_NUMBER
       --                    AND    sms_send_date >= sysdate-5)
       ;

       
    update_row1 c1%ROWTYPE;

  BEGIN
    FOR update_row1 in c1 LOOP
      -- if there is a voicemail reserved, then voicemail number should be part of the sms
      BEGIN
        select  'WLCSMV'
        into    activityCode
        from    service_feature@FOKUS sf,
                feature@FOKUS ft
        where   subscriber_no = 'GSM047' || update_row1.port_number
        and     sysdate between ftr_effective_date and nvl(ftr_expiration_date,TO_DATE('47001231000000','YYYYMMDDHH24MISS'))
        and     ft.feature_code = sf.feature_code
        and     ft.feature_type in ('VMA','VMO','VCA');
      
      EXCEPTION -- no voicemail found
        WHEN no_data_found THEN
            activityCode := 'WLCSMS';
      END;
    
        insert into batch_np_activities values (
            null,
            '047'||update_row1.port_number,
            null,
            activityCode,
            'S',
            null,
            null,
            null,
            null,
            1,
            update_row1.int_order_id,
            null);
    commit;

   END LOOP;
 END POPULATE_WELCOME_SMS;
END populate_np_activities_pack;
/



-- End of DDL Script for Package Body NINJAMAIN_PRO2.POPULATE_NP_ACTIVITIES_PACK

