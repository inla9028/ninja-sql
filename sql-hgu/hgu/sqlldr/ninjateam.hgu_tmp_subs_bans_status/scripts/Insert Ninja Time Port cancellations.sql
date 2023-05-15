SELECT a.*
  FROM ninjateam.hgu_tmp_subs_bans_status a
ORDER BY 2,3,5
;

SELECT a.*
  FROM subscriber@fokus a
 WHERE a.subscriber_no = 'GSM04740309554'
;

-- List Chess customers, still active...
SELECT a.*
  FROM ninjateam.hgu_tmp_subs_bans_status a
 WHERE a.acc_type     = 'S'
   AND a.acc_sub_type = 'C2'
   AND a.sub_status   = 'A'
ORDER BY 4,1
;

-- Insert records into Ninja Time Port..
-- Note! I got a "mutating" error when running this, I had to export the output
--       as insert-statements and insert "manually".
--INSERT INTO ninja_time_port -- (ninja_ref_id, nrdb_ref_id, user_id, ctn, ban, number_owner_code, donor_code, recipient_code, date_time_created, date_time_modified, date_time_port, description, action, status, ninja_action, proc_attempts,dealer_code,sales_agent)
SELECT NULL            AS "NINJA_REF_ID"
     , '8320000000000' AS "NRDB_REF_ID"
     , 'Chess2'        AS "USER_ID" -- For Chess postpaid, use 'BSH_USER', for Chess prepaid, use 'Chess2'
     , REPLACE(a.subscriber_no, 'GSM', '') AS "CTN"
     , a.ban           AS "BAN"
     , 'null'          AS "NUMBER_OWNER_CODE"
     , '817'           AS "DONOR_CODE"
     , '832'           AS "RECIPIENT_CODE"
     , TO_DATE('2018-01-16 06:06:06', 'YYYY-MM-DD HH24:MI:SS') AS "DATE_TIME_CREATED"
     , TO_DATE('2018-01-16 06:06:06', 'YYYY-MM-DD HH24:MI:SS') AS "DATE_TIME_MODIFIED"
     , TO_DATE('2018-01-16 06:06:06', 'YYYY-MM-DD HH24:MI:SS') AS "DATE_TIME_PORT"
     , 'Emergency Cancellations' AS "DESCRIPTION"
     , 'CANC'          AS "ACTION"
     , 0               AS "PROC_ATTEMPTS"
     , 'WAITING'       AS "STATUS"
     , 'CANCEL'        AS "NINJA_ACTION"
     , a.dealer_code   AS "DEALER_CODE"
     , NULL            AS "SALES_AGENT"
  FROM ninjateam.hgu_tmp_subs_bans_status a
 WHERE a.acc_type     = 'S'  -- Prepaid: 'S',  Postpaid: 'H'
   AND a.acc_sub_type = 'C2' -- Prepaid: 'C2', Postpaid: 'PC'
   AND a.sub_status   = 'A'
 ORDER BY a.subscriber_no
;

-- Monitor Ninja Time Port
SELECT n.*
  FROM ninja_time_port n
 WHERE n.nrdb_ref_id    = '8320000000000'
--   AND n.user_id        = 'Chess2'
   AND n.date_time_port = TO_DATE('2018-01-16 06:06:06', 'YYYY-MM-DD HH24:MI:SS');
;

SELECT n.user_id
     , n.status
     , TO_CHAR(n.date_time_port, 'YYYY-MM-DD HH24:MI:SS') AS DATE_TIME_PORT
     , COUNT(1) AS COUNT
  FROM ninja_time_port n
 WHERE n.nrdb_ref_id    = '8320000000000'
--   AND n.user_id        = 'Chess2'
   AND n.date_time_port > TRUNC(SYSDATE, 'YEAR')
GROUP BY n.user_id, n.status, TO_CHAR(n.date_time_port, 'YYYY-MM-DD HH24:MI:SS')
ORDER BY 1,2, 3
;

-- Check sub_status in Fokus post-processing.
SELECT a.*, s.sub_status AS "STATUS_IN_FOKUS_POST_PROCESSING", s.sub_status_date
  FROM ninjateam.hgu_tmp_subs_bans_status a, subscriber@fokus s
 WHERE a.acc_type      = 'S'  -- Prepaid: 'S',  Postpaid: 'H'
   AND a.acc_sub_type  = 'C2' -- Prepaid: 'C2', Postpaid: 'PC'
   AND a.sub_status    = 'A'
   AND a.ban           = s.customer_id
   AND a.subscriber_no = s.subscriber_no
ORDER BY 4,1
;

-- Update user_id... 'BSH_USER'
UPDATE ninja_time_port n
   SET n.user_id       = 'BSH_USER'
     , n.status        = 'WAITING'
     , n.description   = 'Emergency Cancellations'
     , n.proc_attempts = 0
 WHERE n.nrdb_ref_id    = '8320000000000'
   AND n.user_id        = 'Chess2'
   AND n.date_time_port > TRUNC(SYSDATE, 'YEAR')
;

