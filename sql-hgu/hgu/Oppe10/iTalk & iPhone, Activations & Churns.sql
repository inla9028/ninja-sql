--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all subscribers registered after the official release date.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.soc_ver_no,
       a.soc_effective_date, a.campaign, a.sys_creation_date,
       a.sys_update_date, a.effective_date, a.expiration_date,
       a.commit_orig_no_month, a.service_type, a.dealer_code,
       a.sales_agent, a.campaign_seq, a.sys_changed_date
  FROM service_agreement a
  WHERE RTRIM(a.soc) IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date > TO_DATE('2008-07-10', 'YYYY-MM-DD')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Displays the registered subscribers per campaign.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, a.campaign, COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc) IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date > TO_DATE('2008-07-10', 'YYYY-MM-DD')
  GROUP BY a.soc, a.campaign
  ORDER BY a.soc, a.campaign

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the create- and expiration date for churned iTalk & iConnect
--== subscribers, registered (and churned) after the official release date.
--== o Per hour
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD HH24') || ':00-59' AS "EFFECTIVE_DATE", 
       TO_CHAR(a.sys_changed_date,  'YYYY-MM-DD HH24') || ':00-59' AS "EXPIRATION_DATE",
       COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc)     IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date  > TO_DATE('2008-07-10', 'YYYY-MM-DD')
    AND a.expiration_date < SYSDATE 
  GROUP BY TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD HH24'), TO_CHAR(a.sys_changed_date,  'YYYY-MM-DD HH24')
  ORDER BY "EFFECTIVE_DATE", "EXPIRATION_DATE"

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the create- and expiration date for churned iTalk & iConnect
--== subscribers, registered (and churned) after the official release date.
--== o Per day
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD') AS "EFFECTIVE_DATE", 
       TO_CHAR(a.sys_changed_date,  'YYYY-MM-DD') AS "EXPIRATION_DATE",
       COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc)     IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date  > TO_DATE('2008-07-10', 'YYYY-MM-DD')
    AND TRUNC(a.expiration_date) = TRUNC(a.effective_date)
  GROUP BY TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD'), TO_CHAR(a.sys_changed_date,  'YYYY-MM-DD')
  ORDER BY "EFFECTIVE_DATE", "EXPIRATION_DATE"

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the create- and expiration date for churned iTalk & iConnect
--== subscribers, registered (and churned) after the official release date.
--== o Per day
--== o Per priceplan
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD') AS "EFFECTIVE_DATE", 
       TO_CHAR(a.sys_changed_date,  'YYYY-MM-DD') AS "EXPIRATION_DATE",
       RTRIM(a.soc) AS "SOC", COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc)     IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date  > TO_DATE('2008-07-10', 'YYYY-MM-DD')
    AND a.expiration_date < SYSDATE 
  GROUP BY TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD'), TO_CHAR(a.sys_changed_date,  'YYYY-MM-DD'), RTRIM(a.soc)
  ORDER BY "EFFECTIVE_DATE", "EXPIRATION_DATE", "SOC"

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the create- and expiration date for churned iTalk & iConnect
--== subscribers, registered (and churned) after the official release date.
--== o Per priceplan
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT RTRIM(a.soc) AS "SOC", COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc)     IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date  > TO_DATE('2008-07-10', 'YYYY-MM-DD')
    AND a.expiration_date < SYSDATE 
  GROUP BY RTRIM(a.soc)
  ORDER BY "SOC"

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the create- date for iTalk & iConnect subscribers, registered 
--== AFTER the official release date (and not churned).
--== o Per priceplan
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT RTRIM(a.soc) AS "SOC", COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc)     IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date  > TO_DATE('2008-07-10', 'YYYY-MM-DD')
    AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY')) > SYSDATE 
  GROUP BY RTRIM(a.soc)
  ORDER BY "SOC"

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the create- date for iTalk & iConnect subscribers, registered 
--== AFTER the official release date (and not churned).
--== o Per day
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.effective_date, 'YYYY-MM-DD') AS "EFFECTIVE_DATE", COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc)     IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date  > TO_DATE('2008-07-10', 'YYYY-MM-DD')
    AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY')) > a.effective_date 
  GROUP BY TO_CHAR(a.effective_date, 'YYYY-MM-DD')
  ORDER BY "EFFECTIVE_DATE"


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Statistics - Registerred and NOT churned ON THE SAME DAY
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.effective_date, 'YYYY-MM-DD') AS "EFFECTIVE_DATE", COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc)     IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date  > TO_DATE('2008-07-10', 'YYYY-MM-DD')
    AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY')) > a.effective_date 
  GROUP BY TO_CHAR(a.effective_date, 'YYYY-MM-DD')
  ORDER BY "EFFECTIVE_DATE"

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Statistics - Registerred AND churned ON THE SAME DAY
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.effective_date, 'YYYY-MM-DD') AS "EFFECTIVE_DATE", COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc)     IN ('PPTO', 'PPTP', 'PPTQ', 'PPTZ')
    AND a.effective_date  > TO_DATE('2008-07-10', 'YYYY-MM-DD')
    AND NVL(a.expiration_date, TO_DATE('4701', 'YYYY')) = a.effective_date 
  GROUP BY TO_CHAR(a.effective_date, 'YYYY-MM-DD')
  ORDER BY "EFFECTIVE_DATE"
