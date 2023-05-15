/*
** List an overview of the requests sent from Prepaid/Kontant.
** @Including process_time
*/
SELECT TO_CHAR(a.enter_time,   'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME"
     , TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59' AS "PROCESS_TIME"
     , a.request_reference_id, a.action_code, a.reason_code, a.prepaid_user
     , a.hlr_stream, a.release_ctn, a.process_status, COUNT(1) AS "COUNT"
  FROM ninja_sub_change_status a
 WHERE 1 = 1
   AND a.request_reference_id IN ('STLI15')
   AND a.enter_time            > TRUNC(SYSDATE)
GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59', TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59', a.request_reference_id, a.action_code, a.reason_code, a.prepaid_user, a.hlr_stream, a.release_ctn, a.process_status
ORDER BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59', TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59', a.request_reference_id, a.action_code, a.reason_code, a.prepaid_user, a.hlr_stream, a.release_ctn, a.process_status
;

/*
** List an overview of the requests sent from Prepaid/Kontant.
*/
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME"
     , a.request_reference_id, a.action_code, a.reason_code, a.prepaid_user
     , a.hlr_stream, a.release_ctn, a.process_status, COUNT(1) AS "COUNT"
  FROM ninja_sub_change_status a
 WHERE 1 = 1
   AND a.request_reference_id IN ('STLI15')
--   AND a.enter_time            > TRUNC(SYSDATE - 1)
GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59', a.request_reference_id, a.action_code, a.reason_code, a.prepaid_user, a.hlr_stream, a.release_ctn, a.process_status
ORDER BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59', a.request_reference_id, a.action_code, a.reason_code, a.prepaid_user, a.hlr_stream, a.release_ctn, a.process_status
;

/*
** List all columns for the failed records from Prepaid/Kontant.
*/
SELECT a.trans_number, a.subscriber_no, a.action_code, a.dealer_code,
       a.memo_text, a.reason_code, a.fee_waiver_code, a.enter_time,
       a.request_time, a.priority, a.process_time, a.process_status,
       a.status_desc, a.request_reference_id, a.release_ctn,
       a.prepaid_user, a.hlr_stream, a.current_status
  FROM ninja_sub_change_status a
 WHERE a.request_reference_id IN ('STLI15')
   AND a.process_status = 'PRSD_ERROR'
;

/*
** List the first and last process_time's for each day.
*/
SELECT TO_CHAR(a.enter_time,        'YYYY-MM-DD')         AS "ENTER_TIME"
     , TO_CHAR(MAX(a.process_time), 'YYYY-MM-DD HH24:MI') AS "MAX_PROCESS_TIME"
     , TO_CHAR(MIN(a.process_time), 'YYYY-MM-DD HH24:MI') AS "MIN_PROCESS_TIME"
  FROM ninja_sub_change_status a
 WHERE 1 = 1
   AND a.request_reference_id IN ('STLI15')
   AND a.enter_time > TRUNC(SYSDATE - 1)
--GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD'), TO_CHAR(MAX(a.process_time), 'YYYY-MM-DD HH24:MI'), TO_CHAR(MIN(a.process_time), 'YYYY-MM-DD HH24:MI')
ORDER BY "ENTER_TIME"
;

SELECT a.*
  FROM ninja_sub_change_status a
 WHERE a.process_time IN (
   SELECT MAX(b.process_time)
     FROM ninja_sub_change_status b
    WHERE b.request_reference_id IN ('STLI15')
      AND b.enter_time > TRUNC(SYSDATE)
  )
;

SELECT COUNT(1) AS "COUNT"
  FROM ninja_sub_change_status a
 WHERE a.request_reference_id = 'STLI15'
   AND a.enter_time           > TRUNC(SYSDATE)
   AND a.process_status       = 'PRSD_ERROR'
   AND a.status_desc   NOT LIKE '%Cancellation okay but failed to override aging%'
;
