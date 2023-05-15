SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.soc_ver_no,
       a.soc_effective_date, a.campaign, a.sys_creation_date,
       a.sys_update_date, a.effective_date, a.expiration_date,
       a.commit_orig_no_month, a.service_type, a.dealer_code,
       a.sales_agent, a.campaign_seq, a.sys_changed_date
  FROM service_agreement a
  WHERE RTRIM(a.soc) = 'FRINETK'
    AND a.effective_date
        BETWEEN TO_DATE('2007-12-01 00:01', 'YYYY-MM-DD HH24:MI')
            AND TO_DATE('2008-02-03 23:59', 'YYYY-MM-DD HH24:MI')
    AND a.expiration_date > SYSDATE

--
SELECT COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc) = 'FRINETK'
    AND a.effective_date
        BETWEEN TO_DATE('2007-12-01 00:01', 'YYYY-MM-DD HH24:MI')
            AND TO_DATE('2008-02-03 23:59', 'YYYY-MM-DD HH24:MI')
    AND a.expiration_date > SYSDATE


SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.soc_ver_no,
       a.soc_effective_date, a.campaign, a.sys_creation_date,
       a.sys_update_date, a.effective_date, a.expiration_date,
       a.commit_orig_no_month, a.service_type, a.dealer_code,
       a.sales_agent, a.campaign_seq, a.sys_changed_date
  FROM service_agreement a
  WHERE RTRIM(a.soc) = 'FRINETYT'
    AND a.effective_date
        BETWEEN TO_DATE('2007-12-01 00:01', 'YYYY-MM-DD HH24:MI')
            AND TO_DATE('2008-01-31 23:59', 'YYYY-MM-DD HH24:MI')
    AND a.expiration_date > SYSDATE


--
SELECT COUNT(*) AS "COUNT"
  FROM service_agreement a
  WHERE RTRIM(a.soc) = 'FRINETYT'
    AND a.effective_date
        BETWEEN TO_DATE('2007-12-01 00:01', 'YYYY-MM-DD HH24:MI')
            AND TO_DATE('2008-01-31 23:59', 'YYYY-MM-DD HH24:MI')
    AND a.expiration_date > SYSDATE




