
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all/failed records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.*
  FROM batch_add_soc_w_exp_date a
 WHERE a.request_id   IN ( 'TRVE0622 2022-03-31' )
--   AND a.process_status = 'PRSD_ERROR'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all/failed records with trimmed errors.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT t.subscriber_no, t.soc, t.request_time, t.process_time, t.process_status
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (t.status_desc,
                           0,
                           INSTR (t.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (t.status_desc,
                               0,
                               INSTR (t.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM batch_add_soc_w_exp_date t
 WHERE t.request_id         = 'TRVE0622 2022-03-31'
   AND t.process_status    IN ( 'PRSD_ERROR' )
ORDER BY t.process_status, "STATUS_DESC", t.subscriber_no
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display overview of all/failed records trimmed errors.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT soc, process_status, status_desc, COUNT(1) AS "COUNT"
  FROM (
SELECT t.soc , t.process_status
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (t.status_desc,
                           0,
                           INSTR (t.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (t.status_desc,
                               0,
                               INSTR (t.status_desc || ' [ID', ' [ID')),
                       'Exception: '))),
            'Exception: ',
            '')   AS "STATUS_DESC"
  FROM batch_add_soc_w_exp_date t
 WHERE t.request_id = 'TRVE0622 2022-03-31'
)
GROUP BY soc, process_status, status_desc
ORDER BY soc, process_status, status_desc
;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all/failed records with SPM mappings
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT t.subscriber_no
     , t.soc, m1.sp_code AS "SPM_SERVICE"
     , t.request_time, t.process_time, t.process_status
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (t.status_desc,
                           0,
                           INSTR (t.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (t.status_desc,
                               0,
                               INSTR (t.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM batch_add_soc_w_exp_date                         t
     , spm_service_mapping                m1
     , socs                               s1
 WHERE t.request_id         = 'TRVE0622 2022-03-31'
   AND t.soc                = s1.soc
   AND s1.soc_type          = m1.soc_type
   AND s1.soc_group         = m1.soc_group
ORDER BY t.process_status, "STATUS_DESC", t.subscriber_no
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display overview of all/failed records with SPM mappings.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT soc, spm_service, process_status, status_desc, COUNT(1) AS "COUNT"
  FROM (
SELECT t.soc
     , m1.sp_code AS "SPM_SERVICE"
     , t.process_status
     , SUBSTR(REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (t.status_desc,
                           0,
                           INSTR (t.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (t.status_desc,
                               0,
                               INSTR (t.status_desc || ' [ID', ' [ID')),
                       'Exception: '))),
            'Exception: ',
            ''), 0, 45)   AS "STATUS_DESC"
  FROM batch_add_soc_w_exp_date                         t
     , spm_service_mapping                m1
     , socs                               s1
 WHERE t.request_id         = 'TRVE0622 2022-03-31'
   AND t.soc                = s1.soc
   AND s1.soc_type          = m1.soc_type
   AND s1.soc_group         = m1.soc_group
)
GROUP BY soc, spm_service, process_status, status_desc
ORDER BY soc, spm_service, process_status, status_desc
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display status of all records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.086) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.086) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_add_soc_w_exp_date a
 WHERE a.request_id IN ( 'TRVE0622 2022-03-31' )
GROUP BY a.request_id, a.process_status
ORDER BY a.request_id, a.process_status
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display status of all records.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.soc, a.request_time, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.086) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.086) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_add_soc_w_exp_date a
 WHERE a.process_status IN ('IN_PROGRESS', 'WAITING')
GROUP BY a.request_id, a.soc, a.request_time, a.process_status
ORDER BY a.request_id, a.soc, a.request_time, a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the remaining number of records
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.soc, a.request_time, a.process_status, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.086) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.086) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_add_soc_w_exp_date a
 WHERE a.request_id IN ( 'TRVE0622 2022-03-31' )
--   AND a.process_status = 'WAITING'
--   AND a.request_time > TRUNC(SYSDATE)
GROUP BY a.request_id, a.soc, a.request_time, a.process_status
ORDER BY a.request_id, a.soc, a.request_time, a.process_status
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start the processing...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_add_soc_w_exp_date a
   SET a.process_status = 'WAITING'
--     , a.process_time = NULL, a.status_desc = NULL
 WHERE a.request_id IN ( 'TRVE0622 2022-03-31' )
   AND a.process_status = 'ON_HOLD'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start the processing, also re-process all failed records now with Ninja
--== validation turned off.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_add_soc_w_exp_date a
   SET a.process_status        = 'WAITING'
     , a.process_time          = NULL
     , a.status_desc           = NULL
 WHERE a.request_id     IN ( 'TRVE0622 2022-03-31' )
   AND a.process_status IN ( 'PRSD_ERROR' )
   AND a.status_desc  LIKE '%%'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Schedule this job to a time & date in the future...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_add_soc_w_exp_date a
   SET a.process_status = 'WAITING',
       a.request_time   = TO_DATE('2009-11-04 00:05', 'YYYY-MM-DD HH24:MI')
 WHERE a.request_id    IN ( 'TRVE0622 2022-03-31' )
   AND a.process_status = 'ON_HOLD'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display failed records, priceplan and the cause, without prefix
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id,
       a.subscriber_no,
       REPLACE (
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
  FROM batch_add_soc_w_exp_date a
 WHERE a.request_id IN ( 'TRVE0622 2022-03-31' )
   AND a.process_status = 'PRSD_ERROR'
ORDER BY "STATUS_DESC", a.request_id, a.subscriber_no
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records, grouped by status and status-description.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.process_status,
       RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID'))) AS "STATUS_DESC",
       COUNT(*) AS "COUNT"
  FROM batch_add_soc_w_exp_date a
 WHERE a.request_id   IN ( 'TRVE0622 2022-03-31' )
GROUP BY a.request_id, a.process_status, RTRIM(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')))
ORDER BY a.request_id, a.process_status, "STATUS_DESC"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all records, grouped by status and status-description.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.request_id, a.process_status,
       REPLACE (
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
           AS "STATUS_DESC",
       COUNT(*) AS "COUNT"
  FROM batch_add_soc_w_exp_date a
 WHERE a.request_id   IN ( 'TRVE0622 2022-03-31' )
   AND a.process_status = 'PRSD_ERROR'
GROUP BY a.request_id, a.process_status, REPLACE(RTRIM(SUBSTR(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')), INSTR(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')), 'Exception: '))), 'Exception: ', '')
ORDER BY 4 DESC
;

SELECT COUNT(1) AS "COUNT", b.status_desc
  FROM (SELECT a.request_id, a.process_status,
               REPLACE (
                   RTRIM (
                       SUBSTR (
                           SUBSTR (a.status_desc,
                                   0,
                                   INSTR (a.status_desc || ' [ID', ' [ID')),
                           INSTR (
                               SUBSTR (a.status_desc,
                                       0,
                                       INSTR (a.status_desc || ' [ID', ' [ID')),
                               'Exception: '))), 'Exception: ', '') AS "STATUS_DESC"
          FROM batch_add_soc_w_exp_date A
         WHERE A.request_id   IN ( 'TRVE0622 2022-03-31' )
           AND A.process_status = 'PRSD_ERROR') b
GROUP BY b.status_desc
ORDER BY 1 DESC, 2
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI') AS "TIME", COUNT(*) AS "COUNT"
  FROM batch_add_soc_w_exp_date a
 WHERE a.request_id IN ( 'TRVE0622 2022-03-31' )
   AND a.process_time IS NOT NULL
GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
ORDER BY "TIME"
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Calculate the average number of processed records per minute, for the last
--== 15 minutes...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       to_number(ltrim(to_char(avg("COUNT"), '9999999,999'))) AS "AVG_PER_MIN",
       TO_NUMBER(LTRIM(TO_CHAR(60 / AVG("COUNT"), '9999999,999'))) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_add_soc_w_exp_date a
--     WHERE a.process_time BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
     WHERE a.request_id        IN ( 'TRVE0622 2022-03-31' )
       AND a.process_status    IN ('PRSD_SUCCESS', 'PRSD_ERROR')
--       AND a.process_time BETWEEN TRUNC(SYSDATE) AND SYSDATE
       AND a.process_time      IS NOT NULL
    GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
    ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

SELECT SUM("COUNT")                AS "PROCESSED_RECORDS",
       ROUND(AVG("COUNT"), 3)      AS "AVG_PER_MIN",
       ROUND(60 / AVG("COUNT"), 3) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_add_soc_w_exp_date a
     WHERE a.process_time BETWEEN (TRUNC(SYSDATE, 'MI') - (16 / 1440)) AND (TRUNC(SYSDATE, 'MI') - (1 / 1440))
--     WHERE a.request_id        IN ( 'TRVE0622 2022-03-31' )
       AND a.process_status    IN ('PRSD_SUCCESS', 'PRSD_ERROR')
--       AND a.process_time BETWEEN TRUNC(SYSDATE) AND SYSDATE
--       AND a.process_time      IS NOT NULL
       AND a.process_time      > SYSDATE - 1/(4*24)
    GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
    ORDER BY to_char(A.process_time, 'YYYY-MM-DD HH24:MI')
);

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process records that failed due to a temporary error. ==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_add_soc_w_exp_date a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
--    , a.reason_code = 'KON6'
--    , a.new_subscription_type = a.new_priceplan || 'REG1'
  WHERE a.request_id    IN ( 'TRVE0622 2022-03-31' )
    AND a.process_status = 'PRSD_ERROR'
--    AND a.reason_code = 'KON06'
    AND (
         a.status_desc LIKE '%since last retrieved%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
      OR a.status_desc LIKE 'Attempting to assign Default Fokus User but encountered a null value%'
      OR a.status_desc LIKE '%ConcurrentModificationException%'
      OR a.status_desc LIKE '%NinjaBusinessRulesException%'
      OR a.status_desc LIKE '%Tuxedo service%'
    )
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Update a column... Pick your poison! :-) ==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_add_soc_w_exp_date a
   SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
--     , a.handle_commitment = 'R' -- Replace current commitment.
--     , a.new_campaign_code = 'PSTB24OP' -- PSTB24BI isn't configured...
--     , a.new_subscription_type = a.new_subscription_type || 'REG1'
 WHERE a.request_id   IN ( 'TRVE0622 2022-03-31' )
   AND a.process_status  = 'PRSD_ERROR'
   AND a.status_desc NOT LIKE 'Subscription is not Active%'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process failed records at a certain date & time in the future... -==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_add_soc_w_exp_date a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
    , a.request_time = TO_DATE('2009-08-18 00:30', 'YYYY-MM-DD HH24:MI')
WHERE a.request_id   IN ( 'TRVE0622 2022-03-31' )
  AND a.process_status = 'PRSD_ERROR'
--  AND a.status_desc NOT LIKE 'Subscription is not Active%'
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start processing the first 100 waiting records for a future sceduled entry.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE batch_add_soc_w_exp_date a
   SET a.request_time    = SYSDATE - (1 / 1440)
 WHERE a.request_id   IN ( 'TRVE0622 2022-03-31' )
   AND a.process_status = 'WAITING'
   AND ROWNUM           < 101
;

--
-- Insert rows to process...
--
insert into batch_add_soc_w_exp_date ( BAN, SUBSCRIBER_NO, DELETE_SOCS, MEMO_TEXT, REQUEST_ID )
select /*+ driving_site(s)*/
       s.customer_id            as ban
     , s.subscriber_no          as subscriber_no
     , 'NCHBOBAR'               as delete_socs
     , 'Removing HBO Barring product as cleanup before HBO Max' as memo_text
     , 'TRVE0622 2022-03-31' as request_id
  from subscriber@fokus        s
     , billing_account@fokus   bi
     , service_agreement@fokus sa
 where s.customer_id      = bi.ban
   and s.customer_id      = sa.ban
   and bi.ban             = sa.ban
   and s.subscriber_no    = sa.subscriber_no
   and sa.expiration_date > sysdate
   and s.sub_status      in ('A','R')
   and rtrim(sa.soc)     in ('NCHBOBAR')
   and not exists (select /*+ driving_site(sa2)*/ null 
                     from service_agreement@fokus sa2 
                    where sa2.subscriber_no   = s.subscriber_no 
                      and rtrim(sa2.soc)     in ( 'NCHBOCH01', 'NCHBOCH02' ) -- only subscriptions having NSHAPB014
                      and sa2.expiration_date > sysdate)
--   and rownum < 5
;
