/*
 Håkan:
    I'm looking into the suffocation of SMS-es when we port in subscriptions via MARV (api_master_transactions).

    Ninja knows the ctn (`api_master_transactions`.`ctn`) and the porting date. I can't see that the porting date
    is present in `api_master_transactions`, but I assume it´s in `api_np_details`.`port_request_date`?

    Will that date correspond _exactly_ to the date Ninja receives from `np_number_info`.`port_request_date`?

 Ina:
    request_date in api_master_transactions is port date when request_status = 'W' (waiting for porting move)

    the date in api_np_details is the initial port date that MARV fills in, but if later on port date is changed
    directly in Fokus then request_date will get updated accordingly, like it is done in Ninja for move
*/
 
SELECT mt.*
  FROM api_master_transactions mt
 WHERE mt.subscriber_no  = '047' || '40213683'
--   AND mt.request_status = 'W'
;

SELECT nd.*
  FROM api_np_details nd
 WHERE nd.master_trx_id IN (SELECT mt.master_trx_id
                              FROM api_master_transactions mt
                            WHERE mt.subscriber_no  = '047' || '40213683')
;

/*
** Ina:
**  you basically should just add to the job that sends SMS message not to send them whe there is a subscriber in api_master_transactions where request_status='W'
**  you should not care about at what porting stage it is now
**  status W means that number is somewhere between BEST and FERD
*/
SELECT COUNT(1) AS "COUNT"
  FROM api_master_transactions mt
 WHERE mt.subscriber_no  IN ('04740213683', 'GSM04740213683')
   AND mt.request_status = 'W'
;

SELECT mt.*
  FROM api_master_transactions mt
 WHERE mt.subscriber_no  IN ('04740213683', 'GSM04740213683')
--   AND mt.request_status = 'W'
;

-- Where is the table?
SELECT a.*
  FROM all_tables a
 WHERE a.table_name = 'API_MASTER_TRANSACTIONS'
;
