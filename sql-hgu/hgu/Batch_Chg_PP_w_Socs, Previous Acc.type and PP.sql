/**
 * List the previous price-plan and BAN-type prior to the batch-job
 */
SELECT bcp.subscriber_no, RTRIM(sa.soc) AS "PREVIOUS_PRICEPLAN", bcp.new_priceplan
     , sa.ban, ba.account_type, ba.account_sub_type, bcp.process_time
  FROM batch_change_priceplan bcp, service_agreement@fokus sa, billing_account@fokus ba
 WHERE bcp.requestor_id  = 'AFD ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD')
   AND bcp.subscriber_no = sa.subscriber_no
   AND sa.ban            = ba.ban
   AND sa.service_type   = 'P'
   AND bcp.process_time - 1 BETWEEN sa.effective_date AND NVL(sa.expiration_date, SYSDATE + 1)
;

/**
 * List the socs after the job ran.
 */
SELECT bcp.subscriber_no, RTRIM(sa.soc) AS "PREVIOUS_PRICEPLAN", bcp.new_priceplan
     , sa.ban, ba.account_type, ba.account_sub_type, bcp.process_time
  FROM batch_change_priceplan bcp, service_agreement@fokus sa, billing_account@fokus ba
 WHERE bcp.requestor_id  = 'AFD ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD')
   AND bcp.subscriber_no = sa.subscriber_no
   AND sa.ban            = ba.ban
   AND sa.service_type   = 'P'
   AND bcp.process_time - 1 BETWEEN sa.effective_date AND NVL(sa.expiration_date, SYSDATE + 1)
;


