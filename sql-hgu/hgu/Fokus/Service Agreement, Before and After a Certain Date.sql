SELECT '1.BEFORE' AS "WHEN", sa.ban, sa.subscriber_no, sa.soc, sa.sys_creation_date AS "EFFECTIVE_DATE", sa.expiration_date
  FROM service_agreement sa
 WHERE sa.subscriber_no = 'GSM047' || '97578423'
--   AND SYSDATE - 2 BETWEEN sa.effective_date AND nvl(sa.expiration_date, SYSDATE + 1)
   AND TO_DATE('2017-01-04', 'YYYY-MM-DD') - 1 BETWEEN sa.effective_date AND nvl(sa.expiration_date, SYSDATE + 1)
UNION
SELECT '2. AFTER' AS "WHEN", sa.ban, sa.subscriber_no, sa.soc, sa.sys_creation_date AS "EFFECTIVE_DATE", sa.expiration_date
  FROM service_agreement sa
 WHERE sa.subscriber_no = 'GSM047' || '97578423'
--   AND SYSDATE BETWEEN sa.effective_date AND nvl(sa.expiration_date, SYSDATE + 1)
   AND TO_DATE('2017-01-04', 'YYYY-MM-DD') + 1 BETWEEN sa.effective_date AND nvl(sa.expiration_date, SYSDATE + 1)
ORDER BY 1,2,3,4
;
