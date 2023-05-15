/*
** List all waiting of on hold.
*/
SELECT a.*
  FROM batch_change_priceplan a
 WHERE a.process_status IN ('ON_HOLD', 'WAITING', 'DUPLICATE')
;

/*
** List an overview...
*/
SELECT a.requestor_id, a.process_status, COUNT(1) AS "COUNT"
  FROM batch_change_priceplan a
 WHERE a.process_status IN ('ON_HOLD', 'WAITING', 'DUPLICATE')
GROUP BY a.requestor_id, a.process_status
ORDER BY 1, 2
;


/*
** List duplicates...
*/
SELECT a.subscriber_no, a.old_priceplan, a.new_priceplan,
       a.new_campaign_code, a.new_subscription_type,
       a.handle_commitment, a.socs_to_add, a.socs_to_delete,
       a.effective_date, a.dealer, a.sales_agent, a.reason_code,
       a.memo_text, a.waive_fees, a.enter_time, a.request_time,
       a.process_time, a.process_status, a.status_desc,
       a.skip_ninja_validation, a.separate_saves, a.requestor_id,
       b.requestor_id AS "REQ_ID_2", b.request_time AS "REQ_TIME_2",
       b.process_status AS "PR_STS_2"
  FROM batch_change_priceplan a, batch_change_priceplan b
  WHERE a.process_status        IN ('ON_HOLD', 'WAITING' )
    AND b.process_status        IN ('ON_HOLD', 'WAITING' )
    AND a.subscriber_no         = b.subscriber_no
    AND a.old_priceplan         = b.old_priceplan
    AND a.new_priceplan         = b.new_priceplan
    AND a.new_campaign_code     = b.new_campaign_code
    AND a.new_subscription_type = b.new_subscription_type
    AND a.handle_commitment     = b.handle_commitment
    AND a.socs_to_add           = b.socs_to_add
    AND a.socs_to_delete        = b.socs_to_delete
    AND a.dealer                = b.dealer
    AND a.sales_agent           = b.sales_agent
    AND a.reason_code           = b.reason_code
    AND a.memo_text             = b.memo_text
    AND a.waive_fees            = b.waive_fees
    AND a.skip_ninja_validation = b.skip_ninja_validation
    AND a.ROWID                 != b.ROWID
;

/*
** Expire the most recent records.
*/
UPDATE batch_change_priceplan x
   SET x.process_status = 'DUPLICATE', x.process_time = SYSDATE,
       x.status_desc = 'Duplicate detected at ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
 WHERE x.process_status IN ('ON_HOLD', 'WAITING' )
   AND x.ROWID IN (
    SELECT a.ROWID
      FROM batch_change_priceplan a, batch_change_priceplan b
     WHERE a.process_status        IN ('ON_HOLD', 'WAITING' )
       AND b.process_status        IN ('ON_HOLD', 'WAITING' )
       AND a.subscriber_no         = b.subscriber_no
       AND a.old_priceplan         = b.old_priceplan
       AND a.new_priceplan         = b.new_priceplan
       AND a.new_campaign_code     = b.new_campaign_code
       AND a.new_subscription_type = b.new_subscription_type
       AND a.handle_commitment     = b.handle_commitment
       AND a.socs_to_add           = b.socs_to_add
       AND a.socs_to_delete        = b.socs_to_delete
       AND a.dealer                = b.dealer
       AND a.sales_agent           = b.sales_agent
       AND a.reason_code           = b.reason_code
       AND a.memo_text             = b.memo_text
       AND a.waive_fees            = b.waive_fees
       AND a.skip_ninja_validation = b.skip_ninja_validation
       AND a.requestor_id         != b.requestor_id
)
;

/*
** List all records which has a duplicate..
*/
SELECT a.*
  FROM batch_change_priceplan a
 WHERE a.subscriber_no IN (SELECT b.subscriber_no
                             FROM batch_change_priceplan b
                            WHERE b.process_status = 'DUPLICATE')
ORDER BY a.subscriber_no, a.request_time
;


