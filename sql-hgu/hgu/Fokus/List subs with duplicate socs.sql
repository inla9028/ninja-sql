SELECT a.ban, a.subscriber_no, 
      RTRIM(a.soc) AS "SOC_A", a.soc_seq_no AS "SEQ_NO_A", a.effective_date AS "EFF_DATE_A", 
      RTRIM(b.soc) AS "SOC_B", b.soc_seq_no AS "SEQ_NO_B", b.effective_date AS "EFF_DATE_B"
  FROM service_agreement a, service_agreement b
 WHERE a.ban           = b.ban
   AND a.subscriber_no = b.subscriber_no
   AND a.soc           = b.soc
   AND a.soc_seq_no   != b.soc_seq_no
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND SYSDATE   BETWEEN b.effective_date AND NVL(b.expiration_date, SYSDATE + 1)
;
 
