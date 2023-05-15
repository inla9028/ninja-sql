--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, RTRIM(a.soc) AS "SOC", a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, a.act_reason_code
  FROM service_agreement a
--  WHERE a.ban = 705660017
  WHERE a.subscriber_no IN ('GSM047' || '40642411')
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2010-11-17', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2012-01-23', 'YYYY-MM-DD') < a.effective_date
--    AND a.service_type = 'P'
  ORDER BY a.subscriber_no, a.ban, a.campaign desc, a.soc
--  order by a.effective_date, a.expiration_date
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the socs that are or were effective until xxx days ago.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, a.act_reason_code
  FROM service_agreement a
--  WHERE a.subscriber_no = 'GSM04792202557'
  WHERE a.subscriber_no = 'GSM047' || '92648783'
--    AND NVL(a.expiration_date, SYSDATE) > TRUNC(SYSDATE) - 7
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc, a.effective_date;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including account types.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, b.account_type, b.account_sub_type, a.subscriber_no, a.soc,
       a.campaign, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date, a.act_reason_code
  from service_agreement a, billing_account b
--  WHERE a.ban = 444917603
--  WHERE a.subscriber_no = 'GSM04792202557'
  WHERE a.subscriber_no = 'GSM047' || '92648783'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2011-10-15', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.ban = b.ban
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including any prices.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, 
       b.rate AS "ONE_TIME_CHARGE", c.rate AS "RECURRING_CHARGE"
  from service_agreement a, pp_oc_rate b, pp_rc_rate c
  WHERE a.ban = 553217605
--  WHERE a.subscriber_no = 'GSM04792202557'
--  WHERE a.subscriber_no = 'GSM047' || '46418114'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2008-07-14', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.soc = b.soc(+)
    AND SYSDATE BETWEEN b.effective_date(+) AND NVL(b.expiration_date(+), TO_DATE('4701', 'YYYY'))
    AND a.soc = c.soc(+)
    AND SYSDATE BETWEEN c.effective_date(+) AND NVL(c.expiration_date(+), TO_DATE('4701', 'YYYY'))
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;

