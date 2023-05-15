--== Lookup a SP subscriber that is active...
SELECT s.subscriber_no, b.ban, b.account_type, b.account_sub_type
  FROM subscriber s, billing_account b
 WHERE b.ban_status        = 'O'
   AND s.sub_status        = 'A'
   AND b.account_type      = 'I'
   AND b.account_sub_type  = 'R'
   AND s.customer_id       = b.ban
   AND ROWNUM        < 101
ORDER BY s.subscriber_no, b.ban, b.account_type, b.account_sub_type
;

