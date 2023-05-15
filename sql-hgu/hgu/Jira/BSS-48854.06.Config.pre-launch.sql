--
-- List TPID Extract Job.
--
SELECT A.machine_id, A.job_id, A.job_status
     , TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", TO_CHAR(A.status_time, 'YYYY-MM-DD') AS "STATUS_DATE"
     , TO_CHAR(A.status_time, 'HH24:MI:SS') AS "STATUS_TIME"
     , LTRIM(TO_CHAR(A.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(A.sleep_time/1000, 60), '00')) AS "SLEEP_TIME"
     , TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME"
     , LTRIM(TO_CHAR(TRUNC(SYSDATE - A.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - A.status_time), ':HH24:MI:SS') AS "RUNTIME"
     ,  a.exec_method
  FROM ninja_jobs A
 WHERE A.machine_id = 'NINJAP2_DEMON'
   AND A.job_id    IN ( 88, 89 )
ORDER BY 1,2
;

--
-- Start job
--
UPDATE ninja_jobs A
   SET A.job_status = 'STARTING', a.next_exec_time = TRUNC(SYSDATE)
 WHERE A.machine_id = 'NINJAP2_DEMON'
   AND A.job_id     = 88
   AND A.job_status = 'STOPPED'
;

--
-- Stop job
--
UPDATE ninja_jobs A
   SET A.job_status = 'STOPPING'
 WHERE A.machine_id = 'NINJAP2_DEMON'
   AND A.job_id     = 88
   AND A.job_status IN ( 'STARTING', 'RUNNING', 'SLEEPING' )
;

--
-- Run extract every X minutes.
--
UPDATE ninja_jobs A
   SET A.sleep_time = 1 * 60 * 1000
 WHERE A.machine_id = 'NINJAP2_DEMON'
   AND A.job_id     = 89
;

--
-- Check status of relevant NSM jobs.
--
SELECT A.hostname, A.job_id, A.job_status, TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW"
     , TO_CHAR(A.status_time, 'YYYY-MM-DD') AS "STATUS_DATE", TO_CHAR(A.status_time, 'HH24:MI:SS') AS "STATUS_TIME"
     , LTRIM(TO_CHAR(A.sleep_time/60000, '00')) || ':' || ltrim(TO_CHAR(MOD(A.sleep_time/1000, 60), '00')) AS "SLEEP_TIME"
     , TO_CHAR(A.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME"
     , LTRIM(TO_CHAR(TRUNC(SYSDATE - A.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - A.status_time), ':HH24:MI:SS') AS "RUNTIME",
       NVL(SUBSTR(a.job_fqcn, DECODE(INSTR(a.job_fqcn, '.', -1), -1, -1, INSTR(a.job_fqcn, '.', -1) + 1)), 'N/A') AS "JOB_FQCN"
  FROM nsm_jobs a
 WHERE A.hostname LIKE 'no-neo-prod%'
   AND A.job_id   IN ( 0, 2, 3 )
ORDER BY 1, 2
;

--
-- Start job
--
UPDATE nsm_jobs A
   SET A.job_status = 'STARTING'
 WHERE A.hostname   LIKE 'no-neo-prod%'
   AND A.job_id     IN ( 2, 3 )
   AND A.job_status = 'STOPPED'
;

--
-- Stop job
--
UPDATE nsm_jobs A
   SET A.job_status = 'STOPPING'
 WHERE A.hostname   LIKE 'no-neo-prod%'
   AND A.job_id     IN ( 2, 3 )
   AND A.job_status IN ( 'STARTING', 'RUNNING', 'SLEEPING' )
;

--
-- Configure TPID extract parameters
--
SELECT A.*
  FROM system_defaults A
 WHERE A.KEY LIKE 'TPID_EXTRACT%'
    OR a.key LIKE 'PARTY_MANAGER%'
ORDER BY 1
;

--INSERT INTO system_defaults (KEY, VALUE, value_type, description)
--VALUES ('TPID_EXTRACT_ACCOUNT_TYPES', 'I', 'STRING', 'Only read these account-types from WH12P.')
--;

--
-- Update the batch-size.
--
UPDATE system_defaults A
   SET A.VALUE = '1000'
 WHERE A.KEY   = 'TPID_EXTRACT_BATCH_SIZE'
;

--
-- Start processing status events.
--
UPDATE system_defaults A
   SET A.VALUE = 'Y'
 WHERE A.KEY   = 'PARTY_MANAGER_EVENTS'
;

--
-- Start processing status changes.
--
UPDATE system_defaults A
   SET A.VALUE = 'Y'
 WHERE A.KEY   = 'PARTY_MANAGER_STATUS'
;

--
-- Process these account-types.
--
UPDATE system_defaults A
   SET A.VALUE = 'I, P'
 WHERE A.KEY   = 'TPID_EXTRACT_ACCOUNT_TYPES'
;

--
-- Check the status/queue in relevant tables.
--

--==
--== TPID Extract
--==

SELECT b.request_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(A.request_time, 'YYYY-MM-DD HH24:MI') AS "REQUEST_TIME", A.process_status
          FROM batch_tpid_extract A) b
GROUP BY b.request_time, b.process_status
ORDER BY b.request_time, b.process_status
;

SELECT b.request_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(A.request_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "REQUEST_TIME", A.process_status
          FROM batch_tpid_extract A
         WHERE A.request_time  > trunc(SYSDATE)) b
GROUP BY b.request_time, b.process_status
ORDER BY b.request_time, b.process_status
;

SELECT b.request_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(A.request_time, 'YYYY-MM-DD') AS "REQUEST_TIME", A.process_status
          FROM batch_tpid_extract A
         WHERE A.request_time > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')) b
GROUP BY b.request_time, b.process_status
ORDER BY b.request_time, b.process_status
;


SELECT b.process_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(A.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME", A.process_status
          FROM batch_tpid_extract A
         WHERE A.request_time  > trunc(SYSDATE)) b
GROUP BY b.process_time, b.process_status
ORDER BY b.process_time, b.process_status
;

SELECT b.process_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(A.process_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "PROCESS_TIME", A.process_status
          FROM batch_tpid_extract A
         WHERE A.request_time  > trunc(SYSDATE)) b
GROUP BY b.process_time, b.process_status
ORDER BY b.process_time, b.process_status
;

SELECT TO_CHAR(avg(count), '000') AS "AVG_PER_MINUTE"
  FROM (
    SELECT b.process_time, b.process_status, count(1) AS "COUNT"
      FROM (SELECT to_char(A.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME", A.process_status
              FROM batch_tpid_extract A
             WHERE A.request_time  > trunc(SYSDATE)
               AND A.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS' )) b
    GROUP BY b.process_time, b.process_status
    ORDER BY b.process_time, b.process_status
)
;

--==
--== TPID Update
--==

SELECT b.request_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(A.request_time, 'YYYY-MM-DD') AS "REQUEST_TIME", A.process_status
          FROM batch_tpid_update A
         WHERE A.request_time > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')) b
GROUP BY b.request_time, b.process_status
ORDER BY b.request_time, b.process_status
;


SELECT b.request_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(A.request_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "REQUEST_TIME", A.process_status
          FROM batch_tpid_update A 
         WHERE A.request_time > trunc(SYSDATE)) b
GROUP BY b.request_time, b.process_status
ORDER BY b.request_time, b.process_status
;

SELECT b.process_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(A.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME", A.process_status
          FROM batch_tpid_update A
         WHERE A.request_time > trunc(SYSDATE)
           AND A.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS' )) b
GROUP BY b.process_time, b.process_status
ORDER BY b.process_time, b.process_status
;

SELECT b.process_time, b.process_status, count(1) AS "COUNT"
  FROM (SELECT to_char(A.process_time, 'YYYY-MM-DD HH24":00-"HH24":59"') AS "PROCESS_TIME", A.process_status
  FROM batch_tpid_update A
  WHERE A.request_time > trunc(SYSDATE) AND A.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS' )) b
GROUP BY b.process_time, b.process_status
ORDER BY b.process_time, b.process_status
;

SELECT TO_CHAR(avg(count), '000') AS "AVG_PER_MINUTE"
  FROM (
    SELECT b.process_time, b.process_status, count(1) AS "COUNT"
      FROM (SELECT to_char(A.process_time, 'YYYY-MM-DD HH24:MI') AS "PROCESS_TIME", A.process_status
              FROM batch_tpid_update A
             WHERE A.request_time > trunc(SYSDATE)
               AND A.process_status IN ( 'PRSD_ERROR', 'PRSD_SUCCESS' )) b
    GROUP BY b.process_time, b.process_status
    ORDER BY b.process_time, b.process_status
)
;

SELECT A.request_id, A.process_status, count(1) AS "COUNT"
  FROM batch_tpid_update A
 WHERE A.request_time  > trunc(SYSDATE)
GROUP BY A.request_id, A.process_status
ORDER BY A.request_id, A.process_status
;


SELECT A.*
  FROM batch_tpid_extract A
 WHERE A.request_time   > trunc(SYSDATE)
   AND A.process_status = 'PRSD_ERROR'
ORDER BY A.request_time
;

SELECT A.*
  FROM batch_tpid_update A
 WHERE A.request_time   > trunc(SYSDATE)
   AND A.process_status = 'PRSD_ERROR'
ORDER BY A.request_time
;


--INSERT INTO batch_tpid_extract (ban, subscriber_no, link_type)
--VALUES(933201519, 'GSM04799458988', 'U')
--;

UPDATE batch_tpid_extract A
   SET A.process_status = 'WAITING', A.process_time = NULL, A.status_desc = NULL
 WHERE 1                = 1  
   AND A.ban           IN (  880568605, 255451502 )
--   AND A.subscriber_no  = 'GSM04799458988'
--   AND A.link_type      = 'U'
   AND A.process_status = 'PRSD_ERROR'
;

--==
--== Check the remaining...
--==
SELECT b.account_type, b.entity, count(1) AS "COUNT"
  FROM (SELECT /*+ driving_site(A)*/
               A.account_type
             , decode(A.subscriber_no, '0000000000', 'BAN', 'SUB') AS "ENTITY"
          FROM cdata.get_tpid_null@wh12p A) b
GROUP BY b.account_type, b.entity
ORDER BY b.account_type, b.entity
;


--==
--== Check the name/address of the remaining...
--==
--WITH my_filter AS (SELECT /*+ driving_site(A)*/ A.ban, A.subscriber_no, A.link_type
--                     FROM cdata.get_tpid_null@wh12p A
--                    WHERE A.account_type = 'I'
--                      AND A.tpid IS NULL)
--SELECT /*+ driving_site(anl)*/
--       anl.ban
--     , decode(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
--     , anl.link_type, anl.birth_date, nd.tpid, nd.first_name, nd.last_business_name
--     , ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email
--  FROM address_name_link@fokus anl
--     , name_data@fokus         nd
--     , address_data@fokus      ad
--     , my_filter               mf
-- WHERE anl.ban            = mf.ban
--   AND nvl(anl.subscriber_no,'N/A')  = nvl(mf.subscriber_no, 'N/A')
--   and anl.link_type      = mf.link_type
--   AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
--   AND anl.name_id        = nd.name_id
--   AND anl.address_id     = ad.address_id
--ORDER BY anl.ban, anl.subscriber_no, anl.link_type
--;


--==
--== Populate the job manually.
--==
INSERT INTO batch_tpid_extract (ban, subscriber_no, link_type, comp_reg_id, request_id)
WITH my_filter AS (SELECT a.ban
                        , decode(a.subscriber_no, NULL, '0000000000', a.subscriber_no) AS "SUBSCRIBER_NO"
                        , a.link_type
                     FROM batch_tpid_extract a
                    WHERE a.request_id =  'NINJA ' || to_char(SYSDATE, 'YYYY-MM-DD'))
SELECT /*+ driving_site(a)*/
       A.ban
     , decode(a.subscriber_no, '0000000000', NULL, a.subscriber_no) AS "SUBSCRIBER_NO"
     , a.link_type
     , a.comp_reg_id
     , 'NINJA ' || to_char(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
  FROM cdata.get_tpid_null@wh12p A
 WHERE A.account_type  IN ( 'P' )
    AND A.subscriber_no != '0000000000'
   AND 0                = (SELECT count(1)
                             FROM my_filter mf
                            WHERE mf.ban           = a.ban
                              AND mf.subscriber_no = a.subscriber_no
                              AND mf.link_type     = A.link_type)
   AND ROWNUM < 50001
ORDER BY a.sys_creation_date ASC
;

