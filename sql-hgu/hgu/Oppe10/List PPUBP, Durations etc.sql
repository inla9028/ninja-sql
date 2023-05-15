SELECT RTRIM(a.soc) AS "SOC", a.effective_date, a.expiration_date,
       TO_NUMBER(a.expiration_date - a.effective_date) AS "DURATION", COUNT(*) AS "COUNT"
  FROM dd.service_agreement a
  WHERE RTRIM(a.soc) = 'PPUBP'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
--    AND ROWNUM < 151
  GROUP BY RTRIM(a.soc), a.effective_date, a.expiration_date, TO_NUMBER(a.expiration_date - a.effective_date)
  ORDER BY RTRIM(a.soc), a.effective_date, a.expiration_date, TO_NUMBER(a.expiration_date - a.effective_date)


SELECT RTRIM(a.soc) AS "SOC", TO_NUMBER(a.expiration_date - a.effective_date) AS "DURATION", COUNT(*) AS "COUNT"
  FROM dd.service_agreement a
  WHERE RTRIM(a.soc) = 'PPUBP'
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
--    AND ROWNUM < 151
  GROUP BY RTRIM(a.soc), TO_NUMBER(a.expiration_date - a.effective_date)
  ORDER BY RTRIM(a.soc), TO_NUMBER(a.expiration_date - a.effective_date)


