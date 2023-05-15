SELECT a.request_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.049) /   3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*)   * 0.049) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_bans_activity a
 WHERE a.record_creation_date > TRUNC(SYSDATE)
GROUP BY a.request_id, a.process_status
ORDER BY 1,2
;

SELECT a.stream, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.049) /   3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*)   * 0.049) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_bans_activity a
 WHERE a.request_id IN ( 'JHO 2018-08-07', 'JHO2 2018-08-07', 'JHO3 2018-08-07' )
GROUP BY a.stream, a.process_status
ORDER BY TO_NUMBER(a.stream), a.process_status
;

SELECT a.request_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.049) /   3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*)   * 0.049) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_bans_activity a
 WHERE a.request_id IN ( 'JHO 2018-08-07', 'JHO2 2018-08-07', 'JHO3 2018-08-07' )
GROUP BY a.request_id, a.process_status
ORDER BY a.request_id, a.process_status
;

SELECT a.ban_no, a.action, SUBSTR(RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))), INSTR(a.status_desc, ' ') + 1) AS "STATUS_DESC"
  FROM batch_bans_activity a
  WHERE a.request_id     IN ( 'JHO 2018-08-07', 'JHO2 2018-08-07', 'JHO3 2018-08-07' )
    AND a.process_status  = 'PRSD_ERROR'
ORDER BY 1,2
;



SELECT a.transaction_number, a.ban_no, a.action, a.reason_code,
       a.activity_date, a.memo_text, a.request_id, a.process_status,
       a.process_time, a.status_desc, a.record_creation_date, a.stream
  FROM batch_bans_activity a
 WHERE a.process_status = 'PRSD_ERROR'
   AND a.record_creation_date > trunc(SYSDATE)
;

SELECT a.process_status, count(1) AS "COUNT"
  FROM batch_bans_activity a
 WHERE a.record_creation_date > trunc(SYSDATE)
GROUP BY a.process_status
ORDER BY 1
;

SELECT a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.049) /   3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*)   * 0.049) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_bans_activity a
 WHERE a.record_creation_date > TRUNC(SYSDATE)
GROUP BY a.process_status
ORDER BY 1
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_bans_activity a
      WHERE a.record_creation_date > trunc(SYSDATE)
        AND a.process_status      != 'WAITING'
        AND a.process_time   BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

