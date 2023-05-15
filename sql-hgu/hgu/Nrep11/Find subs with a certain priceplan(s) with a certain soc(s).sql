SELECT s.subscriber_no, s.customer_id, s.sub_status, a1.soc AS "PP", a2.soc AS "SOC", a2.effective_date
  FROM subscriber s, service_agreement a1, service_agreement a2 
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc           = 'PW21'
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND a2.soc        LIKE 'HPTSP01%'
--   AND ROWNUM < 11
;
/*
Row #   SUBSCRIBER_NO   CUSTOMER_ID SUB_STATUS  PP          VOLTE       EFFECTIVE_DATE
-----   --------------  ----------- ----------  ---------   ---------   --------------
1       GSM04747729467  407716315   A           PW10        IMS01       2018-06-07    
2       GSM04740441822  294996319   A           PW10        IMS01       2018-06-07    
3       GSM04746907088  838948313   A           PW10        IMS01       2018-06-07    
4       GSM04748194550  294996319   A           PW10        IMS01       2018-06-08    
5       GSM04748131000  294996319   A           PW10        IMS01       2018-06-07    
6       GSM04790063025  294996319   A           PW10        IMS01       2018-06-08    
7       GSM04747482275  294996319   A           PW10        IMS01       2018-06-07    
8       GSM04741325787  644007312   A           PW10        IMS01       2018-06-07    
9       GSM04740433865  199408311   A           PW10        IMS01       2018-06-07    
10      GSM04740407149  189728314   A           PW10        IMS01       2018-06-07    
*/

SELECT a1.soc AS "PP", a2.soc AS "SOC", COUNT(1) AS "COUNT"
  FROM subscriber s, service_agreement a1, service_agreement a2 
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
--   AND a1.soc        LIKE 'PV%'
   AND a1.service_type  = 'P'
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND a2.soc        LIKE 'HPTSP01%'
GROUP BY a1.soc, a2.soc
ORDER BY 1, 2
;

SELECT RTRIM(a1.soc) AS "PP", s1.soc_description, RTRIM(a2.soc) AS "SOC", s2.soc_description, COUNT(1) AS "COUNT"
  FROM subscriber s, service_agreement a1, service_agreement a2, soc s1, soc s2
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.soc        LIKE 'PV%'
   AND a1.service_type  = 'P'
   AND RTRIM(a1.soc)    = RTRIM(s1.soc)
   AND SYSDATE    BETWEEN s1.effective_date AND NVL(s1.expiration_date, SYSDATE + 1)
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND a2.soc        LIKE 'VMS%'
   AND RTRIM(a2.soc)    = RTRIM(s2.soc)
   AND SYSDATE    BETWEEN s2.effective_date AND NVL(s2.expiration_date, SYSDATE + 1)
GROUP BY RTRIM(a1.soc), s1.soc_description, RTRIM(a2.soc), s2.soc_description
ORDER BY 1, 3
;

