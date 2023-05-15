SELECT a.requestor_id, a.process_status, a.new_priceplan, a.new_campaign_code, COUNT(*) AS "COUNT",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((COUNT(*) * 0.829) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((COUNT(*) * 0.829) / 60, 60), '9999999'))) || ' min' AS "QUEUE"
  FROM batch_change_priceplan a
 WHERE a.requestor_id = 'AFD ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD')
GROUP BY a.requestor_id, a.process_status, a.new_priceplan, a.new_campaign_code
ORDER BY a.requestor_id, a.process_status, a.new_priceplan, a.new_campaign_code
;

SELECT a.requestor_id,
       a.subscriber_no,
       a.old_priceplan,
       a.new_priceplan,
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
  FROM batch_change_priceplan a
 WHERE a.requestor_id IN ('AFD ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD'))
   AND a.process_status = 'PRSD_ERROR'
ORDER BY "STATUS_DESC", a.requestor_id, a.subscriber_no
;

--==
--==
--==
SELECT a.requestor_id, a.process_status,
       REPLACE( RTRIM (
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
  FROM batch_change_priceplan a
 WHERE a.requestor_id   IN ('AFD ' || TO_CHAR(SYSDATE - 1, 'YYYY-MM-DD'))
   AND a.process_status = 'PRSD_ERROR'
GROUP BY a.requestor_id, a.process_status, REPLACE(RTRIM(SUBSTR(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')), INSTR(SUBSTR(a.status_desc, 0, INSTR(a.status_desc || ' [ID', ' [ID')), 'Exception: '))), 'Exception: ', '')
ORDER BY 4 DESC
;
