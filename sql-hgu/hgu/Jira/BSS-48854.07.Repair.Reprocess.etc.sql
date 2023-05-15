SELECT A.*
  FROM batch_tpid_extract A
 WHERE A.request_time   > trunc(SYSDATE)
   AND A.process_status = 'PRSD_ERROR'
ORDER BY A.request_time
;

SELECT A.ban, A.subscriber_no, A.link_type, A.request_id, A.process_time
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (A.status_desc,
                           0,
                           INSTR (A.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (A.status_desc,
                               0,
                               INSTR (A.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM batch_tpid_extract A
 WHERE 1 = 1
   AND A.request_time   > trunc(sysdate)
--   AND A.request_time   > to_date('2021-04-07', 'YYYY-MM-DD')
--   A.request_time   > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')
   AND A.process_status = 'PRSD_ERROR'
--   AND A.status_desc LIKE '%PhoneNumber%'
--   AND A.status_desc LIKE '%I/O%'
--   AND A.status_desc LIKE '%mail%'
ORDER BY A.request_time
;

SELECT
       A.ban,
       'INSERT INTO batch_name_update (ban, subscriber_no, link_type, chg_birth_date, birth_date, name_type, requestor_id, process_status) VALUES (' || A.ban || ', ''' || A.subscriber_no || ''', ''' || A.link_type || ''', ''Y'', TO_DATE(''19' || to_char(anl.birth_date, 'YY-MM-DD') || ''', ''YYYY-MM-DD''), ''' || nd.name_format || ''', ''HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') || ''', ''WAITING'');' AS "SQL1"
     , 'UPDATE batch_tpid_extract tu SET tu.process_status = ''WAITING'', tu.process_time = NULL, tu.status_desc = NULL where tu.rowid = ''' || A.ROWID || ''';' AS "SQL2"
  FROM batch_tpid_extract      A
     , address_name_link@fokus anl
     , name_data@fokus         nd
 WHERE 1 = 1
   AND A.request_time   > trunc(SYSDATE)
--   AND A.request_time   > to_date('2021-04-07', 'YYYY-MM-DD')
--   AND A.request_time   > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')
   AND A.process_status = 'PRSD_ERROR'
--   AND A.status_desc LIKE '%The date%not properly formatted%'
--   AND A.status_desc LIKE '%birth date year%'
   AND A.status_desc LIKE '%date%'
   AND anl.ban          = A.ban
   AND anl.link_type    = A.link_type
   AND SYSDATE    BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
--   AND TO_NUMBER(TO_CHAR(anl.birth_date, 'YYYY')) < 200
   AND TO_NUMBER(TO_CHAR(anl.birth_date, 'YYYY')) BETWEEN 100 AND 1901
   AND anl.name_id      = nd.name_id
ORDER BY A.request_time
;

UPDATE batch_tpid_extract A
   SET A.process_status = 'WAITING'
     , A.process_time   = NULL
     , A.status_desc    = NULL
 WHERE 1 = 1
   AND A.request_time   > trunc(SYSDATE)
--   AND A.request_time   > to_date('2021-04-07', 'YYYY-MM-DD')
--   AND A.request_time   > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')
   AND A.process_status = 'PRSD_ERROR'
--   AND A.status_desc LIKE '%PhoneNumber%'
   AND A.status_desc LIKE '%I/O%'
--   AND A.status_desc LIKE '%email%'
--   AND A.status_desc LIKE '%countryCode%'
;



SELECT
       A.ban,
       'INSERT INTO batch_tpid_update (ban, subscriber_no, link_type, tpid, request_id, process_status) VALUES (' || A.ban || ', ''' || A.subscriber_no || ''', ''' || A.link_type || ''', NULL, ''HGU ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') || ''', ''WAITING'');' AS "SQL1"
     , 'UPDATE batch_tpid_extract tu SET tu.process_status = ''WAITING'', tu.process_time = NULL, tu.status_desc = NULL where tu.rowid = ''' || A.ROWID || ''';' AS "SQL2"
  FROM batch_tpid_extract      A
     , address_name_link@fokus anl
     , name_data@fokus         nd
 WHERE 1 = 1
   AND A.request_time   > trunc(SYSDATE)
--   AND A.request_time   > to_date('2021-04-07', 'YYYY-MM-DD')
--   AND A.request_time   > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')
   AND A.process_status = 'PRSD_ERROR'
   AND A.status_desc LIKE '%Entity Not Found%'
   AND anl.ban          = A.ban
   AND anl.link_type    = A.link_type
   AND SYSDATE    BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
--   AND TO_NUMBER(TO_CHAR(anl.birth_date, 'YYYY')) < 200
--   AND TO_NUMBER(TO_CHAR(anl.birth_date, 'YYYY')) BETWEEN 100 AND 1901
   AND anl.name_id      = nd.name_id
ORDER BY A.request_time
;




---


SELECT A.*
  FROM batch_tpid_update A
 WHERE 1 = 1
   AND A.request_time   > trunc(SYSDATE)
--   AND A.request_time   > to_date('2021-04-07', 'YYYY-MM-DD')
--   A.request_time   > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')
   AND A.process_status = 'PRSD_ERROR'
ORDER BY A.request_time
;

SELECT A.ban, A.subscriber_no, A.link_type, A.tpid, A.request_id
     , REPLACE (
           RTRIM (
               SUBSTR (
                   SUBSTR (A.status_desc,
                           0,
                           INSTR (A.status_desc || ' [ID', ' [ID')),
                   INSTR (
                       SUBSTR (A.status_desc,
                               0,
                               INSTR (A.status_desc || ' [ID', ' [ID')),
                       'Exception: '))), 'Exception: ', '')
           AS "STATUS_DESC"
  FROM batch_tpid_update A
 WHERE 1 = 1
   AND A.request_time   > trunc(SYSDATE)
--   AND A.request_time   > to_date('2021-04-07', 'YYYY-MM-DD')
--   A.request_time   > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')
   AND A.process_status = 'PRSD_ERROR'
ORDER BY A.request_time
;

SELECT 'UPDATE name_data@fokus nd SET nd.id_type = NULL WHERE nd.name_id = ' || nd.name_id || ';' AS "SQL1"
     , 'UPDATE batch_tpid_update tu SET tu.process_status = ''WAITING'', tu.process_time = NULL, tu.status_desc = NULL where tu.rowid = ''' || a.rowid || ''';' AS "SQL2"
  FROM batch_tpid_update       A
     , address_name_link@fokus anl
     , name_data@fokus         nd
 WHERE 1 = 1
   AND A.request_time   > trunc(SYSDATE)
--   AND A.request_time   > to_date('2021-04-07', 'YYYY-MM-DD')
--   A.request_time   > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')
   AND A.process_status = 'PRSD_ERROR'
   AND A.status_desc LIKE '%Illegal value of ID type. Value: COMP.%'
   AND anl.ban          = A.ban
   AND anl.link_type    = A.link_type
   AND SYSDATE      BETWEEN anl.effective_date AND nvl(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id        = nd.name_id
ORDER BY A.request_time
;

--== Reprocess 404s.
INSERT INTO batch_tpid_update (ban, subscriber_no, link_type, tpid, request_id, request_time, process_status)
WITH my_filter AS (SELECT A.ban, substr(A.status_desc, instr(A.status_desc, '''''') + 2, 36) AS "TPID"
                     FROM batch_tpid_extract A
                    WHERE A.process_status = 'PRSD_ERROR'
                      AND A.request_time   > trunc(SYSDATE)
                      AND A.status_desc LIKE '%404%')
SELECT /*+ driving_site(anl)*/
       anl.ban
     , decode(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
     , anl.link_type, '@' AS "TPID"
     , 'HGU 2021-04-29'   AS "REQUEST_ID"
     , trunc(sysdate)     AS "REQUEST_TIME"
     , 'ON_HOLD' AS "PROCESS_STATUS"  
  FROM cdata.address_name_link@wh12p anl
     , cdata.name_data@wh12p         nd
     , my_filter                     mf
 WHERE nd.tpid       = mf.tpid
   AND nd.name_id    = anl.name_id
   AND anl.ban       = mf.ban
   AND SYSDATE BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
ORDER BY 1,2,3
;

SELECT A.request_id, A.process_status, count(1) as "COUNT"
  FROM batch_tpid_update A
 WHERE A.request_id = 'HGU 2021-04-29'
GROUP BY A.request_id, A.process_status
ORDER BY A.request_id, A.process_status
;

UPDATE batch_tpid_update A
   SET A.process_status = 'WAITING'
 WHERE A.request_id     = 'HGU 2021-04-29'
   AND A.process_status = 'ON_HOLD'
;

UPDATE batch_tpid_extract A
   SET A.process_status = 'WAITING'
 WHERE A.process_status = 'PRSD_ERROR'
   AND A.request_time   > trunc(SYSDATE)
   AND A.status_desc LIKE '%404%'
;

--==
--== Reprocess certain TPID updates.
--==
UPDATE batch_tpid_update A
   SET A.process_status = 'WAITING'
     , A.process_time   = NULL
     , A.status_desc    = NULL
 WHERE 1 = 1
   AND A.request_time   > trunc(SYSDATE)
--   AND A.request_time   > to_date('2021-04-07', 'YYYY-MM-DD')
--   AND A.request_time   > to_date('2021-03-30 09:40', 'YYYY-MM-DD HH24:MI')
   AND A.process_status = 'PRSD_ERROR'
   AND A.status_desc LIKE '%Illegal nationality%'
;



--== Populate manually...
INSERT INTO batch_tpid_extract
SELECT /*+ driving_site(a)*/
       ban, subscriber_no, link_type, comp_reg_id
     , 'HGU 2021-04-29' AS "REQUEST_ID"
     , NULL             AS "REQUEST_TIME"
     , 'ON_HOLD'        AS "PROCESS_STATUS"
     , NULL             AS "PROCESS_TIME"
     , NULL             AS "STATUS_DESC"
     
  FROM (
    SELECT a.ban
         , a.link_type
         , DECODE(a.subscriber_no, '0000000000', NULL, a.subscriber_no) AS "SUBSCRIBER_NO"
         , a.comp_reg_id
      FROM cdata.get_tpid_null@wh12p a
     WHERE A.account_type IN ( 'I' )
    ORDER BY a.sys_creation_date ASC
  )
 WHERE ROWNUM + 1 - 1 < 10001
;


SELECT A.request_id, A.process_status, count(1) as "COUNT"
  FROM batch_tpid_extract A
 WHERE A.request_id = 'HGU 2021-04-29'
GROUP BY A.request_id, A.process_status
ORDER BY A.request_id, A.process_status
;

UPDATE batch_tpid_extract A
   SET A.process_status = 'WAITING'
 WHERE A.request_id     = 'HGU 2021-04-29'
   AND A.process_status = 'ON_HOLD'
   AND 0                = (SELECT count(1)
                             FROM batch_tpid_extract b
                            WHERE b.ban           = A.ban
                              AND b.subscriber_no = A.subscriber_no
                              AND b.link_type     = A.link_type
                              AND b.request_id   != A.request_id
                              AND b.request_time  > trunc(SYSDATE))
;
