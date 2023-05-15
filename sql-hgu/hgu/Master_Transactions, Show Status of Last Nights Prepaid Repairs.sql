/*
**
** List the errors from last nights records.
**
*/
SELECT a.soc, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC", COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
 WHERE a.request_id         = 'STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD')
   AND a.process_status     = 'PRSD_ERROR'
   AND a.request_time      >= TO_DATE(TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI')
   AND a.process_time BETWEEN TO_DATE(TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') || ' 21:09', 'YYYY-MM-DD HH24:MI') AND SYSDATE
GROUP BY a.soc, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')))
ORDER BY a.soc, "COUNT" DESC, "STATUS_DESC"
;

/*
**
** Display the socs processed per hour.
**
*/
SELECT TO_CHAR(NVL(a.process_time, a.request_time), 'YYYY-MM-DD HH24') || ':00-59' AS "PROCESS_TIME",
       a.soc, a.process_status, COUNT(1) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id = 'STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD')
GROUP BY TO_CHAR(NVL(a.process_time, a.request_time), 'YYYY-MM-DD HH24') || ':00-59', a.soc, a.process_status
ORDER BY a.process_status, "PROCESS_TIME", a.soc
;

/*
**
** List the requested (future?) process times...
**
*/
SELECT TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME", a.soc, a.process_status, COUNT(*) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id IN ('STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD'), 'STLI15 ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD'))
   AND a.request_time > TRUNC(SYSDATE)
GROUP BY TO_CHAR(a.request_time, 'YYYY-MM-DD HH24:MI'), a.soc, a.process_status
ORDER BY "REQUEST_TIME", a.soc, a.process_status;

/*
**
** List an overview of the errors from last night.
**
*/
SELECT a.soc, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC", COUNT(*) AS "COUNT"
  FROM master_transactions a
 WHERE a.request_id = 'STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD')
   AND a.process_status = 'PRSD_ERROR'
GROUP BY a.soc, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')))
ORDER BY a.soc, "COUNT" DESC, "STATUS_DESC"
;

/*
**
** List the detailed errors - the ones that matters.
**
*/
SELECT a.subscriber_no, a.action_code, a.soc,
       SUBSTR(RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))), INSTR(a.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM master_transactions a
 WHERE a.request_id = 'STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD')
   AND a.process_status = 'PRSD_ERROR'
   AND (a.status_desc NOT LIKE '%SOC is already on subscription%')
ORDER BY a.soc, "STATUS_DESC", a.subscriber_no
;

/*
SELECT a.*
  FROM master_transactions a
 WHERE a.request_id     = 'STLI15 ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD')
   AND a.process_status = 'PRSD_ERROR'
   AND a.request_time      >= TO_DATE(TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') || ' 21:10', 'YYYY-MM-DD HH24:MI')
   AND a.process_time BETWEEN TO_DATE(TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD') || ' 21:09', 'YYYY-MM-DD HH24:MI') AND SYSDATE
   AND a.status_desc LIKE '%Too many%'
;

SELECT a.*
  FROM service_agreement@fokus a
 WHERE a.subscriber_no = 'GSM04798099801'
   AND SYSDATE BETWEEN a.effective_date AND nvl(a.expiration_date, SYSDATE + 1)
ORDER BY soc
;

SELECT a.*
  FROM service_feature@fokus a
 WHERE a.subscriber_no = 'GSM04798099801'
   AND SYSDATE BETWEEN a.ftr_effective_date AND nvl(a.ftr_expiration_date, SYSDATE + 1)
ORDER BY soc
;

*/
