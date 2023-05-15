--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all subscribers active on BAN of specific account types.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, b.account_type, b.account_sub_type, a.subscriber_no, a.soc,
       a.campaign, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date
  FROM service_agreement a, billing_account b
  WHERE a.ban              = b.ban
    AND SYSDATE      BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.service_type     = 'P'
    AND b.account_type     = 'S'
    AND b.account_sub_type = 'TR'
    AND b.ban_status       = 'O'
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all subscribers active on BAN of specific account types.
--== Note! This query checks the status in the subscriber table, where as the
--== query above only checks that a subscription is not expired - thus it could
--== be suspended or...?
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, b.account_type, b.account_sub_type, a.subscriber_no, a.soc,
       a.campaign, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date
  FROM service_agreement a, billing_account b, subscriber s
  WHERE a.ban              = b.ban
    AND SYSDATE      BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.service_type     = 'P'
    AND b.account_type     = 'S'
    AND b.account_sub_type = 'TR'
    AND b.ban_status       = 'O'
    AND a.ban              = s.customer_id
    AND a.subscriber_no    = s.subscriber_no
    AND s.sub_status       = 'A'
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the active price plans
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, COUNT(*) AS "COUNT"
  FROM service_agreement a, billing_account b, subscriber s
 WHERE a.ban              = b.ban
   AND SYSDATE      BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
   AND a.service_type     = 'P' -- Only list price-plans
   AND b.ban_status       = 'O' -- Only list open BANs, i.e. not tentative, etc.
   AND a.ban              = s.customer_id
   AND a.subscriber_no    = s.subscriber_no
   AND s.sub_status       = 'A' -- Only list active subscriptions, not suspended, etc.
GROUP BY a.soc
ORDER BY a.soc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the active price plans
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, COUNT(*) AS "COUNT"
  FROM service_agreement a, billing_account b, subscriber s
 WHERE a.ban              = b.ban
   AND SYSDATE      BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
   AND a.service_type     = 'P' -- Only list price-plans
   AND b.ban_status       = 'O' -- Only list open BANs, i.e. not tentative, etc.
   AND b.
   AND a.ban              = s.customer_id
   AND a.subscriber_no    = s.subscriber_no
   AND s.sub_status       = 'A' -- Only list active subscriptions, not suspended, etc.
GROUP BY a.soc
ORDER BY a.soc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the active socs
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, COUNT(*) AS "COUNT"
  FROM service_agreement a, billing_account b, subscriber s
  WHERE a.ban              = b.ban
    AND SYSDATE      BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.service_type     = 'R'
    AND b.account_type     = 'S'
    AND b.account_sub_type = 'TR'
    AND b.ban_status       = 'O'
    AND a.ban              = s.customer_id
    AND a.subscriber_no    = s.subscriber_no
    AND s.sub_status       = 'A'
  GROUP BY a.soc
  ORDER BY a.soc;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all non-active subscribers on BAN of specific account types.
--== Note! This query checks the status in the subscriber table, where as the
--== query above only checks that a subscription is not expired - thus it could
--== be suspended or...?
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, b.account_type, b.account_sub_type, a.subscriber_no, a.soc,
       a.campaign, s.sub_status, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date
  FROM service_agreement a, billing_account b, subscriber s
  WHERE a.ban              = b.ban
    AND SYSDATE      BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.service_type     = 'P'
    AND b.account_type     = 'S'
    AND b.account_sub_type = 'TR'
    AND b.ban_status       = 'O'
    AND a.ban              = s.customer_id
    AND a.subscriber_no    = s.subscriber_no
    AND s.sub_status      != 'A'
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all subscribers (with all socs) active on BAN of specific account types.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, b.account_type, b.account_sub_type, a.subscriber_no, a.soc,
       a.campaign, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date
  FROM service_agreement a, billing_account b
  WHERE a.ban              = b.ban
    AND SYSDATE      BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND b.account_type     = 'S'
    AND b.account_sub_type = 'TR'
    AND b.ban_status       = 'O'
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;

