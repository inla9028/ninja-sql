SELECT s.subscriber_no, s.customer_id, s.sub_status, a1.soc AS "PP", a2.soc AS "SOC", a2.effective_date
  FROM subscriber s, service_agreement a1, service_agreement a2 
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc          IN ( 'PVIC', 'PVID' )
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND RTRIM(a2.soc)   IN ( 'LOPFLX01' )
--   AND ROWNUM < 11
;

-- DB-link...
SELECT /*+ driving_site(s)*/
       s.subscriber_no, s.customer_id, s.sub_status, a1.soc AS "PP", a2.soc AS "SOC", a2.effective_date
  FROM subscriber@fokus s, service_agreement@fokus a1, service_agreement@fokus a2 
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.service_type  = 'P'
--   AND a1.soc          IN ( 'PVIC', 'PVID' )
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND RTRIM(a2.soc)   IN ( 'LOPFLX01' )
   AND ROWNUM < 11
;

/*
** Same as above, but including descriptions.
*/
SELECT s.subscriber_no, s.customer_id, s.sub_status
     , a1.soc AS "PP", s1.soc_description AS "PP_DESC"
     , a2.soc AS "SOC", s2.soc_description AS "SOC_DESC"
     , a2.effective_date
  FROM subscriber s, service_agreement a1, service_agreement a2, soc s1, soc s2
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND RTRIM(a1.soc)   IN ( 'PVJA', 'PVJC', 'PVJD', 'PVJE' )
   AND RTRIM(a1.soc)    = RTRIM(s1.soc)
   AND SYSDATE    BETWEEN s1.effective_date AND NVL(s1.expiration_date, NVL(s1.sale_exp_date, SYSDATE + 1))
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND RTRIM(a2.soc)   IN ( 'SPVOC02EU' )
   AND RTRIM(a2.soc)    = RTRIM(s2.soc)
   AND SYSDATE    BETWEEN s2.effective_date AND NVL(s2.expiration_date, NVL(s2.sale_exp_date, SYSDATE + 1))
--   AND ROWNUM < 11
;

