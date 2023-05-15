--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, RTRIM(a.soc) AS "SOC", d.description, a.campaign,
       a.commit_orig_no_month, a.service_type, a.effective_date, a.expiration_date,
       a.act_reason_code, a.operator_id, u.user_full_name
  FROM service_agreement@fokus a, users@fokus u, socs_descriptions d
  WHERE a.subscriber_no IN  ('GSM047' || '40505666')
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2012-06-05', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.operator_id = u.user_id(+)
    AND RTRIM(a.soc) = d.soc(+)
    AND d.language_code = 'NO'
  ORDER BY a.subscriber_no, a.ban, a.soc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including account types.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, b.account_type, b.account_sub_type, a.subscriber_no, a.soc,
       a.campaign, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date, a.act_reason_code
  FROM service_agreement@fokus a, billing_account@fokus b
  WHERE a.subscriber_no IN  ('GSM047' || '45403206')
--    AND a.service_type = 'P'
--    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND TO_DATE('2014-03-10', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.ban = b.ban
  ORDER BY a.ban, a.subscriber_no, a.campaign desc, a.soc;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including any prices.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, 
       b.rate AS "ONE_TIME_CHARGE", c.rate AS "RECURRING_CHARGE"
  FROM service_agreement@prod a, pp_oc_rate@prod b, pp_rc_rate@prod c
  WHERE a.subscriber_no IN  ('GSM047' || '97665900' )
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2008-07-08', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.soc = b.soc(+)
    AND SYSDATE BETWEEN b.effective_date(+) AND NVL(b.expiration_date(+), TO_DATE('4701', 'YYYY'))
    AND a.soc = c.soc(+)
    AND SYSDATE BETWEEN c.effective_date(+) AND NVL(c.expiration_date(+), TO_DATE('4701', 'YYYY'))
  ORDER BY a.subscriber_no, a.ban, a.campaign desc, a.soc;

