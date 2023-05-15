--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of registered (and not churned) subscribers, AFTER the
--== official release date.
--== o Per day
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.effective_date, 'YYYY-MM-DD') AS "EFFECTIVE_DATE",
       COUNT(*) AS "ACTIVE_SUB"
  FROM service_agreement a
  WHERE RTRIM(a.soc)     IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date  > TO_DATE('2008-07-10', 'YYYY-MM-DD')
    AND a.expiration_date <> effective_date 
  GROUP BY TO_CHAR(a.effective_date, 'YYYY-MM-DD')
  ORDER BY "EFFECTIVE_DATE"

--
SELECT SUBSTR(a.campaign, 7) AS "CAMPAIGN", COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc) IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date > TO_DATE('2008-07-10', 'YYYY-MM-DD')
  GROUP BY SUBSTR(a.campaign, 7)
  ORDER BY "CAMPAIGN"

--
SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.soc_ver_no,
       a.soc_effective_date, a.campaign, a.sys_creation_date,
       a.sys_update_date, a.effective_date, a.expiration_date,
       a.commit_orig_no_month, a.service_type, a.dealer_code,
       a.sales_agent, a.campaign_seq, a.sys_changed_date
  FROM service_agreement a
  WHERE RTRIM(a.soc) IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.campaign    = '000000000'
    AND a.effective_date > TO_DATE('2008-07-10', 'YYYY-MM-DD')

