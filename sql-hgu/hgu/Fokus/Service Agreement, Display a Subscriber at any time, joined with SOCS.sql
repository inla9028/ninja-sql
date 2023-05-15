SELECT a.ban, a.subscriber_no, a.soc, d.soc_type, d.soc_group, a.campaign,
       a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date, b.rate AS "ONE_TIME_CHARGE", c.rate AS "RECURRING_CHARGE"
  FROM service_agreement@fokus a, pp_oc_rate@fokus b, pp_rc_rate@fokus c, socs d
  WHERE a.subscriber_no IN ('GSM04741245318')
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2011-03-08', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.soc = b.soc(+)
    AND SYSDATE BETWEEN b.effective_date(+) AND NVL(b.expiration_date(+), TO_DATE('4701', 'YYYY'))
    AND a.soc = c.soc(+)
    AND SYSDATE BETWEEN c.effective_date(+) AND NVL(c.expiration_date(+), TO_DATE('4701', 'YYYY'))
    AND TRIM(a.soc) = d.soc(+)
  ORDER BY a.subscriber_no, a.ban, a.campaign DESC, a.soc;


--==
SELECT a.ban, a.subscriber_no, a.soc, d.soc_type, d.soc_group, e.feature_code,
       a.campaign, a.commit_orig_no_month, a.service_type, a.effective_date,
       a.expiration_date, b.rate AS "ONE_TIME_CHARGE", c.rate AS "RECURRING_CHARGE"
  FROM service_agreement@fokus a, pp_oc_rate@fokus b, pp_rc_rate@fokus c,
       socs d, socs_features e
  WHERE a.subscriber_no IN ('GSM047' || '40246332')
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2007-12-01', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND RTRIM(a.soc)  = b.soc(+)
    AND SYSDATE BETWEEN b.effective_date(+) AND NVL(b.expiration_date(+), TO_DATE('4701', 'YYYY'))
    AND RTRIM(a.soc)  = c.soc(+)
    AND SYSDATE BETWEEN c.effective_date(+) AND NVL(c.expiration_date(+), TO_DATE('4701', 'YYYY'))
    AND RTRIM(a.soc)  = d.soc(+)
    AND RTRIM(a.soc)  = e.soc(+)
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc
