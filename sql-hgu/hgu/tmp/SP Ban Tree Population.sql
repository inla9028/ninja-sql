--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the ban-tree, with the statuses of the subscriptions. =--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.curr_root_ban, a.ban, b.sub_status, COUNT(*) AS "COUNT"
  FROM dd.billing_account a, dd.subscriber b
  WHERE a.curr_root_ban = 843438508 -- The root ban for Chess2.
    AND a.ban           = b.customer_id
  GROUP BY a.curr_root_ban, a.ban, b.sub_status
  ORDER BY a.curr_root_ban, a.ban, b.sub_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the ban-tree, without the statuses of the subscriptions. ==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.curr_root_ban, a.ban, COUNT(*) AS "COUNT"
  FROM dd.billing_account a, dd.subscriber b
  WHERE a.curr_root_ban = 843438508 -- The root ban for Chess2.
    AND a.ban           = b.customer_id
  GROUP BY a.curr_root_ban, a.ban
  ORDER BY a.curr_root_ban, a.ban

