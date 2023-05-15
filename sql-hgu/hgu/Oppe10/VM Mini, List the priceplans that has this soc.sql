--==
--== Locate all socs that exists on a given priceplan.
--== Last time (2010-06-03) this query took 14972(!) seconds to execute.
--==
SELECT RTRIM(a.soc) AS "SOC", COUNT(*) AS "COUNT"
  FROM dd.service_agreement a
  WHERE a.service_type  = 'P'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND EXISTS (
        SELECT '' FROM dd.service_agreement b
          WHERE a.ban           = b.ban
            AND a.subscriber_no = b.subscriber_no
            AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
            AND RTRIM(b.soc)    = 'VMMINI')
  GROUP BY RTRIM(a.soc)
  ORDER BY RTRIM(a.soc);

