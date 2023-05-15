--==
--== Locate all socs that exists on a given priceplan.
--== Last time (2009-11-03) this query took 74 seconds to execute.
--==
SELECT RTRIM(b.soc) AS "SOC", COUNT(*) AS "COUNT"
  FROM dd.service_agreement a, dd.service_agreement b
  WHERE SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
    AND RTRIM(a.soc) = 'PCFC'
    AND a.ban = b.ban
    AND a.subscriber_no = b.subscriber_no
    AND SYSDATE BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
  GROUP BY RTRIM(b.soc)
  ORDER BY RTRIM(b.soc);

