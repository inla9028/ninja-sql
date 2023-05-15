--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date
  FROM service_agreement a
  WHERE a.subscriber_no = 'GSM04791195443'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2009-02-10', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
  ORDER BY a.subscriber_no, a.ban, a.campaign DESC, a.soc;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the socs that are or were effective until xxx days ago.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date
  FROM service_agreement a
  WHERE a.subscriber_no = 'GSM04740628924'
    AND NVL(a.expiration_date, SYSDATE) > TRUNC(SYSDATE) - 7
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc, a.effective_date;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including account types.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, b.account_type, b.account_sub_type, a.subscriber_no, a.soc,
       a.campaign, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date
  FROM service_agreement a, billing_account b
  WHERE a.subscriber_no = 'GSM04791195443'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2008-12-01', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.ban = b.ban
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;


