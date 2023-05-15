--==
SELECT a.company_name, a.action_code, a.pni_type, a.member_count,
       a.request_id, a.process_status, a.status_desc, a.pni_code,
       a.enter_time, a.request_time, a.process_time
  FROM batch_pni_creation a
 WHERE a.process_status IN ('WAITING', 'PRSD_ERROR')
 ORDER BY ROWID
;


--==
--== Display the (request id's of the) waiting records...
--==
SELECT a.action_code, a.pni_type, a.request_id, COUNT(*) AS "COUNT"
  FROM batch_pni_creation a
 WHERE a.process_status = 'WAITING'
 GROUP BY a.action_code, a.pni_type, a.request_id
 ORDER BY a.action_code, a.pni_type, a.request_id;

--==
--== Display the status of the running job/request.
--==
SELECT a.request_id, a.action_code, a.pni_type, a.process_status, COUNT(*) AS "COUNT"
  FROM batch_pni_creation a
 WHERE a.request_id IN ('LAH 2018-11-13')
 GROUP BY a.request_id, a.action_code, a.pni_type, a.process_status
 ORDER BY a.request_id, a.action_code, a.pni_type, a.process_status
;

SELECT a.request_id, a.process_status, count(1) AS "COUNT"
  FROM batch_pni_creation a
 WHERE a.request_id IN ('LAH 2018-11-13')
GROUP BY a.request_id, a.process_status
ORDER by a.request_id, a.process_status
;

SELECT a.company_name, a.action_code, a.pni_type, a.member_count,
       a.request_id, a.process_status, REPLACE (
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
       a.pni_code, a.enter_time, a.request_time, a.process_time
  FROM batch_pni_creation a
 WHERE a.request_id IN ('LAH 2018-11-13')
;

SELECT a.company_name AS "RQ_NAME", a.pni_type AS "RQ_TYPE", a.pni_code AS "RQ_CODE"
     , a.member_count AS "RQ_MEMBERS", a.request_id AS "RQ_ID", a.process_status AS "RQ_STATUS"
     , a.process_time AS "RQ_DATE"
     , b.pnp_desc AS "FOKUS_NAME", b.pni_type AS "FOKUS_TYPE", b.pni AS "FOKUS_CODE"
     , b.max_members AS "FOKUS_MEMBERS", b.sys_creation_date AS "FOKUS_DATE"
  FROM batch_pni_creation a, pnp@fokus b
 WHERE a.request_id    IN ('LAH 2018-11-13')
   AND a.process_status = 'PRSD_ERROR'
   AND a.pni_type       = RTRIM(b.pni_type)
   AND a.pni_code       = RTRIM(b.pni)
   AND UPPER(b.pnp_desc) NOT LIKE UPPER(SUBSTR(a.company_name, 0, LEAST(40, LENGTH(a.company_name)))) || '%'
ORDER BY a.pni_code
;
