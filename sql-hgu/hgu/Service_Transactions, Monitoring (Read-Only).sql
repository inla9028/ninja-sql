--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time (minutes) the currently waiting records were inserted.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
   SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24:MI') AS "ENTER_TIME",
          COUNT(*) AS "COUNT",
          TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.236) / 3600), '9999999'))) || ' hours ' ||
          TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.236) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
     FROM ninjadata.service_transactions a
    WHERE a.process_status = 'WAITING'
 GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24:MI')
 ORDER BY "ENTER_TIME"
 ;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time (hours) the currently waiting records were inserted.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME",
       COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.236) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.236) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.service_transactions a
  WHERE a.process_status = 'WAITING'
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59'
  ORDER BY "ENTER_TIME";


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of currently waiting records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.236) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.236) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.service_transactions a
  WHERE a.process_status = 'WAITING';


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the waiting queue, with respect to the socs, actions & priorities.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  SELECT a.soc, a.action_code, a.priority, COUNT(*) AS "COUNT",
         TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.236) / 3600), '9999999'))) || ' hours ' ||
         TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.236) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
    FROM ninjadata.service_transactions a
   WHERE a.process_status = 'WAITING'
GROUP BY a.soc, a.action_code, a.priority
ORDER BY a.priority, a.soc, a.action_code
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time (hours) today's records were inserted.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME",
         COUNT(*) AS "COUNT"
    FROM ninjadata.service_transactions a
   WHERE a.enter_time > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59'
ORDER BY "ENTER_TIME"
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display requestor's for today's records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT NVL(a.dealer_code, '(N/A)') AS "DEALER_CODE",
       NVL(a.sales_agent, '(N/A)') AS "SALES_AGENT",
       a.soc, s.description, COUNT(*) AS "COUNT"
  FROM ninjadata.service_transactions a, ninjarules.socs_descriptions s
 WHERE 1 = 1
   AND a.enter_time > TRUNC(SYSDATE)
   AND a.soc = s.soc
   AND s.language_code = 'NO'
GROUP BY NVL(a.dealer_code, '(N/A)'), NVL(a.sales_agent, '(N/A)'), a.soc, s.description
ORDER BY NVL(a.dealer_code, '(N/A)'), NVL(a.sales_agent, '(N/A)'), a.soc, s.description
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time (hours) and amount of records that were inserted
--== within a specific interval.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME",
       COUNT(*) AS "COUNT"
  FROM ninjadata.service_transactions a
--  WHERE a.enter_time BETWEEN TO_DATE('2009-11-20 00:00', 'YYYY-MM-DD HH24:MI')
--                         AND TO_DATE('2009-11-21 00:00', 'YYYY-MM-DD HH24:MI')
--  WHERE a.enter_time BETWEEN TRUNC(SYSDATE, 'HH24') AND SYSDATE
  WHERE a.enter_time BETWEEN TRUNC(SYSDATE - 1) AND SYSDATE                         
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59'
  ORDER BY "ENTER_TIME";


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of added records per day.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD') AS "ENTER_TIME",
       COUNT(*) AS "COUNT"
  FROM ninjadata.service_transactions a
--  FROM ninjadata.arch_service_transactions a
--  WHERE a.enter_time > TO_DATE('2008-09-08', 'YYYY-MM-DD')
  WHERE a.enter_time > TRUNC(SYSDATE - 14)
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD')
  ORDER BY "ENTER_TIME";


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the socs, actions & priorities for the socs for the last XX days.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, a.action_code, a.priority, COUNT(*) AS "COUNT"
--     , TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.236) / 3600), '9999999'))) || ' hours ' ||
--       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.236) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.service_transactions a
--  WHERE a.enter_time > TO_DATE('2008-09-08', 'YYYY-MM-DD')
  WHERE a.enter_time > TRUNC(SYSDATE - 14)
--  WHERE a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.soc, a.action_code, a.priority
  ORDER BY a.soc, a.priority, a.action_code;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the non-regular errors
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   a.*
    FROM ninjadata.service_transactions a
   WHERE a.enter_time > TRUNC (SYSDATE - 2)
     AND a.process_status = 'PRSD_ERROR'
     AND (a.status_desc NOT LIKE '%does not have the soc%'
       AND a.status_desc NOT LIKE '%already has the soc%'
--      AND a.status_desc NOT LIKE '%%'
--      AND a.status_desc NOT LIKE '%%'
       AND a.status_desc NOT LIKE '%is Non Active%')
ORDER BY a.enter_time, a.process_time


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute, today or yesterday
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME",
       COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.236) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.236) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.service_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time      > TRUNC(SYSDATE - 1)
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY "PROCESS_TIME";


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per hour, today or yesterday
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59' AS "PROCESS_TIME",
         COUNT(*) AS "COUNT",
         TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.236) / 3600), '9999999'))) || ' hours ' ||
         TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.236) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
    FROM ninjadata.service_transactions a
   WHERE a.process_status != 'WAITING'
    -- AND a.enter_time > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
     AND a.enter_time > TRUNC(SYSDATE - 1)
GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24') || ':00-59'
ORDER BY "PROCESS_TIME"
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
      FROM ninjadata.service_transactions a
     WHERE a.enter_time   > TRUNC(SYSDATE - 3) -- This column is indexed, and in case we have a huge backlog...
       AND a.process_time BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the average time (in seconds) a record had to wait after insert 
--== until it was processed.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT   "ENTER_TIME",
         COUNT(*) AS "COUNT",
         TO_NUMBER (LTRIM (TO_CHAR (AVG ("DURATION"), '9999999.99')))     AS "AVG_DURATION"
    FROM (SELECT    TO_CHAR (a.enter_time, 'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME",
                 24 * 60 * 60 * (a.process_time - a.request_time)         AS "DURATION"
            FROM service_transactions a
           --WHERE a.enter_time > TRUNC(SYSDATE - 1/2, 'HH') -- Last 24 hours.
           --WHERE a.enter_time > TRUNC(SYSDATE)
           WHERE a.enter_time > LEAST(TRUNC(SYSDATE), TRUNC(SYSDATE - 1/2, 'HH'))
             AND a.process_status != 'WAITING')
GROUP BY "ENTER_TIME"
ORDER BY "ENTER_TIME";

