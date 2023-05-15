--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Find subscriptions with a specific soc.
--== Since we use two indexes (ninja_view_ind2 & service_agreement_gl),
--== we don't get all columns.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, RTRIM(a.soc) AS "SOC", a.effective_date, a.expiration_date
  FROM service_agreement a
  WHERE RTRIM(a.soc) = 'HINT'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND ROWNUM < 151
  ORDER BY dbms_random.value();

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Find subscriptions with a specific soc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.soc_ver_no,
       a.soc_effective_date, a.campaign, a.sys_creation_date,
       a.sys_update_date, a.effective_date, a.expiration_date,
       a.commit_orig_no_month, a.service_type, a.dealer_code,
       a.sales_agent, a.campaign_seq, a.sys_changed_date
  FROM dd.service_agreement@oppe10 a
  WHERE RTRIM(a.soc) = 'PPTE'
    AND a.service_type = 'P'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1);
