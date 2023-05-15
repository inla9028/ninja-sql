/*
** Insert records for processing...
*/
INSERT INTO batch_publishlevel_update
SELECT 0               AS "TRANSACTION_NUMBER"
     , a.subscriber_no
     , a.soc           AS "PUBLISH_LEVEL"
     , 'WAITING'       AS "PROCESS_STATUS"
     , NULL            AS "PROCESS_TIME"
     , NULL            AS "STATUS_DESC"
     , NULL            AS "RECORD_CREATION_DATE"
     , 'Trond Lundby ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS "REQUEST_ID"
     , 'trlu0752'      AS "REQUEST_USER_ID"
  FROM ninjateam.hgu_tmp_subs a
;

/*
** Schedule for 02:00 tomorrow.
*/
UPDATE ninja_jobs a
   SET a.next_exec_time = TRUNC(SYSDATE + 1) + (2/24)
 WHERE a.machine_id     = 'NINJAP2_DEMON'
   AND a.job_id         = 61
   AND a.exec_method    = 'batchPublishLevelUpdate'
;

/*
** Verify inserts...
*/
SELECT a.request_id, a.request_user_id, a.publish_level, a.process_status, COUNT(*) AS "COUNT"
  FROM batch_publishlevel_update a
 WHERE a.process_status  = 'WAITING'
GROUP BY a.request_id, a.request_user_id, a.publish_level, a.process_status
ORDER BY a.request_id, a.request_user_id, a.publish_level, a.process_status;
;

/*
** Verify Ninja Jobs...
*/
SELECT a.*
  FROM ninja_jobs a
 WHERE a.machine_id     = 'NINJAP2_DEMON'
   AND a.job_id         = 61
   AND a.exec_method    = 'batchPublishLevelUpdate'
;

/*
** Commit the hard work..
*/
--COMMIT WORK;

