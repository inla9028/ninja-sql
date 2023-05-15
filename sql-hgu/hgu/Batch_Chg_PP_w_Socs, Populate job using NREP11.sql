select p.*
  from batch_change_priceplan p
  where rownum < 11
;

INSERT INTO batch_change_priceplan
SELECT UNIQUE a.subscriber_no
     , a.price_plan   AS "OLD_PRICEPLAN"
     , 'PVJB'         AS "NEW_PRICEPLAN"
     , '000000000'    AS "NEW_CAMPAIGN_CODE"
     , 'PVJB'||'REG1' AS "NEW_SUBSCRIPTION_TYPE"
     , 'K'            AS "HANDLE_COMMITMENT"
     , 'MPODV17'      AS "SOCS_TO_ADD"
     , 'MPODV18'      AS "SOCS_TO_DELETE"
     , NULL           AS "EFFECTIVE_DATE"
     , 'SP06'         AS "DEALER"
     , 'A'            AS "SALES_AGENT"
     , 'VS01'         AS "REASON_CODE"
     , 'Requested by Geir Ove Jenssen <geir.ove.jenssen@chilimobil.no> via email at 2020-06-05 15:06' AS "MEMO_TEXT"
     , 'Y'            AS "WAIVE_FEES"
     , NULL           AS "ENTER_TIME"
     , NULL           AS "REQUEST_TIME"
     , NULL           AS "PROCESS_TIME"
     , 'ON_HOLD'      AS "PROCESS_STATUS"
     , NULL           AS "STATUS_DESC"
    , 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUESTOR_ID"
    , 'Y'             AS "SKIP_NINJA_VALIDATION"
    , 'N'             AS "SEPARATE_SAVES"
  FROM tmp_msisdns_w_status_pp_soc@nrep11 a
 WHERE RTRIM(a.soc)   IN ( 'SPVOC09EU', 'SPVOC12EU' )
   AND a.sub_status   IN ( 'A' )
   -- AND ROWNUM          < (10 + 1)
;

SELECT a.requestor_id, a.new_priceplan, a.request_time, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 8.933) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 8.933) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_change_priceplan a
 WHERE a.requestor_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY a.requestor_id, a.new_priceplan, a.request_time, a.process_status
ORDER BY a.requestor_id, a.new_priceplan, a.request_time, a.process_status
;

--
-- Start the job and perhaps at a certain time?
--
UPDATE batch_change_priceplan a
   SET a.process_status = 'WAITING',
       a.request_time   = TO_DATE('2020-06-09 00:00', 'YYYY-MM-DD HH24:MI')
 WHERE a.requestor_id   = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.process_status = 'ON_HOLD'
;
