/*
** Display an overview of the records added today..
*/
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME",
       a.soc, a.process_status, COUNT(*) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id = 'STLI15 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.soc, a.process_status
ORDER BY "REQUEST_TIME", a.soc, a.process_status
;

/*
** Display an overview of the records added yesterday (processed?) and today..
*/
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME",
       a.soc, a.process_status, COUNT(*) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id IN ('STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD'), 'STLI15 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD'))
GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.soc, a.process_status
ORDER BY "REQUEST_TIME", a.soc, a.process_status
;

