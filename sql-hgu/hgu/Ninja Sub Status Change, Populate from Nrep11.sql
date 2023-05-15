INSERT INTO ninja_sub_change_status
SELECT /*+DRIVING_SITE(a)*/
       0               AS "TRANS_NUMBER",
       a.subscriber_no AS "SUBSCRIBER_NO",
       'CANCEL'        AS "ACTION_CODE",
       'MARV'          AS "DEALER_CODE",
       'Cancelling remaining Chess prepaid subscription. RIP.' AS "MEMO_TEXT",
       'PPC'           AS "REASON_CODE",
       NULL            AS "FEE_WAIVER_CODE",
       NULL            AS "ENTER_TIME",
       TRUNC(SYSDATE) +  160/240                  AS "REQUEST_TIME", -- 16:00 today...
       4               AS "PRIORITY",
       NULL            AS "PROCESS_TIME",
       'WAITING'       AS "PROCESS_STATUS",
       NULL            AS "STATUS_DESC",
       'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_REFERENCE_ID",
       'N'             AS "RELEASE_CTN",
       'N'             AS "PREPAID_USER",
       --MOD(a.subscriber_no, 3) + 1              AS "HLR_STREAM",
       MOD(ROWNUM, 3) + 1              AS "HLR_STREAM",
       s.sub_status    AS "CURRENT_STATUS"
  FROM service_agreement@nrep11 a, subscriber@nrep11 s
 WHERE RTRIM(a.soc)   IN ( 'PVHG', 'PVHR' )
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.subscriber_no = s.subscriber_no
   AND a.ban           = s.customer_id
   AND s.sub_status    = 'A'
   AND ROWNUM          < (10000 + 1)
;

-- Using ROWNUM did not work during insert, but it works now...
UPDATE ninja_sub_change_status a
   SET a.hlr_stream = MOD(ROWNUM, 3) + 1
 WHERE a.request_reference_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
;

COMMIT WORK
;

SELECT a.action_code, a.reason_code, a.hlr_stream
     , TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME", COUNT(1) AS "COUNT"
     , a.process_status
  FROM ninja_sub_change_status a
 WHERE a.request_reference_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY a.action_code, a.reason_code, a.hlr_stream, TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.process_status
ORDER BY 1,2,3,4,5
;


