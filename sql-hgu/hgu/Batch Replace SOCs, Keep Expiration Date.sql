SELECT SUM("COUNT") AS "PROCESSED_RECORDS",
       TO_NUMBER(AVG("COUNT")) AS "AVG_PER_MIN",
       TO_NUMBER(60 / AVG("COUNT")) AS "AVG_SECS_PER_RECORD"
  FROM (
    SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI'), COUNT(*) AS "COUNT"
      FROM batch_replace_keep_exp_date a
      WHERE a.request_time         > TRUNC(SYSDATE)
        AND a.process_status      != 'WAITING'
        AND a.process_time        > SYSDATE - (15 / 1440)
      GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
      ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD HH24:MI')
);

SELECT a.request_id, a.process_status, COUNT(1) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.2795) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.2795) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM batch_replace_keep_exp_date a
 WHERE a.request_id = 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY a.request_id, a.process_status
ORDER BY a.request_id, a.process_status
;

SELECT a.request_id, a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo, a.process_status, COUNT(1) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR((COUNT(*) * 0.2795) / 3600, '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.2795) / 60, 60),   '9999999'))) || ' min' AS "QUEUE"
  FROM batch_replace_keep_exp_date a
 WHERE a.request_id = 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
GROUP BY a.request_id, a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo, a.process_status
ORDER BY a.request_id, a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo, a.process_status
;

SELECT a.subscriber_no, a.old_soc, a.old_soc_promo, a.new_soc, a.new_soc_promo
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
  FROM batch_replace_keep_exp_date a
 WHERE a.request_id     = 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.process_status = 'PRSD_ERROR'
ORDER BY 1,2,3,4,5
;

SELECT a.*
  FROM batch_replace_keep_exp_date a
 WHERE a.request_id     = 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.process_status = 'PRSD_ERROR'
ORDER BY 1,2,3,4,5
;

UPDATE batch_replace_keep_exp_date a
   SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
 WHERE a.request_id     = 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.process_status = 'PRSD_ERROR'
   AND a.status_desc LIKE '%NullPoint%'
;

UPDATE batch_replace_keep_exp_date a
   SET a.process_status = 'WAITING'
 WHERE a.request_id     = 'Ninja ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD')
   AND a.process_status = 'IN_PROGRESS'
;
