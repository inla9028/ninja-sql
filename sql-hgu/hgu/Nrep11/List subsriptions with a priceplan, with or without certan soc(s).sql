WITH my_filter AS (
    SELECT s.subscriber_no
         , s.customer_id   AS "BAN"
         , s.sub_status
         , RTRIM(a1.soc)   AS "PRICE_PLAN"
         , RTRIM(a2.soc)   AS "SOC"
         , a2.effective_date
      FROM subscriber        s
         , service_agreement a1
         , service_agreement a2 
     WHERE s.sub_status     = 'A'
       AND s.customer_id    = a1.ban
       AND s.subscriber_no  = a1.subscriber_no
       AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
--       AND RTRIM(a1.soc)   IN ( 'PVJA', 'PVJD' )
       AND a1.soc        LIKE 'PW20%'
       AND a1.ban           = a2.ban
       AND a1.subscriber_no = a2.subscriber_no
       AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
       --
       AND a2.service_type  = 'R'
       AND a2.soc        LIKE 'HPAPN0%'
--       AND RTRIM(a2.soc)   IN ( 'HPAPN01', 'HPAPN02', 'HPAPN03', 'HPAPN04', 'HPAPN05' )
)
SELECT mf1.*
  FROM my_filter mf1
 WHERE mf1.soc = 'HPAPN01'
   AND 0       = (SELECT COUNT(1)
                    FROM my_filter mf2
                   WHERE mf2.subscriber_no = mf1.subscriber_no
                     AND mf2.soc          IN ( 'HPAPN02', 'HPAPN03', 'HPAPN04', 'HPAPN05' ))
ORDER BY mf1.subscriber_no
;

--
WITH my_filter AS (
    SELECT s.subscriber_no
         , s.customer_id   AS "BAN"
         , s.sub_status
         , RTRIM(a1.soc)   AS "PRICE_PLAN"
         , RTRIM(a2.soc)   AS "SOC"
         , a2.effective_date
      FROM subscriber        s
         , service_agreement a1
         , service_agreement a2 
     WHERE s.sub_status     = 'A'
       AND s.customer_id    = a1.ban
       AND s.subscriber_no  = a1.subscriber_no
       AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
       AND a1.soc        LIKE 'PW20%'
       AND a1.ban           = a2.ban
       AND a1.subscriber_no = a2.subscriber_no
       AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
       --
       AND a2.service_type  = 'R')
SELECT UNIQUE mf1.subscriber_no, mf1.ban, mf1.sub_status, mf1.price_plan
  FROM my_filter mf1
 WHERE 0       = (SELECT COUNT(1)
                    FROM my_filter mf2
                   WHERE mf2.subscriber_no = mf1.subscriber_no
                     AND mf2.soc        LIKE 'HPAPN0%')
ORDER BY mf1.subscriber_no
;