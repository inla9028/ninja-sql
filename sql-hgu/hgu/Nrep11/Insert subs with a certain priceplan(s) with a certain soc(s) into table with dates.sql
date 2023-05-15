delete
  from tmp_msisdns_w_status_pp_soc_dt
;

--CREATE table tmp_msisdns_w_status_pp_soc_dt
--AS
INSERT INTO tmp_msisdns_w_status_pp_soc_dt
SELECT s.subscriber_no
     , s.customer_id AS "BAN"
     , s.sub_status
     , RTRIM(a1.soc) AS "PRICE_PLAN"
     , RTRIM(a2.soc) AS "SOC"
     , a2.sys_creation_date AS "EFFECTIVE_DATE"
     , a2.expiration_date
  FROM subscriber s, service_agreement a1, service_agreement a2 
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   --
   AND RTRIM(a1.soc)   IN ( 'PVJB' )
--   AND a1.service_type  = 'P'
   --
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
--
--   AND a2.service_type  = 'R'
--   AND RTRIM(a2.soc)    = 'SPVOC08EU'
--   AND a2.soc        LIKE 'SPAPN01%'
   AND RTRIM(a2.soc)   IN ( 'MPODV17', 'SPVOC68', 'SPVOC69', 'SPVOC70', 'SPVOC71', 'SPVOC72', 'SPVOC73', 'SPVOC74' ) 

--
--   AND NVL(a2.expiration_date, SYSDATE) BETWEEN TO_DATE('2030', 'YYYY') AND TO_DATE('4000', 'YYYY') 
--   AND ROWNUM < 11
;

COMMIT WORK;

SELECT a.price_plan, a.sub_status, a.soc, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc_dt a
GROUP BY a.price_plan, a.soc, a.sub_status
ORDER BY a.price_plan, a.soc, a.sub_status
;

