SELECT a.subscriber_no, a.new_priceplan, a.new_campaign_code,
       a.new_subscription_type, a.handle_commitment, a.effective_date,
       a.dealer, a.sales_agent, a.reason_code, a.memo_text,
       a.waive_fees, a.enter_time, a.request_time, a.process_time,
       a.process_status, a.status_desc, a.priority, a.requestor_id,
       a.skip_ninja_validation
  FROM ninjadata.master_chg_pp_trans a
  WHERE a.requestor_id = 'AHV.03.11.2009'
    AND a.new_priceplan IN ('PKOF' , 'PKOG')
    AND a.process_status = 'PRSD_SUCCESS'
    AND EXISTS (
        SELECT o.* FROM service_agreement@oppe10 o
        WHERE a.subscriber_no = o.subscriber_no
          AND RTRIM(o.soc) = 'FLXDEAD'
          AND TRUNC(a.process_time) BETWEEN o.effective_date AND NVL(o.expiration_date, SYSDATE)
    )
/

SELECT a.subscriber_no
  FROM ninjadata.master_chg_pp_trans a
  WHERE a.requestor_id = 'AHV.03.11.2009'
    AND a.new_priceplan IN ('PKOF' , 'PKOG')
    AND a.process_status = 'PRSD_SUCCESS'
    AND EXISTS (
        SELECT o.* FROM service_agreement@oppe10 o
        WHERE a.subscriber_no = o.subscriber_no
          AND RTRIM(o.soc) = 'FLXDEAD'
          AND TRUNC(a.process_time) BETWEEN o.effective_date AND NVL(o.expiration_date, SYSDATE)
    )
/

SELECT COUNT(*) FROM  ninjadata.master_chg_pp_trans a WHERE a.requestor_id = 'AHV.03.11.2009'
    AND a.process_status = 'PRSD_SUCCESS'
    AND a.new_priceplan IN ('PKOF' , 'PKOG')
/

SELECT a.requestor_id, COUNT(*) AS "COUNT"
  FROM ninjadata.master_chg_pp_trans a
  WHERE a.request_time > TO_DATE('2009-10-01', 'YYYY-MM-DD')
  GROUP BY a.requestor_id
  ORDER BY a.requestor_id;

