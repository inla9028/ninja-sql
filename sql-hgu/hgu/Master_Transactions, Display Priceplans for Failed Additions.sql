--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the priceplans of all requests that were not allowed to receive the soc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, RTRIM(sa.soc) AS "PRICEPLAN",
       RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.master_transactions a, service_agreement@prod sa
  WHERE a.request_id     IN ('AFL 14.10.2010')
--    AND a.process_status = 'PRSD_ERROR'
--    AND a.status_desc  LIKE '%SOC is not available for add to subscription%'
    AND a.subscriber_no = sa.subscriber_no
    AND a.process_time BETWEEN sa.effective_date AND NVL(sa.expiration_date, TO_DATE('4701', 'YYYY'))
    AND sa.service_type = 'P'
  ORDER BY a.subscriber_no;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the priceplans (and the number of them) that were not allowed to receive the soc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT RTRIM(sa.soc) AS "PRICEPLAN", COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a, service_agreement@prod sa
  WHERE a.request_id     IN ('AFL 14.10.2010')
--    AND a.process_status = 'PRSD_ERROR'
--    AND a.status_desc  LIKE '%SOC is not available for add to subscription%'
    AND a.subscriber_no = sa.subscriber_no
    AND a.process_time BETWEEN sa.effective_date AND NVL(sa.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND SYSDATE BETWEEN sa.effective_date AND NVL(sa.expiration_date, TO_DATE('4701', 'YYYY'))
    AND sa.service_type = 'P'
  GROUP BY RTRIM(sa.soc)
  ORDER BY "PRICEPLAN";


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the BANs for the subscriptions.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT sa.ban, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a, service_agreement@prod sa
  WHERE a.request_id     IN ('AFL 14.10.2010')
--    AND a.process_status = 'PRSD_ERROR'
--    AND a.status_desc  LIKE '%SOC is not available for add to subscription%'
    AND a.subscriber_no = sa.subscriber_no
    AND a.process_time BETWEEN sa.effective_date AND NVL(sa.expiration_date, TO_DATE('4701', 'YYYY'))
--    AND SYSDATE BETWEEN sa.effective_date AND NVL(sa.expiration_date, TO_DATE('4701', 'YYYY'))
    AND sa.service_type = 'P'
  GROUP BY sa.ban
  ORDER BY sa.ban;

