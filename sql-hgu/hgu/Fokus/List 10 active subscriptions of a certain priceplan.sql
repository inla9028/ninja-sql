SELECT s.subscriber_no, s.customer_id, s.sub_status, s.sub_status_date, a1.soc AS "PP"
  FROM subscriber@fokus s, service_agreement@fokus a1
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc        LIKE 'PVJ%'
   AND ROWNUM           < 11
;

SELECT s.subscriber_no, s.customer_id, s.sub_status, s.sub_status_date, a1.soc AS "PP"
  FROM subscriber@fokus s, service_agreement@fokus a1
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc        LIKE 'PPUR%'
   AND ROWNUM           < 11
;