--== Dispaly the BANs belonging to SP's --==--==--==--==--==--==--==--==--==--==
SELECT a.description, b.*
FROM billing_account b, account_type a
  WHERE a.acc_type     = b.account_type
    AND a.acc_sub_type = b.account_sub_type
    AND b.account_type = 'S'
ORDER BY account_type, account_sub_type

--== Display the subscriptions these BANs --==--==--==--==--==--==--==--==--==--
SELECT *
  FROM subscriber a
  WHERE a.customer_ban in (363555400, 463555409, 711555409, 811555408)
  ORDER BY a.subscriber_no

