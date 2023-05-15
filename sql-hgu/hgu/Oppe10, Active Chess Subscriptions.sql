/*
**
** Warning, these scripts takes about 15 minutes to execute.
**
*/

SELECT ba.account_type, ba.account_sub_type, RTRIM(sa.soc) AS "PRICEPLAN", COUNT(1) AS "COUNT"
  FROM billing_account ba, subscriber s, service_agreement sa
 WHERE (ba.account_type = 'S' AND ba.account_sub_type IN ('CH', 'C2')
     OR ba.account_type = 'H' AND ba.account_sub_type IN ('CC', 'PC'))
   AND ba.ban_status    = 'O'
   AND ba.ban           = s.customer_id
   AND s.sub_status     = 'A'
   AND sa.ban           = s.customer_id
   AND sa.subscriber_no = s.subscriber_no
   AND SYSDATE BETWEEN sa.effective_date AND NVL(sa.expiration_date , SYSDATE + 1)
   AND sa.service_type  = 'P'
GROUP BY ba.account_type, ba.account_sub_type, RTRIM(sa.soc)
ORDER BY 1, 2, 3
;

--

SELECT ba.account_type, ba.account_sub_type, RTRIM(sa.soc) AS "PRICEPLAN"
    , sc.soc_description, COUNT(1) AS "COUNT"
  FROM billing_account ba, subscriber s, service_agreement sa, DATA_NO.soc sc
 WHERE (ba.account_type = 'S' AND ba.account_sub_type IN ('CH', 'C2')
     OR ba.account_type = 'H' AND ba.account_sub_type IN ('CC', 'PC'))
   AND ba.ban_status    = 'O'
   AND ba.ban           = s.customer_id
   AND s.sub_status     = 'A'
   AND sa.ban           = s.customer_id
   AND sa.subscriber_no = s.subscriber_no
   AND TO_DATE('2015-12-31', 'YYYY-MM-DD') BETWEEN sa.effective_date AND NVL(sa.expiration_date , SYSDATE + 1)
   AND sa.service_type  = 'P'
   AND RTRIM(sa.soc)    = RTRIM(sc.soc)
   AND SYSDATE          < NVL(sc.expiration_date, SYSDATE + 1) 
GROUP BY ba.account_type, ba.account_sub_type, RTRIM(sa.soc), sc.soc_description
ORDER BY 1, 2, 3
;

SELECT s.*
  FROM DATA_NO.soc s
;

SELECT a.*
  FROM all_tables a
 WHERE a.table_name LIKE '%SOC%'
