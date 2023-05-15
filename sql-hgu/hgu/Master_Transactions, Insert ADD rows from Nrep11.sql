/*
** Add a certain SOC to the subscriptions in Nrep11 without the SOC.
*/

/*
** Insert rows...
*/
INSERT INTO master_transactions
SELECT NULL        AS "TRANS_NUMBER"
     , a.subscriber_no
     , 'IMSVS'     AS "SOC"
     , 'ADD'       AS "ACTION_CODE"
     , NULL        AS "NEW_SOC"
     , NULL        AS "ENTER_TIME"
     --
     , SYSDATE     AS "REQUEST_TIME"
--     , TO_DATE('2020-02-01 00:01', 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME"
--     , TRUNC(SYSDATE + 1) + 1/48 AS "REQUEST_TIME"
     --
     , NULL        AS "PROCESS_TIME"
     , 'WAITING'   AS "PROCESS_STATUS"
     , NULL        AS "STATUS_DESC"
     , 'SP06'      AS "DEALER_CODE"
     , 'A'         AS "SALES_AGENT"
     , 1           AS "PRIORITY"
     , 'HGU 2020-03-10' AS "REQUEST_ID"
     , 'Per request from Chilimobil/Trond Stryken (via email at 2020-03-05 12:00)' AS "MEMO_TEXT"
     , NULL        AS "WAIVE_ACT_FEE"
--     , 69          AS "STREAM"
     , SUBSTR(a.ban, LENGTH(a.ban)) + 1 AS "STREAM"
  FROM (SELECT /*+ driving_site(b)*/ b.subscriber_no, b.ban
          FROM tmp_msisdns_w_status_pp_soc@nrep11 b
         WHERE b.price_plan IN ( 'PVJA', 'PVJD' )
           AND 0             = (SELECT COUNT(1)
                                  FROM tmp_msisdns_w_status_pp_soc@nrep11 c
                                 WHERE c.subscriber_no = b.subscriber_no
                                   AND c.soc           = 'IMSVS')
        GROUP BY b.subscriber_no, b.ban) a
 WHERE ROWNUM < 5001       
;

SELECT a.request_id, a.soc, a.action_code, a.stream, a.request_time, COUNT(1) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id IN ( 'HGU 2020-03-05', 'HGU 2020-03-07', 'HGU 2020-03-10' )
GROUP BY a.request_id, a.soc, a.action_code, a.stream, a.request_time
ORDER BY a.request_id, a.soc, a.action_code, TO_NUMBER(a.stream), a.request_time
;


SELECT a.request_id, a.soc, a.action_code, a.request_time, a.process_status, COUNT(1) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id IN ( 'HGU 2020-03-05', 'HGU 2020-03-07', 'HGU 2020-03-10' )
GROUP BY a.request_id, a.soc, a.action_code, a.request_time, a.process_status
ORDER BY 1,2,3,4,5
;

SELECT a.request_id, a.soc, a.action_code, a.process_status, COUNT(1) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id IN ( 'HGU 2020-03-05', 'HGU 2020-03-07', 'HGU 2020-03-10' )
GROUP BY a.request_id, a.soc, a.action_code, a.process_status
ORDER BY 1,2,3,4
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
 WHERE t.request_id        IN ( 'HGU 2020-03-05', 'HGU 2020-03-07', 'HGU 2020-03-10' )
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
