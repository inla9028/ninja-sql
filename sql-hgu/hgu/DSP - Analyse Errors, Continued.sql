SELECT b.customer_id AS "BAN"
     , b.link_type
     , b.subscriber_no
     , a.adr_first_name, a.adr_last_name, 
       a.adr_birth_date, a.adr_street_name, a.adr_house_no, a.adr_house_letter,
       a.adr_city, a.adr_zip, a.adr_country, a.adr_gender, a.dsp_id AS "PERSON_ID",
       a.process_time, a.process_status, REPLACE (
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
  FROM dsp_response a, dsp_request b
 WHERE a.process_status = 'PRSD_ERROR'
   AND a.process_time   > TRUNC(SYSDATE - 7)
   AND a.status_desc LIKE 'no%'
   AND a.request_id = b.request_id
--   AND ROWNUM           < 101
ORDER BY 1,2,3,a.process_time
;


SELECT status_desc, COUNT(1) AS "COUNT"
FROM (
SELECT REPLACE (
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
  FROM dsp_response a
 WHERE a.process_status = 'PRSD_ERROR'
   AND a.process_time   > TRUNC(SYSDATE - 7)
   AND a.status_desc LIKE 'no%'
--   AND ROWNUM           < 101
)
GROUP BY status_desc
ORDER BY status_desc
;


SELECT COUNT(1) AS "COUNT"
FROM (
SELECT REPLACE (
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
  FROM dsp_response a
 WHERE a.process_status = 'PRSD_ERROR'
   AND a.process_time   > TRUNC(SYSDATE - 7)
   AND a.status_desc LIKE 'no%'
--   AND ROWNUM           < 101
)
;

