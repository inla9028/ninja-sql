--==
--== Publish Level
--==
UPDATE ninjadata.batch_publishlevel_update a
   SET a.process_status  = 'IN_PROGRESS',
       a.status_desc     = 'Paused as previous MOVE failed'
 WHERE a.request_id      = 'BB 06/06 2011'
   AND a.request_user_id = 'BB katalogoppdatering'
   AND 0 !=
          (SELECT COUNT (*)
             FROM batch_move_subscribers b
            WHERE b.subscriber_no = 'GSM047' || a.subscriber_no
              AND b.request_id IN ('BB 1_bedrift')
              AND b.request_user_id IN ('TC migration')
              AND b.process_status = 'PRSD_ERROR');


--==
--== Master Transactions
--==
UPDATE ninjadata.master_transactions a
   SET a.process_status  = 'IN_PROGRESS',
       a.status_desc     = 'Paused as previous MOVE failed'
 WHERE a.request_id      = 'BB _MBB 2011'
   AND 0 !=
          (SELECT COUNT (*)
             FROM batch_move_subscribers b
            WHERE b.subscriber_no = a.subscriber_no
              AND b.request_id IN ('BB 1_bedrift')
              AND b.request_user_id IN ('TC migration')
              AND b.process_status = 'PRSD_ERROR');


--==
--==
--==

