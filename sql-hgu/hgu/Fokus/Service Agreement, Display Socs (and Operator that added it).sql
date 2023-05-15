--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective socs for a given time, including the operator
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, a.act_reason_code,
       a.operator_id, u.user_full_name
  FROM service_agreement a, users u
-- WHERE a.subscriber_no = 'GSM04793258498'
 WHERE a.subscriber_no = 'GSM047' || '90963548'
--   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--   AND TO_DATE('2011-10-13', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
   AND a.operator_id = u.user_id(+)
ORDER BY a.subscriber_no, a.ban, /*a.campaign desc, *//*a.service_type,*/ a.soc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the effective BAN-level socs for a given time, including the operator
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, a.act_reason_code,
       a.operator_id, u.user_full_name
  FROM service_agreement a, users u
  WHERE a.ban = 100184001
    AND a.subscriber_no = '0000000000'
--    AND a.service_type = 'P'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND TO_DATE('2009-11-11', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.operator_id = u.user_id(+)
  ORDER BY a.ban, /*a.campaign desc, *//*a.service_type,*/ a.soc;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Temp: Display known duplicate socs...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.commit_orig_no_month,
       a.service_type, a.effective_date, a.expiration_date, a.act_reason_code,
       a.operator_id, u.user_full_name
  FROM service_agreement a, users u
  WHERE ((a.ban = 494250707 AND a.subscriber_no = '0000000000'     AND RTRIM(a.soc) = '000000000')
      OR (a.ban = 276773405 AND a.subscriber_no = '0000000000'     AND RTRIM(a.soc) = 'VSADM')
      OR (a.ban = 245669502 AND a.subscriber_no = 'GSM04790579363' AND RTRIM(a.soc) = 'CALLSPFRI')
      OR (a.ban = 307288605 AND a.subscriber_no = 'GSM04793097668' AND RTRIM(a.soc) = 'INSURNC'))
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY'))
    AND a.operator_id = u.user_id(+)
  ORDER BY a.subscriber_no, a.ban, a.service_type, a.soc;


