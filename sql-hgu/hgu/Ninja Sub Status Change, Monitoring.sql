SELECT a.trans_number, a.subscriber_no, a.action_code, a.dealer_code,
       a.memo_text, a.reason_code, a.fee_waiver_code, a.enter_time,
       a.request_time, a.priority, a.process_time, a.process_status,
       a.status_desc, a.request_reference_id, a.release_ctn,
       a.prepaid_user, a.hlr_stream, a.current_status
  FROM ninja_sub_change_status a
  WHERE a.request_reference_id IN ('mala2150')
    AND a.process_status = 'PRSD_ERROR'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records currently waiting
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_reference_id, a.action_code, a.process_status, a.prepaid_user,
       a.hlr_stream, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.294) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.294) / 60, 60),  '9999999'))) || ' min' AS "QUEUE"
  FROM ninja_sub_change_status a
  WHERE a.process_status = 'WAITING'
     OR a.request_time > TRUNC(SYSDATE) 
  GROUP BY a.request_reference_id, a.action_code, a.process_status, a.prepaid_user, a.hlr_stream
  ORDER BY a.request_reference_id, a.action_code, a.process_status, a.prepaid_user, a.hlr_stream
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records currently waiting, including start-date.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_reference_id, a.action_code, a.process_status, a.prepaid_user,
       a.hlr_stream, TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME", COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.294) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.294) / 60, 60),  '9999999'))) || ' min' AS "QUEUE"
  FROM ninja_sub_change_status a
 WHERE a.process_status = 'WAITING'
    OR a.request_time > TRUNC(SYSDATE) 
GROUP BY a.request_reference_id, a.action_code, a.process_status, a.prepaid_user, a.hlr_stream, TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI')
ORDER BY 1,2,3,4,5,6
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records currently waiting for a specific request id.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.action_code, a.process_status, a.prepaid_user, a.hlr_stream,
       COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.294) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.294) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninja_sub_change_status a
  WHERE a.request_reference_id IN ('mala2150')
--    AND a.enter_time > TRUNC(SYSDATE - 1)
  GROUP BY a.action_code, a.process_status, a.prepaid_user, a.hlr_stream
  ORDER BY a.action_code, a.process_status, a.prepaid_user, a.hlr_stream
;

SELECT a.request_reference_id, a.action_code, a.process_status, a.hlr_stream, a.request_time, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.294) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.294) / 60, 60),  '9999999'))) || ' min' AS "QUEUE"
  FROM ninja_sub_change_status a
 WHERE a.request_reference_id IN ('mala2150')
GROUP BY a.request_reference_id, a.action_code, a.process_status, a.hlr_stream, a.request_time
ORDER BY a.request_reference_id, a.action_code, a.process_status, a.hlr_stream, a.request_time
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records for a specific request id.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code, /*a.reason_code, */a.process_status,
       REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (a.status_desc,
                           0,
                           INSTR (a.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (a.status_desc,
                               0,
                               INSTR (a.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM ninja_sub_change_status a
  WHERE a.request_reference_id IN ('mala2150')
    AND a.process_status       = 'PRSD_ERROR'
    AND a.request_time         > TRUNC(SYSDATE)
  ORDER BY "STATUS_DESC", a.subscriber_no
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display when the records were processed for a specific request id.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME",
       COUNT(*) AS "COUNT"
  FROM ninja_sub_change_status a
  WHERE a.request_reference_id IN ('mala2150')
    AND a.process_status       = 'PRSD_SUCCESS'
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY "PROCESS_TIME"
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Postpone all jobs for the current request until a given date and time.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninja_sub_change_status a
   SET a.request_time = TO_DATE('2011-08-15 21:01', 'YYYY-MM-DD HH24:MI')
   WHERE a.request_reference_id IN ('mala2150')
     AND a.process_status       = 'WAITING'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Reschedule...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninja_sub_change_status a
   SET a.request_time         = TRUNC(SYSDATE) +  15/24 -- 15:00 today...
     , a.process_status       = 'WAITING'
     , a.process_time         = NULL
     , a.status_desc          = NULL
 WHERE a.request_reference_id IN ('mala2150')
   AND a.process_status       = 'PRSD_ERROR'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display (all) the future request_time(s) for a given request id.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME",
       a.action_code, COUNT(*) AS "COUNT"
  FROM ninja_sub_change_status a
  WHERE a.request_reference_id IN ('mala2150')
    AND a.request_time > SYSDATE
  GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.action_code
  ORDER BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.action_code
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time (hours) the currently waiting records were inserted.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME",
       COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.294) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.294) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninja_sub_change_status a
  WHERE a.process_status = 'WAITING'
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59'
  ORDER BY "ENTER_TIME"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time (hours) today's records were inserted.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME",
       COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*)     * 0.294) / 3600,    '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.294) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninja_sub_change_status a
  WHERE a.enter_time > TRUNC(SYSDATE)
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59'
  ORDER BY "ENTER_TIME"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute
--== for the last 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninja_sub_change_status a
      WHERE a.enter_time     > TRUNC(SYSDATE - 7)
        AND a.process_status IN ( 'PRSD_SUCCESS', 'PRSD_ERROR' )
        AND a.process_time   BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
--        AND a.process_time   > TRUNC(SYSDATE)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records for a specified day/interval.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.action_code AS "ACTION", /*a.memo_text,*/ a.reason_code AS "REASON", a.enter_time,
       a.priority AS "PRIO", a.request_reference_id AS "REQ_REF_ID", a.process_time, a.process_status,
       RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninja_sub_change_status a
  WHERE a.enter_time BETWEEN TO_DATE('2012-10-30', 'YYYY-MM-DD')
                         AND TO_DATE('2012-10-31', 'YYYY-MM-DD')
  ORDER BY a.trans_number
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute
--== for a specified day/interval.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM ninja_sub_change_status a
--      WHERE a.enter_time BETWEEN TO_DATE('2009-08-26', 'YYYY-MM-DD')
--                             AND TO_DATE('2009-08-27', 'YYYY-MM-DD')
      WHERE a.enter_time BETWEEN TRUNC(SYSDATE - 1) AND SYSDATE
        AND a.process_status IN ( 'PRSD_SUCCESS', 'PRSD_ERROR' )
        AND a.process_time    > (SYSDATE - (5 / 1440))
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)
;
