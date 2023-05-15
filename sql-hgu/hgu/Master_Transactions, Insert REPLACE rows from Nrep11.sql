/*
** Insert rows...
*/
INSERT INTO master_transactions
SELECT NULL        AS "TRANS_NUMBER"
     , a.subscriber_no
     , a.soc
     , 'REPLACE'   AS "ACTION_CODE"
     , 'SPVOC06EU' AS "NEW_SOC"
     , NULL        AS "ENTER_TIME"
     , TO_DATE('2020-10-01 00:01', 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME"
     , NULL        AS "PROCESS_TIME"
     , 'IN_PROGRESS'   AS "PROCESS_STATUS"
     , NULL        AS "STATUS_DESC"
     , 'SP06'      AS "DEALER_CODE"
     , 'A'         AS "SALES_AGENT"
     , 1           AS "PRIORITY"
     , 'HGU 2020-10-01' AS "REQUEST_ID"
     , 'Per request from Chilimobil/Thomas Refsdal (via email at 2020-09-22 13:07)' AS "MEMO_TEXT"
     , NULL        AS "WAIVE_ACT_FEE"
--     , 69          AS "STREAM"
     , NULL        AS "STREAM" -- SUBSTR(a.ban, LENGTH(a.ban)) + 1 AS "STREAM"
  FROM tmp_msisdns_w_status_pp_soc@nrep11 a
-- WHERE ROWNUM < 2
;

SELECT a.soc, a.action_code, a.new_soc, a.stream, a.request_time, COUNT(1) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id = 'HGU 2020-10-01'
GROUP BY a.soc, a.action_code, a.new_soc, a.stream, a.request_time
ORDER BY a.soc, a.action_code, a.new_soc, TO_NUMBER(a.stream), a.request_time
;

SELECT n.price_plan, p.sp_priceplan_code AS "SPM_TYPE"
     , t.soc,     m1.sp_code AS "SPM_OLD_SERVICE"
     , t.new_soc, m2.sp_code AS "SPM_NEW_SERVICE"
     , t.request_time, t.process_status, COUNT(1) AS "COUNT"
  FROM tmp_msisdns_w_status_pp_soc@nrep11 n
     , master_transactions                t
     , spm_priceplan_mapping              p
     , spm_service_mapping                m1
     , spm_service_mapping                m2
     , socs                               s1
     , socs                               s2
 WHERE t.request_id         = 'HGU 2020-10-01'
   AND n.subscriber_no      = t.subscriber_no
   AND n.price_plan         = p.soc_code
   AND t.soc                = s1.soc
   AND s1.soc_type          = m1.soc_type
   AND s1.soc_group         = m1.soc_group
   AND t.new_soc            = s2.soc
   AND s2.soc_type          = m2.soc_type
   AND s2.soc_group         = m2.soc_group
GROUP BY n.price_plan, p.sp_priceplan_code, t.soc, m1.sp_code, t.new_soc, m2.sp_code, t.request_time, t.process_status
ORDER BY n.price_plan, p.sp_priceplan_code, t.soc, m1.sp_code, t.new_soc, m2.sp_code, t.request_time, t.process_status
;
