/*
**
** Schedule xxx of the paused records to be processed at a specific time
**
*/
UPDATE master_transactions a
  SET a.request_time    = TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI')
    , a.process_status  = 'WAITING'
--    , a.stream          = DECODE(MOD(SUBSTR(a.subscriber_no, 4), 10) + 1, null, 1, MOD(SUBSTR(a.subscriber_no, 4), 10) + 1)
    , a.priority        = a.priority + 1
 WHERE 1                = 1
   AND a.process_status = 'IN_PROGRESS'
   AND a.request_id     = 'STLI15 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') 
   AND ROWNUM           < 50001
;


/*
**
** Display the number of records scheduled for future processing, and when.
**
*/
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME",
       TO_NUMBER(a.stream) AS "STREAM", a.action_code, a.soc, a.process_status,
       COUNT(*) AS "COUNT"
  FROM master_transactions a
 WHERE a.process_status = 'WAITING'
   AND a.request_id     = 'STLI15 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') 
   AND a.request_time   >  SYSDATE
GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), TO_NUMBER(a.stream), a.action_code, a.soc, a.process_status
ORDER BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), TO_NUMBER(a.stream), a.action_code, a.soc, a.process_status
;


/*
**
** Display the number of processed records per MINUTE since the job was requested.
**
*/
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME", a.process_status, COUNT(1) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id         = 'STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') 
   and a.request_time      >= TO_DATE(TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI')
   AND a.process_time BETWEEN TO_DATE(TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI') AND SYSDATE
GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), a.process_status
ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), a.process_status
;


/*
**
** Display the number of processed records per HOUR since the job was requested.
**
*/
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59' AS "PROCESS_TIME", a.process_status, COUNT(1) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id         = 'STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') 
   AND a.request_time      >= TO_DATE(TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI')
   AND a.process_time BETWEEN TO_DATE(TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI') AND SYSDATE
GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59', a.process_status
ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59', a.process_status
;
