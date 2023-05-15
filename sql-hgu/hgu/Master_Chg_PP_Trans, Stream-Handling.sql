/*
** Distribute records onto 10 streams instead of just one...
*/
UPDATE master_chg_pp_trans a
   SET a.stream = MOD(ROWNUM, 10) + 1 -- Displays even 1-10
   --SET a.stream = MOD(ROWNUM, 9) + 2 -- Displays even 2-10, leaving stream 1 free
 WHERE a.requestor_id   IN ( 'CKH' )
   AND a.process_status IN ( 'WAITING', 'IN_PROGRESS', 'ON_HOLD' )
   AND a.stream          = '1'
;

/*
** Assign records on a given stream(s) to another stream.
*/
UPDATE master_chg_pp_trans a
   SET a.stream = '1'
 WHERE a.requestor_id   IN ( 'CKH' )
   AND a.process_status IN ( 'WAITING', 'IN_PROGRESS', 'ON_HOLD' )
   AND a.stream         IN ( '4' )
;


/*
** Display the remaining (aka WAITING) records per stream.
*/
SELECT a.requestor_id, a.stream, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 4.648) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 4.648) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM master_chg_pp_trans a
 WHERE a.requestor_id IN ('CKH')
   AND a.process_status = 'WAITING'
GROUP BY a.requestor_id, a.stream, a.process_status
ORDER BY a.requestor_id, TO_NUMBER(a.stream), a.process_status
;

/*
** Calculate the average number of processed records per minute, for the last
** 15 minutes (to be used within the SQL above as "seconds per row").
*/
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM master_chg_pp_trans a
     WHERE 1 = 1
       AND a.process_time BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
       --AND a.requestor_id      IN ('CKH')
       --AND a.process_status    != 'WAITING'
    GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
    ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

