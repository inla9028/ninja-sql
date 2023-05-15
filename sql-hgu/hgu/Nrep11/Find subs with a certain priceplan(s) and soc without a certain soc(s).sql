DELETE
  FROM tmp_msisdns_w_status_pp_soc
;

--CREATE table tmp_msisdns_w_status_pp_soc
--AS
-- INSERT INTO tmp_msisdns_w_status_pp_soc
/*
SELECT s.subscriber_no, s.customer_id AS "BAN", s.sub_status
     , RTRIM(a1.soc) AS "PRICE_PLAN", RTRIM(a2.soc) AS "VOICEMAIL"
     , a2.effective_date
  FROM subscriber@nrep11 s
    , service_agreement@nrep11 a1
    , service_agreement@nrep11 a2 
 WHERE s.sub_status     = 'A'
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
   AND a1.service_type  = 'P'
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   AND a2.soc           = 'VMACC02'
   AND 0                = (SELECT COUNT(1)
                             FROM service_agreement@nrep11 a3
                            WHERE a3.ban = a2.ban
                              AND a3.subscriber_no = a2.subscriber_no
                              AND a3.soc           = 'MBNU01'
                              AND SYSDATE    BETWEEN a3.effective_date AND NVL(a3.expiration_date, SYSDATE + 1))
ORDER BY 1,2
;
*/

--CREATE table tmp_msisdns_w_status_pp_soc
--AS
INSERT INTO tmp_msisdns_w_status_pp_soc
SELECT s.subscriber_no
     , s.customer_id   AS "BAN"
     , s.sub_status
     , RTRIM(a1.soc)   AS "PRICE_PLAN"
     , RTRIM(a2.soc)   AS "SOC"
     , a2.effective_date
  FROM subscriber s, service_agreement a1, service_agreement a2 
 WHERE s.sub_status    IN ( 'A', 'R', 'S' )
--   AND s.dealer_code    = 'NWCO' -- When looking for a particular SP or similar
   AND s.customer_id    = a1.ban
   AND s.subscriber_no  = a1.subscriber_no
   AND SYSDATE    BETWEEN a1.effective_date AND NVL(a1.expiration_date, SYSDATE + 1)
--   AND a1.soc          IN ( 'PVJA', 'PVJD' )
   AND a1.soc        LIKE 'PPFL%'
   AND a1.ban           = a2.ban
   AND a1.subscriber_no = a2.subscriber_no
   AND SYSDATE    BETWEEN a2.effective_date AND NVL(a2.expiration_date, SYSDATE + 1)
   --
--   AND a2.service_type  IN ( 'P', 'R' ) -- Get the priceplan as well. Easier to get an overview then...
--   AND a2.service_type  = 'R'
--   AND a2.soc        LIKE 'ODBWSMS%'
   AND rtrim(a2.soc)   IN ( 'NTSLPPFL', 'NGCHPPFL', 'PPFL' )
--   AND ROWNUM < 11
;

COMMIT WORK;

SELECT a.price_plan, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc a
GROUP BY a.price_plan
ORDER BY 1
;

SELECT b.price_plan, COUNT(1) AS "COUNT"
  FROM (SELECT a.subscriber_no, a.price_plan
          FROM tmp_msisdns_w_status_pp_soc a
        GROUP BY a.subscriber_no, a.price_plan) b
GROUP BY b.price_plan
ORDER BY 1
;

SELECT a.price_plan, a.soc, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc a
-- WHERE a.soc = 'IMSVS'
GROUP BY a.price_plan, a.soc
ORDER BY 1, 2
;

-- List all subscriptions with a certain SOC that doesn't have another set of SOCs
select a1.*
  from tmp_msisdns_w_status_pp_soc a1
 where a1.soc = 'HPAPN01'
   and 0      = (select COUNT(1)
                   from tmp_msisdns_w_status_pp_soc a2
                  where a2.subscriber_no = a1.subscriber_no
                    and a2.soc          IN ( 'HPAPN02', 'HPAPN03', 'HPAPN04', 'HPAPN05' ))
order by a1.subscriber_no
;

-- Delete all rows for socs that are not the priceplan or a set of SOCs.
delete
  from tmp_msisdns_w_status_pp_soc a
 where a.soc != a.price_plan
   and a.soc NOT IN ( 'ODBWSMS' )
;

-- List all subscriptions without a certain set of SOCs
with my_filter as (
  select unique a1.subscriber_no, a1.ban, a1.sub_status, a1.price_plan
    from tmp_msisdns_w_status_pp_soc a1
)
select mf.*
  from my_filter mf
 where 0      = (select COUNT(1)
                   from tmp_msisdns_w_status_pp_soc a2
                  where a2.subscriber_no = mf.subscriber_no
                    and a2.soc          IN ( 'ODBWSMS' ))
order by mf.subscriber_no
;






