DELETE
  FROM tmp_msisdns_w_status_pp_soc
;

--CREATE table tmp_msisdns_w_status_pp_soc
--AS
INSERT INTO tmp_msisdns_w_status_pp_soc
SELECT s.subscriber_no
     , s.customer_id AS "BAN"
     , s.sub_status
     , RTRIM(a1.soc) AS "PRICE_PLAN"
     , RTRIM(a2.soc) AS "SOC"
     , a2.sys_creation_date as EFFECTIVE_DATE
  FROM subscriber s, service_agreement a1, service_agreement a2 
 WHERE s.sub_status     IN ( 'A', 'R', 'S')
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   --
--   AND rtrim(a1.soc)   IN ( 'PVEC', 'PVEE', 'PVEF', 'PW30' )
--   AND rtrim(a1.soc)   IN ( 'PVKA' )
   AND a1.soc        LIKE 'PVJ%'
   AND a1.service_type  = 'P'
   --
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
--
   AND a2.service_type  = 'R'
--   AND RTRIM(a2.soc)    = 'DATAVHH'
--   AND RTRIM(a2.soc)   IN ( 'HPVMS01', 'HPVMS02', 'VMACC02' )
   AND a2.soc        LIKE 'SPVOC74%'
--
--   AND ROWNUM < 11
;

COMMIT WORK;

SELECT a.price_plan, a.sub_status, a.soc, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc a
GROUP BY a.price_plan, a.soc, a.sub_status
ORDER BY a.price_plan, a.soc, a.sub_status
;

