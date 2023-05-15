/*
** List the number of queued rows.
*/
SELECT COUNT(1) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.531) / 3600),   '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*)   * 0.531) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM dsp_request rq
 WHERE rq.process_status = 'WAITING'
;

/*
** Calculate the number of processed records during the last 15 minutes.
*/
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"),      '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM dsp_request a
     WHERE a.process_status       = 'PRSD_SUCCESS'
       AND a.record_creation_date > TRUNC(SYSDATE - 7)
       AND a.process_time   BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);
