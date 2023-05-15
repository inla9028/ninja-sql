DELETE
  FROM tmp_msisdns_w_status_pp
;

--CREATE table tmp_msisdns_w_status_pp
--AS
INSERT INTO tmp_msisdns_w_status_pp
SELECT s.subscriber_no
     , s.customer_id AS "BAN"
     , s.sub_status
     , RTRIM(a1.soc) AS "PRICE_PLAN"
     , a1.effective_date
  FROM subscriber s, service_agreement a1
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   --
   AND a1.service_type  = 'P'
   AND a1.soc        LIKE 'PW2%'
--   AND RTRIM(a1.soc)   IN ( 'PVEC', 'PVEE', 'PVEF', 'PW30' )
   --
--   AND s.dealer_code    = 'NWCO' -- TMP
--   AND ROWNUM < 11
;

COMMIT WORK;

SELECT a.price_plan, a.sub_status, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp a
GROUP BY a.price_plan, a.sub_status
ORDER BY a.price_plan, a.sub_status
;

/*
SELECT a.price_plan, RTRIM(s.soc_description) AS "SOC_DESC", a.sub_status, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp a, soc s
 WHERE a.price_plan  = RTRIM(s.soc)
   AND SYSDATE BETWEEN s.effective_date AND NVL(s.expiration_date, SYSDATE + 1)
GROUP BY a.price_plan, RTRIM(s.soc_description), a.sub_status
ORDER BY 1, 2, 3
;
*/

/*
SELECT price_plan AS "PRICEPLAN_IN_FOKUS"
     , DECODE(price_plan
         , 'PW20', 'VOICE'
         , 'PW21', 'FWA'
         , 'PW22', 'FWA_B2B'
         , price_plan ) AS "SPM_TYPE"
     , DECODE(sub_status
         , 'A', 'Aktiv'
         , 'S', 'Suspendert'
         , sub_status) AS "SUBSCRIPTION_STATUS"
     , NR_OF_SUBS
 FROM (
    SELECT a.price_plan
         , a.sub_status
         , COUNT(1) AS "NR_OF_SUBS"
      FROM tmp_msisdns_w_status_pp a
    GROUP BY a.price_plan, a.sub_status
    ORDER BY a.price_plan, a.sub_status
);
*/
