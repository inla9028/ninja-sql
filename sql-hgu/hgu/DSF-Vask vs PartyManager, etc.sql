SELECT A.*
  FROM batch_name_update A
 WHERE A.requestor_id   in ( 'HGU 2021-11-09 B2B' )
--   AND A.request_time between sysdate - (1/48) AND SYSDATE
   AND a.process_status = 'PRSD_ERROR'
;

SELECT A.ban, A.subscriber_no, A.link_type, A.chg_birth_date, A.birth_date, A.chg_pid, A.pid, A.first_name, A.last_name, A.process_status
     , REPLACE (
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
  FROM batch_name_update A
 WHERE A.requestor_id   in ( 'HGU 2021-11-09 B2B' )
   AND a.process_status = 'PRSD_ERROR'
ORDER BY 11,2
;

UPDATE batch_name_update A
    SET A.chg_gender    = 'Y', A.gender = '@', a.process_status = 'WAITING', a.status_desc = NULL, a.process_time = NULL
 WHERE A.requestor_id   in ( 'HGU 2021-11-09 B2B' )
   AND A.process_status = 'PRSD_ERROR'
   AND A.status_desc LIKE '%IllegalGenderException%'
;

SELECT A.requestor_id, A.link_type, a.process_status, count(1) as "COUNT"
  FROM batch_name_update A
 WHERE A.requestor_id   in ( 'HGU 2021-11-09 B2B' )
GROUP BY A.requestor_id, A.link_type, A.process_status
ORDER BY A.requestor_id, A.link_type, A.process_status
;


SELECT n.link_type, n.process_status AS "NAME_STATUS", e.process_status AS "EVENT_STATUS", count(1) AS "COUNT"
  FROM batch_name_update n, party_manager_events e
 WHERE n.requestor_id   in ( 'HGU 2021-11-09 B2B' )
   AND n.ban            = e.customer_id(+)
   AND n.request_time   < e.request_time(+)
   AND SYSDATE + (1/48) > e.request_time(+)
--   AND e.request_time   BETWEEN n.request_time AND SYSDATE + (1/48)
GROUP BY n.link_type, n.process_status, e.process_status
ORDER BY n.link_type, DECODE(n.process_status, 'WAITING', 1, 'PRSD_SUCCESS', 2, 3), DECODE(e.process_status, NULL, 0, 'WAITING', 1, 'PRSD_SUCCESS', 2, 3)
;

WITH names AS (
  SELECT u.link_type, u.process_status AS "NAME_STATUS", count(1) as "NAME_COUNT"
    FROM batch_name_update u
   WHERE u.requestor_id   in ( 'HGU 2021-11-09 B2B' )
     AND u.process_status NOT IN ( 'IN_PROGRESS' )
  GROUP BY u.link_type, u.process_status
  ORDER BY u.link_type, u.process_status
), EVENTS AS (
  SELECT u.link_type, u.process_status AS "NAME_STATUS", e.process_status AS "EVENT_STATUS", count(1) AS "EVENT_COUNT"
    FROM batch_name_update u, party_manager_events e
   WHERE u.requestor_id   in ( 'HGU 2021-11-09 B2B' )
     AND u.process_status NOT IN ( 'IN_PROGRESS' )
     AND u.ban            = e.customer_id(+)
     AND u.request_time   < e.request_time(+)
     AND SYSDATE + (1/48) > e.request_time(+)
  GROUP BY u.link_type, u.process_status, e.process_status
)
SELECT e.link_type, e.name_status, n.name_count, e.event_status, e.event_count
  FROM names n, EVENTS e
 WHERE n.link_type   = e.link_type
   AND n.name_status = e.name_status
ORDER BY e.link_type, decode(e.name_status, 'WAITING', 1, 'PRSD_SUCCESS', 2, 3), decode(e.event_status, 'WAITING', 1, 'PRSD_SUCCESS', 2, 3)
;


SELECT A.*
  FROM batch_name_update A
 WHERE A.requestor_id   in ( 'HGU 2021-11-09 B2B' )
--   AND A.chg_birth_date IS NULL
   AND A.chg_pid        IS NULL
   AND A.process_status = 'IN_PROGRESS'
   AND 0                = (SELECT count(1)
                             FROM party_manager_events pme
                            WHERE pme.customer_id = A.ban
                              and pme.request_time between a.request_time and TRUNC(SYSDATE + 1))
   AND ROWNUM           < 11
;


--DELETE
--  FROM batch_name_update A
-- WHERE A.request_time BETWEEN SYSDATE - (1/48) AND SYSDATE
--   AND A.process_status = 'IN_PROGRESS'
--;

SELECT A.*
  FROM batch_name_update A
 WHERE A.requestor_id   in ( 'HGU 2021-11-09 B2B' )
--   AND A.chg_birth_date IS NULL
--   AND A.chg_pid        = 'Y'
   AND A.ban            IN ( 503921512, 516606316 )
--   AND a.process_status = 'PRSD_ERROR'
;

UPDATE batch_name_update A
   SET A.process_status = 'WAITING'
 WHERE A.requestor_id   in ( 'HGU 2021-11-09 B2B' )
   AND A.process_status = 'IN_PROGRESS'
--   AND A.ban            IN ( 503921512, 516606316 )
--   AND A.link_type      IN ( 'L' )
   AND A.link_type      IN ( 'U' )
--   AND A.link_type      IN ( 'B' )
;

UPDATE batch_name_update A
   SET A.process_status = 'WAITING'
     , A.process_time   = NULL
     , A.status_desc    = NULL
 WHERE A.requestor_id   in ( 'HGU 2021-11-09 B2B' )
   AND A.process_status = 'PRSD_SUCCESS'
   AND A.ban            IN ( 503921512, 516606316 )
   AND A.link_type      IN ( 'L' )
;


SELECT A.requestor_id, a.process_status, count(1) as "COUNT"
  FROM batch_name_update A
 WHERE A.requestor_id in ( 'HGU 2021-11-09 B2B' )
GROUP BY A.requestor_id, A.process_status
ORDER BY A.requestor_id, A.process_status
;

UPDATE ninja_jobs A
   SET A.job_status = 'STARTING'
 WHERE A.machine_id = 'NINJAP1_DEMON'
   AND A.job_id     = 70
;

--== Ninja: Display all running jobs, sort by the 'status_time' in order to see how long they've been running...
SELECT A.machine_id, A.job_id, A.job_status
     , TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", TO_CHAR(A.status_time, 'YYYY-MM-DD') AS "STATUS_DATE"
     , to_char(A.status_time, 'HH24:MI:SS') AS "STATUS_TIME"
     , LTRIM(TO_CHAR(A.sleep_time/60000, 'FM9900')) || ':' || LTRIM(TO_CHAR(MOD(A.sleep_time/1000, 60), '00')) AS "SLEEP_TIME"
     , TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME"
     , LTRIM(TO_CHAR(TRUNC(SYSDATE - A.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - A.status_time), ':HH24:MI:SS') AS "RUNTIME"
     ,  a.exec_method, a.job_desc, a.fixed_start -- , a.hlr_based
  FROM ninja_jobs a 
 WHERE A.machine_id = 'NINJAP1_DEMON'
   AND A.job_id     = 70
;


SELECT A.*
  FROM party_manager_events A
 WHERE A.request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/48
   AND A.customer_id IN ( 503921512, 516606316 )
ORDER BY A.request_id
;

SELECT action_type, customer_id, subscriber_no, link_type, old_comp_reg_id, comp_reg_id, old_tpid, tpid
     , to_char(request_time, 'HH24:MI:SS') AS "REQUEST_TIME", to_char(process_time, 'HH24:MI:SS') AS "PROCESS_TIME"
     , process_status, status_desc
  from party_manager_events
 WHERE request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/48
   AND customer_id  IN ( 503921512, 516606316 )
ORDER BY request_id
;


SELECT A.*
  FROM batch_tpid_extract A
 WHERE 1 = 1
   AND A.request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/48
   AND A.ban IN ( 503921512, 516606316 )
ORDER BY A.request_time
;

SELECT A.*
  FROM batch_tpid_update A
 WHERE A.request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/48
   AND A.ban IN ( 503921512, 516606316 )
ORDER BY A.request_time
;

--
-- To fix issues with the "bad batch" last week, clear the TPID for all LO's processed today.
--
INSERT INTO batch_tpid_update (ban, link_type, subscriber_no, request_id)
SELECT n.ban
     , n.link_type
     , n.subscriber_no
     , 'HGU 2021-09-30' AS "REQUEST_ID"
  from batch_name_update n
 WHERE n.requestor_id   in ( 'HGU 2021-11-09 B2B' )
   AND n.process_status = 'PRSD_SUCCESS'
   and n.ban            IN ( 503921512, 516606316 )
;

SELECT t.*
  FROM batch_tpid_update t
 WHERE t.request_id = 'HGU 2021-09-30'
   and t.ban        IN ( 503921512, 516606316 )
;

SELECT A.request_id, A.link_type, a.process_status, count(1) as "COUNT"
  FROM batch_tpid_update A
 WHERE A.request_id = 'HGU 2021-09-30'
GROUP BY A.request_id, A.link_type, A.process_status
ORDER BY A.request_id, A.link_type, A.process_status
;

WITH my_filter AS (
  SELECT unique t.ban
    FROM batch_tpid_update t
   WHERE t.request_id = 'HGU 2021-09-30'
--     AND t.ban         IN ( 100000413 )
)
SELECT 'HGU 2021-09-30' AS "REQUEST_ID", e.link_type, e.process_status
     , COUNT(1) AS "EVENT_COUNT"
  FROM party_manager_events e, my_filter mf
 WHERE e.customer_id  = mf.ban
--   AND e.request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/48
   AND e.request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/24
GROUP BY e.link_type, e.process_status
ORDER BY 1, e.link_type, e.process_status
;

WITH my_filter AS (
  SELECT unique t.ban
    FROM batch_tpid_update t
   WHERE t.request_id = 'HGU 2021-09-30'
--     AND t.ban         IN ( 100000413 )
)
SELECT 'HGU 2021-09-30' AS "REQUEST_ID", e.link_type, e.process_status
     , DECODE(e.process_status, 'PRSD_SUCCESS', 'Done', 'In ' || TO_CHAR(abs(SYSDATE - e.request_time) * 1440, 'FM9900') || ' min') AS "DUE"
     , COUNT(1) AS "EVENT_COUNT"
  FROM party_manager_events e, my_filter mf
 WHERE e.customer_id  = mf.ban
--   AND e.request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/48
   AND e.request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/24
GROUP BY e.link_type, e.process_status, DECODE(e.process_status, 'PRSD_SUCCESS', 'Done', 'In ' || TO_CHAR(abs(SYSDATE - e.request_time) * 1440, 'FM9900') || ' min')
ORDER BY 1, e.link_type, e.process_status
;

WITH my_filter AS (
  SELECT unique t.ban
    FROM batch_tpid_update t
   WHERE t.request_id = 'HGU 2021-09-30'
--     AND t.ban         IN ( 100000413 )
)
SELECT e.customer_id, e.link_type, e.subscriber_no, e.old_comp_reg_id, e.comp_reg_id, e.old_tpid, e.tpid
     , to_char(SYSDATE, 'HH24:MI:SS') AS "NOW", to_char(e.request_time, 'HH24:MI:SS') AS "REQ_TIME"
     , e.process_time, e.process_status, e.status_desc
  FROM party_manager_events e, my_filter mf
 WHERE e.customer_id  = mf.ban
--   AND e.request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/48
   AND  e.request_time BETWEEN trunc(SYSDATE) AND SYSDATE + 1/48
ORDER BY e.customer_id, e.request_time
;