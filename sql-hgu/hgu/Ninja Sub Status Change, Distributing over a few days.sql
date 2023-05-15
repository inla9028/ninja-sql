/*
** List what we have to work with...
*/
SELECT a.action_code, a.reason_code, a.hlr_stream
     , TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME", COUNT(1) AS "COUNT"
     , a.process_status
  FROM ninja_sub_change_status a
 WHERE a.request_reference_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY a.action_code, a.reason_code, a.hlr_stream, TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.process_status
ORDER BY 1,2,3,4,5
;

/*
** Change the request time in bulks of 15000.
*/
UPDATE ninja_sub_change_status a
   SET a.request_time = a.request_time + TRUNC(ROWNUM / 15001)
 WHERE a.request_reference_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
;

/*
** Change the reference id according to the date.
*/
UPDATE ninja_sub_change_status a
   SET a.request_reference_id = 'HGU ' || TO_CHAR(a.request_time, 'YYYY-MM-DD')
 WHERE a.request_reference_id = 'HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
;

/*
** List what we have accomplished.
*/
SELECT a.request_reference_id, a.action_code, a.reason_code, a.hlr_stream
     , TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME", COUNT(1) AS "COUNT"
     , a.process_status
  FROM ninja_sub_change_status a
 WHERE a.request_time            > SYSDATE
   AND a.request_reference_id LIKE 'HGU%'
GROUP BY a.request_reference_id, a.action_code, a.reason_code, a.hlr_stream, TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.process_status
ORDER BY 1,2,3,4,5,6
;


