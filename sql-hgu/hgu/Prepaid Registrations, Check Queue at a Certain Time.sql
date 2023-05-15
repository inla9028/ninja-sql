SELECT to_char(A.record_creation_date, 'YYYY-MM-DD HH24:MI:SS')              AS "REQUEST_TIME"
     , to_char(A.process_time,         'YYYY-MM-DD HH24:MI:SS')              AS "PROCESS_TIME"
     , TO_CHAR((a.process_time - A.record_creation_date) * (24*60*60), '00') AS "DELAY_SECONDS"
  FROM batch_name_address_update A
 WHERE A.process_time BETWEEN to_date('2021-03-25 13:30', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2021-03-25 14:00', 'YYYY-MM-DD HH24:MI')
;


SELECT to_char(A.record_creation_date, 'YYYY-MM-DD HH24:MI:SS')              AS "REQUEST_TIME"
     , to_char(A.process_time,         'YYYY-MM-DD HH24:MI:SS')              AS "PROCESS_TIME"
     , TO_CHAR((a.process_time - A.record_creation_date) * (24*60*60), '00') AS "DELAY_SECONDS"
  FROM batch_name_address_update A
 WHERE A.process_time BETWEEN to_date('2021-04-21 11:00', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2021-04-21 12:30', 'YYYY-MM-DD HH24:MI')
;

SELECT to_char(A.record_creation_date, 'YYYY-MM-DD HH24:MI:SS')              AS "REQUEST_TIME"
     , to_char(A.process_time,         'YYYY-MM-DD HH24:MI:SS')              AS "PROCESS_TIME"
     , TO_CHAR((a.process_time - A.record_creation_date) * (24*60*60), '00') AS "DELAY_SECONDS"
  FROM batch_name_address_update A
 WHERE A.process_time BETWEEN to_date('2021-04-23 14:00', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2021-04-23 15:10', 'YYYY-MM-DD HH24:MI')
;

SELECT to_char(A.record_creation_date, 'YYYY-MM-DD HH24:MI:SS')              AS "REQUEST_TIME"
     , to_char(A.process_time,         'YYYY-MM-DD HH24:MI:SS')              AS "PROCESS_TIME"
     , TO_CHAR((a.process_time - A.record_creation_date) * (24*60*60), '00') AS "DELAY_SECONDS"
  FROM batch_name_address_update A
 WHERE A.process_time BETWEEN to_date('2021-10-13 14:30', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2021-10-13 15:10', 'YYYY-MM-DD HH24:MI')
;

SELECT TO_CHAR(a.record_creation_date, 'YYYY-MM-DD HH24:MI:SS')              AS "REQUEST_TIME"
     , TO_CHAR(a.process_time,         'YYYY-MM-DD HH24:MI:SS')              AS "PROCESS_TIME"
     , TO_CHAR((a.process_time - a.record_creation_date) * (24*60*60), '00') AS "DELAY_SECONDS"
  FROM batch_name_address_update a
 WHERE a.process_time BETWEEN TO_DATE('2021-10-19 18:00', 'YYYY-MM-DD HH24:MI')
                          AND TO_DATE('2021-10-19 18:45', 'YYYY-MM-DD HH24:MI')
;

SELECT to_char(A.record_creation_date, 'YYYY-MM-DD HH24:MI:SS')              AS "REQUEST_TIME"
     , to_char(A.process_time,         'YYYY-MM-DD HH24:MI:SS')              AS "PROCESS_TIME"
     , TO_CHAR((a.process_time - A.record_creation_date) * (24*60*60), '00') AS "DELAY_SECONDS"
  FROM batch_name_address_update A
 WHERE A.record_creation_date > trunc(SYSDATE)
;