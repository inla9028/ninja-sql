SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, 
       b.rate AS "ONE_TIME_CHRG", c.rate AS "RECURRING_CHRG"
  FROM service_agreement a, pp_oc_rate b, pp_rc_rate c
  WHERE a.subscriber_no = 'GSM04792267222'
--    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND TO_DATE('2007-12-01', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.soc = b.soc(+)
    AND SYSDATE BETWEEN b.effective_date (+) AND NVL(b.expiration_date (+), TO_DATE('4701', 'YYYY'))
    AND a.soc = c.soc (+)
    AND SYSDATE BETWEEN c.effective_date (+) AND NVL(c.expiration_date (+), TO_DATE('4701', 'YYYY'))
    
  
