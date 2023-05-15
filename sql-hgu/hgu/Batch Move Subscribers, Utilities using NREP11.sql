-- Set the proper target priceplan, based on the existing priceplan.
UPDATE batch_move_subscribers a
   SET a.new_priceplan = DECODE(
         (SELECT RTRIM(b.soc)
           FROM service_agreement@nrep11 b, subscriber@nrep11 s
          WHERE a.subscriber_no = b.subscriber_no
            AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
            AND RTRIM(b.soc)   IN ( 'PVHG', 'PVHR' )
            AND b.ban           = s.customer_id
            AND b.subscriber_no = s.subscriber_no
            AND s.sub_status    = 'A')
         , 'PVHG', 'PKOA'
         , 'PVHR', 'PKOB'
         , a.new_priceplan)
 WHERE a.request_id      = '2018-08-16'
   AND a.request_user_id = 'HGU'
   AND a.process_status  = 'ON_HOLD'
;

UPDATE batch_name_address_update b
   SET b.process_status = 'WAITING'
 WHERE ROWID IN
           (SELECT ROWID
              FROM batch_name_address_update a
             WHERE a.request_id = '2018-08-16'
               AND a.request_user_id = 'HGU'
               AND a.process_status = 'ON_HOLD'
               AND ROWNUM < 101)
;

UPDATE batch_name_address_update a
   SET a.request_id      = '2018-08-20'
 WHERE a.request_id      = '2018-08-16'
   AND a.request_user_id = 'HGU'
   AND a.process_status  = 'ON_HOLD'
;

UPDATE batch_name_address_update a
   SET a.request_id      = '2018-08-16'
 WHERE a.request_id      = '2018-08-15'
   AND a.request_user_id = 'HGU'
   AND a.process_status  = 'PRSD_SUCCESS'
   AND a.process_time    > TRUNC(SYSDATE)
;

SELECT a.*
  FROM batch_name_address_update a
 WHERE a.request_id      = '2018-08-20'
   AND a.request_user_id = 'HGU'
   AND a.process_status  = 'PRSD_SUCCESS'
ORDER BY a.subscriber_no
;






