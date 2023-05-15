SELECT /*+ driving_site(s)*/
       s.subscriber_no, s.customer_id, s.sub_status
     , a1.soc AS "PP",   a1.campaign, a1.effective_date AS "PP_DATE"
     , a2.soc AS "SOC1", a2.effective_date AS "SOC1_DATE"
     , a3.soc AS "SOC2", a3.effective_date AS "SOC2_DATE"
  FROM subscriber@fokus s, service_agreement@fokus a1, service_agreement@fokus a2, service_agreement@fokus a3 
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.service_type  = 'P'
   --AND a1.soc        LIKE 'PPEN%'
   and a1.campaign      = '000000000'
   --
   AND s.customer_id    = a2.ban
   AND s.subscriber_no  = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND a2.service_type  = 'G'
   --AND a2.soc        LIKE 'LOPFLX01%'
   --
   AND s.customer_id    = a3.ban
   AND s.subscriber_no  = a3.subscriber_no
   AND SYSDATE    BETWEEN a3.effective_date AND NVL(a3.expiration_date, SYSDATE + 1)
   AND a3.service_type  = 'G'
   --AND a3.soc        LIKE 'LOPFLX01%'
   --
   AND a2.soc           = a3.soc
   AND a2.soc_seq_no   != a3.soc_seq_no
   AND ROWNUM < 11
;

/*
GSM04740102815	408510014	A	PPEK     	000000000	2020-05-04 00:00	LOPFLX01 	2020-01-20 00:00	LOPFLX01 	2020-01-20 00:00
GSM04740102815	408510014	A	PPEK     	000000000	2020-05-04 00:00	LOPFLX01 	2020-01-20 00:00	LOPFLX01 	2020-01-20 00:00
GSM04745510514	560806416	A	PPEN     	000000000	2019-05-29 00:00	LOPFLX01 	2020-05-05 00:00	LOPFLX01 	2020-05-05 00:00
GSM04745510514	560806416	A	PPEN     	000000000	2019-05-29 00:00	LOPFLX01 	2020-05-05 00:00	LOPFLX01 	2020-05-05 00:00
GSM04799419899	344242219	A	PPEN     	000000000	2019-05-28 00:00	LOPFLX01 	2020-05-04 00:00	LOPFLX01 	2020-05-04 00:00
GSM04799419899	344242219	A	PPEN     	000000000	2019-05-28 00:00	LOPFLX01 	2020-05-04 00:00	LOPFLX01 	2020-05-04 00:00
GSM04748507613	110797412	A	PSEM     	000000000	2019-05-05 00:00	LOBFLX01 	2019-05-05 00:00	LOBFLX01 	2020-05-06 00:00
GSM04748405584	137497418	A	PPEO     	000000000	2019-03-09 00:00	LOPTF1   	2019-03-23 00:00	LOPTF1   	2020-04-21 00:00
GSM04748405584	137497418	A	PPEO     	000000000	2019-03-09 00:00	LOPTF1   	2020-04-21 00:00	LOPTF1   	2019-03-23 00:00
GSM04748507613	110797412	A	PSEM     	000000000	2019-05-05 00:00	LOBFLX01 	2020-05-06 00:00	LOBFLX01 	2019-05-05 00:00
*/

SELECT /*+ driving_site(s)*/
       s.subscriber_no, s.customer_id, s.sub_status
     , a1.soc AS "PP",   a1.campaign, a1.effective_date AS "PP_DATE"
     , a2.soc AS "SOC1", a2.effective_date AS "SOC1_DATE"
     , a3.soc AS "SOC2", a3.effective_date AS "SOC2_DATE"
  FROM subscriber@fokus s, service_agreement@fokus a1, service_agreement@fokus a2, service_agreement@fokus a3
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.service_type  = 'P'
   --AND a1.soc        LIKE 'PPEN%'
   and a1.campaign      = '000000000'
   --
   AND s.customer_id    = a2.ban
   AND s.subscriber_no  = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND a2.service_type  = 'G'
   --AND a2.soc        LIKE 'LOPFLX01%'
   --
   AND s.customer_id    = a3.ban
   AND s.subscriber_no  = a3.subscriber_no
   AND SYSDATE    BETWEEN a3.effective_date AND NVL(a3.expiration_date, SYSDATE + 1)
   AND a3.service_type  = 'G'
   --AND a3.soc        LIKE 'LOPFLX01%'
   --
   AND a2.soc           = a3.soc
   AND a2.soc_seq_no   != a3.soc_seq_no
   --
   AND 0 = (SELECT COUNT(1)
              FROM service_agreement@fokus sax
             WHERE s.customer_id    = sax.ban
               AND s.subscriber_no  = sax.subscriber_no
               AND SYSDATE    BETWEEN sax.effective_date AND NVL(sax.expiration_date, SYSDATE + 1)
               AND sax.service_type = 'G'
               AND sax.soc         != a2.soc)
   AND ROWNUM < 11
;
/*
GSM04745510514	560806416	A	PPEN     	000000000	2019-05-29 00:00	LOPFLX01 	2020-05-05 00:00	LOPFLX01 	2020-05-05 00:00
GSM04745510514	560806416	A	PPEN     	000000000	2019-05-29 00:00	LOPFLX01 	2020-05-05 00:00	LOPFLX01 	2020-05-05 00:00
GSM04799419899	344242219	A	PPEN     	000000000	2019-05-28 00:00	LOPFLX01 	2020-05-04 00:00	LOPFLX01 	2020-05-04 00:00
GSM04799419899	344242219	A	PPEN     	000000000	2019-05-28 00:00	LOPFLX01 	2020-05-04 00:00	LOPFLX01 	2020-05-04 00:00
GSM04748507613	110797412	A	PSEM     	000000000	2019-05-05 00:00	LOBFLX01 	2019-05-05 00:00	LOBFLX01 	2020-05-06 00:00
GSM04748405584	137497418	A	PPEO     	000000000	2019-03-09 00:00	LOPTF1   	2019-03-23 00:00	LOPTF1   	2020-04-21 00:00
GSM04748405584	137497418	A	PPEO     	000000000	2019-03-09 00:00	LOPTF1   	2020-04-21 00:00	LOPTF1   	2019-03-23 00:00
GSM04748507613	110797412	A	PSEM     	000000000	2019-05-05 00:00	LOBFLX01 	2020-05-06 00:00	LOBFLX01 	2019-05-05 00:00
*/