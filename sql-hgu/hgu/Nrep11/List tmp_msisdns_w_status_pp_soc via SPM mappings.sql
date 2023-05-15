SELECT a.soc, m.sp_code, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc@nrep11 a, spm_service_mapping m, socs s
 WHERE a.soc       = s.soc
   AND s.soc_type  = m.soc_type(+)
   AND s.soc_group = m.soc_group(+)
GROUP BY a.soc, m.sp_code
ORDER BY a.soc, m.sp_code
;

SELECT a.price_plan, p.sp_priceplan_code, a.soc, m.sp_code, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc@nrep11 a, spm_priceplan_mapping p, spm_service_mapping m, socs s
 WHERE a.soc        = s.soc
   AND s.soc_type   = m.soc_type(+)
   AND s.soc_group  = m.soc_group(+)
   AND a.price_plan = p.soc_code(+)
GROUP BY a.price_plan, p.sp_priceplan_code, a.soc, m.sp_code
ORDER BY a.price_plan, p.sp_priceplan_code, a.soc, m.sp_code
;

SELECT a.subscriber_no, a.ban, a.sub_status, a.price_plan, a.soc, m.sp_code, a.effective_date
  FROM tmp_msisdns_w_status_pp_soc@nrep11 a, spm_service_mapping m, socs s
 WHERE a.soc       = s.soc(+)
   AND s.soc_type  = m.soc_type
   AND s.soc_group = m.soc_group
ORDER BY a.soc, a.sub_status, a.subscriber_no
;

SELECT a.subscriber_no, a.sub_status, a.price_plan, p.sp_priceplan_code, a.soc, m.sp_code, a.effective_date
  FROM tmp_msisdns_w_status_pp_soc@nrep11 a, spm_priceplan_mapping p, spm_service_mapping m, socs s
 WHERE a.soc        = s.soc(+)
   AND s.soc_type   = m.soc_type
   AND s.soc_group  = m.soc_group
   AND a.price_plan = p.soc_code
--   AND a.subscriber_no = 'GSM047'||'95988692'
   AND ROWNUM       < 11
ORDER BY p.sp_priceplan_code, a.soc, m.sp_code, a.subscriber_no
;

--
-- List an overview of all subscriptions, grouped, with SPM mappings....
--
with nrep AS (
    SELECT /*+ driving_site(a)*/ a.price_plan, a.sub_status, a.soc, COUNT(1) AS "SRV_COUNT"
      FROM tmp_msisdns_w_status_pp_soc@nrep11 a
    GROUP BY a.price_plan, a.soc, a.sub_status
    ORDER BY a.sub_status, a.price_plan, a.soc
)
select n.price_plan
     , p.sp_priceplan_code AS "SPM_TYPE"
     , DECODE(n.sub_status, 'A', 'Active', 'R', 'Reserved', 'S', 'Suspended', n.sub_status) AS "SUB_STATUS"
     , n.soc
     , m.sp_code           AS "SPM_SERVICE"
     , n.srv_count         AS "COUNT"
  from nrep                  n
     , spm_priceplan_mapping p
     , spm_service_mapping   m
     , socs                  s
 where n.soc         = s.soc(+)
   AND s.soc_type    = m.soc_type
   AND s.soc_group   = m.soc_group
   AND n.price_plan  = p.soc_code
--   AND n.subscriber_no = 'GSM047'||'95988692'
--   AND ROWNUM       < 11
order by 1,3,4
;

--
-- List all subscriptions with a readable status and SPM mappings....
--
SELECT a.subscriber_no
     , DECODE(a.sub_status, 'A', 'Active', 'R', 'Reserved', 'S', 'Suspended', a.sub_status) AS "SUB_STATUS"
     , a.price_plan
     , p.sp_priceplan_code AS "SPM_TYPE"
     , a.soc
     , m.sp_code           AS "SPM_SERVICE"
     , a.effective_date
  FROM tmp_msisdns_w_status_pp_soc@nrep11 a, spm_priceplan_mapping p, spm_service_mapping m, socs s
 WHERE a.soc         = s.soc(+)
   AND s.soc_type    = m.soc_type
   AND s.soc_group   = m.soc_group
   AND a.price_plan  = p.soc_code
--   AND a.subscriber_no = 'GSM047'||'95988692'
--   AND ROWNUM       < 11
ORDER BY 4, 1, 6
;

--
-- List all subscriptions with a readable status and SPM and old SP mappings....
--
SELECT a.subscriber_no
     , DECODE(a.sub_status, 'A', 'Active', 'R', 'Reserved', 'S', 'Suspended', a.sub_status) AS "SUB_STATUS"
     , a.price_plan
     , p.sp_priceplan_code AS "SPM_TYPE"
     , a.soc
     , m.sp_code           AS "SPM_SERVICE"
     , sp.sp_service_code  AS "SP_PROVSERV_SERVICE"
     , a.effective_date
  FROM tmp_msisdns_w_status_pp_soc@nrep11 a
     , spm_priceplan_mapping              p
     , spm_service_mapping                m
     , socs                               s
     , sp_services_mapping                sp
 WHERE a.soc         = s.soc(+)
   AND s.soc_type    = m.soc_type
   AND s.soc_group   = m.soc_group
   AND s.soc_type    = sp.soc_type(+)
   AND s.soc_group   = sp.soc_group(+)
   AND a.price_plan  = p.soc_code
--   AND a.subscriber_no IN ( 'GSM047'||'580008987842', 'GSM047'||'580008989579' )
--   AND ROWNUM       < 101
ORDER BY 4, 1, 6
;
