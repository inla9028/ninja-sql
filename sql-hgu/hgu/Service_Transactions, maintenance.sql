--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Count how many waiting, separate on priority.
--== The value 2.xx is calculated in a script further down.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, a.priority, COUNT(*) as "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 6.818) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 6.818) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.service_transactions a
  WHERE a.process_status = 'WAITING'
  GROUP BY a.process_status, a.priority
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Count how many waiting, don't separate on priority.
--== The value 3.xx is calculated in a script further down.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) as "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 6.818) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 6.818) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.service_transactions a
  WHERE a.process_status = 'WAITING'
  GROUP BY a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the socs and commands currently waiting...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, a.action_code, a.priority, COUNT(*) as "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 6.818) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 6.818) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM ninjadata.service_transactions a
  WHERE a.process_status = 'WAITING'
  GROUP BY a.soc, a.action_code, a.priority
  ORDER BY "COUNT" desc, a.priority, a.soc, a.action_code
--  ORDER BY a.soc, a.action_code, a.priority
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the rows currently waiting per subscriber --==--==--==--==--==--==--==-
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, COUNT(*) AS COUNT
  FROM ninjadata.service_transactions a
  WHERE a.process_status = 'WAITING'
  GROUP BY a.subscriber_no
  ORDER BY COUNT desc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the data from the rows currently waiting --==--==--==--==--==--==--==--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.success_msg_id, a.error_msg_id, a.msg_status_desc,
       a.next_action_code, a.next_action_argument
  FROM ninjadata.service_transactions a
  WHERE a.process_status = 'WAITING'
  ORDER BY a.priority, a.request_time, a.trans_number
--  ORDER BY a.subscriber_no, a.soc, a.enter_time
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the rows added today --==--==--==--==--==--==--==--==--==--==--==--==--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, COUNT(*) AS COUNT, SYSDATE AS "WHEN"
  FROM ninjadata.service_transactions a
  WHERE a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.subscriber_no
  ORDER BY COUNT desc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get a specific subscriber --==--==--==--==--==--==--==--==--==--==--==--==-
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.success_msg_id, a.error_msg_id, a.msg_status_desc,
       a.next_action_code, a.next_action_argument
  FROM ninjadata.service_transactions a
  WHERE a.subscriber_no IN ('GSM047' || '90599373')
--    AND a.enter_time > TRUNC(SYSDATE)
  ORDER BY a.subscriber_no, a.enter_time, a.request_time, a.soc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the number of similar operations per subscriber --==--==--==--==--==--=
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT * FROM (
  SELECT a.subscriber_no, a.soc, a.action_code, COUNT(*) AS count
    FROM ninjadata.service_transactions a
    WHERE a.process_status = 'WAITING'
    GROUP BY a.subscriber_no, a.soc, a.action_code
) WHERE COUNT > 1
  ORDER BY COUNT desc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display duplicates --==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--SELECT a.subscriber_no, a.soc, a.action_code, a.process_time, a.process_status, a.status_desc
SELECT a.trans_number, a.enter_time, a.subscriber_no, a.soc, a.action_code, a.process_time, a.process_status, a.status_desc, b.trans_number AS "TRANS_NR_DUPL", b.enter_time AS "ENTER_TIME_DUPL"
  FROM ninjadata.service_transactions a, ninjadata.service_transactions b
  WHERE a.process_status = b.process_status
    AND b.process_status = 'WAITING'
    AND a.subscriber_no  = b.subscriber_no
    AND a.soc            = b.soc
    AND a.action_code    = b.action_code
    AND a.trans_number   < b.trans_number
--    AND a.enter_time     < b.enter_time
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Remove duplicates by changing the status of all but the last request --==--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.service_transactions x
  SET x.process_status = 'TRANSFER', x.process_time = SYSDATE,
      x.status_desc = 'DUPLICATE ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
  WHERE x.process_status = 'WAITING'
    AND x.trans_number IN (
    SELECT a.trans_number
      FROM ninjadata.service_transactions a, ninjadata.service_transactions b
      WHERE a.process_status = b.process_status
        AND b.process_status = 'WAITING'
        AND a.subscriber_no  = b.subscriber_no
        AND a.soc            = b.soc
        AND a.action_code    = b.action_code
        AND a.trans_number   < b.trans_number
        AND a.enter_time     < b.enter_time
)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the last processed --==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.success_msg_id, a.error_msg_id, a.msg_status_desc,
       a.next_action_code, a.next_action_argument
  FROM ninjadata.service_transactions a
  WHERE a.process_status NOT IN ('WAITING')
    AND a.process_time > SYSDATE - 0.01
  ORDER BY a.process_time
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute (today). -==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME",
       COUNT(*) AS "COUNT"
  FROM ninjadata.service_transactions a
  WHERE a.process_time > TRUNC(SYSDATE)
  GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY "PROCESS_TIME"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute
--== for the last 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(LTRIM(TO_CHAR(AVG("COUNT"), '9999999.999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999.999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME", COUNT(*) AS "COUNT"
      FROM ninjadata.service_transactions a
--      WHERE a.process_time > TRUNC(SYSDATE)
      WHERE a.process_status != 'WAITING'
        AND a.process_time    > (SYSDATE - (15 / 1440))
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average time between a record was added until it was
--== processed, for the current day (since midnight).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT COUNT(*) AS "Processed Records",
       LTRIM(TO_CHAR(ROUND(AVG("SECS") / 60), '9999999')) || ' min ' ||
       LTRIM(TO_CHAR(ROUND(MOD(AVG("SECS"), 60)), '9999999')) || ' seconds' AS "Average Delay"
  FROM (
    SELECT a.enter_time, a.process_time,
           TO_NUMBER(LTRIM(TO_CHAR((24 * 60 * 60) * TO_NUMBER(a.process_time - a.enter_time), '9999999.999'))) AS "SECS"
      FROM ninjadata.service_transactions a
      WHERE a.process_status != 'WAITING'
        AND a.enter_time      > TRUNC(SYSDATE)
)
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time (minutes) the currently waiting records were inserted.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24:MI') AS "ENTER_TIME",
       COUNT(*) AS "COUNT"
  FROM ninjadata.service_transactions a
  WHERE a.process_status = 'WAITING'
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24:MI')
  ORDER BY "ENTER_TIME"
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time (hours) the currently waiting records were inserted.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59' AS "ENTER_TIME",
       COUNT(*) AS "COUNT"
  FROM ninjadata.service_transactions a
  WHERE a.process_status = 'WAITING'
  GROUP BY TO_CHAR(a.enter_time, 'YYYY-MM-DD HH24') || ':00-59'
  ORDER BY "ENTER_TIME"
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the processed after a specific time, that was in queue for so and so long --==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.success_msg_id, a.error_msg_id, a.msg_status_desc,
       a.next_action_code, a.next_action_argument
  FROM ninjadata.service_transactions a
  WHERE a.process_status NOT IN ('WAITING')
    AND a.request_time > TO_DATE('2006-07-25 23:59','YYYY-MM-DD HH24:MI')
    AND a.request_time < a.process_time - 0.04 -- 0.1 = 2.4 Hrs, 0.01 = 0.24 Hrs ~ 14 min
  ORDER BY a.request_time, a.process_time
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display 1 record that took exactly 2 hours, from req to process --==--==--=
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT * FROM (
  SELECT *
    FROM ninjadata.service_transactions a
    WHERE a.process_status = 'PRSD_SUCCESS'
      AND a.request_time   > TO_DATE('2006-07-25 08:00','YYYY-MM-DD HH24:MI')
      AND trunc(a.request_time + 0.042, 'MI') = TRUNC(a.process_time, 'MI')
    ORDER BY a.request_time, a.process_time
) WHERE ROWNUM = 1
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Count how many records that were processed in the mean-time --==--==--==--=
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT COUNT(*) AS COUNT
  FROM ninjadata.service_transactions a, ninjadata.service_transactions b
  WHERE b.trans_number = 1339700
    AND a.process_time BETWEEN b.request_time AND b.process_time
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Set the currently waiting to a temporary status --==--==--==--==--==--==--=
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.service_transactions x
  SET x.process_status = 'TRANSFER', 
      x.status_desc    = 'TRANSFER 2007.01.15', 
      x.process_time   = SYSDATE
  WHERE x.process_status = 'WAITING'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Change the priority of all entries --==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.service_transactions x
  SET x.priority = 4
  WHERE x.process_status = 'WAITING'
    AND x.priority       = 3
    AND x.soc IN ('ODB1', 'ODB12', 'GPRSPRE', 'GPRSVSK')
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the statistics of the current day, separating on priority =--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, a.priority, COUNT(*) COUNT, SYSDATE AS WHEN
  FROM ninjadata.service_transactions a
  WHERE a.enter_time > TRUNC(SYSDATE)
  GROUP BY a.process_status, a.priority
  ORDER BY a.priority, a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== 
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.service_transactions b
  SET b.priority = '4'
  WHERE b.process_status = 'WAITING'
    AND b.subscriber_no IN (
SELECT subscriber_no
  FROM (
    SELECT a.subscriber_no, COUNT(*) AS COUNT
    FROM ninjadata.service_transactions a
    WHERE a.process_status = 'WAITING'
    GROUP BY a.subscriber_no
  ) WHERE COUNT = 1
)
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Set the stream based on the subscriber no...
--xxx
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
-- DECODE(mod(update_row.subscriber_no,10)+2,null,1,mod(update_row.subscriber_no,10)+2)
SELECT a.subscriber_no,
       SUBSTR(a.subscriber_no, 4) AS "SUB_STR", 
       DECODE(MOD(SUBSTR(a.subscriber_no, 4), 10) + 2, null, 1, MOD(SUBSTR(a.subscriber_no, 4), 10) + 2) AS "MOD_NUM"
  FROM ninjadata.service_transactions a
  WHERE a.trans_number = 2399373
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.trans_number, a.subscriber_no, a.soc, a.action_code,
       a.enter_time, a.request_time, a.process_time, a.process_status,
       a.status_desc, a.dealer_code, a.sales_agent, a.priority,
       a.success_msg_id, a.error_msg_id, a.msg_status_desc,
       a.next_action_code, a.next_action_argument
  FROM ninjadata.service_transactions a
  WHERE a.process_time > TO_DATE('20070115 16:14', 'YYYYMMDD HH24:MI')
    AND a.process_status NOT IN ('TRANSFER')
;


