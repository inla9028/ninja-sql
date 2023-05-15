SELECT   RTRIM (a.soc) AS "SOC", COUNT (*) AS "COUNT"
    FROM service_agreement@oppe10 a
--   WHERE TO_DATE('2009-12-31', 'YYYY-MM-DD') BETWEEN a.effective_date AND NVL (a.expiration_date, TO_DATE ('4701', 'YYYY'))
   WHERE SYSDATE BETWEEN a.effective_date AND NVL (a.expiration_date, TO_DATE ('4701', 'YYYY'))
     AND a.service_type = 'P'
     AND EXISTS (
            SELECT mt.*
              FROM ninjadata.master_transactions mt
             WHERE mt.request_id = 'OBM 31.12.09'
               AND a.subscriber_no = mt.subscriber_no)
GROUP BY RTRIM (a.soc)
ORDER BY RTRIM (a.soc);

