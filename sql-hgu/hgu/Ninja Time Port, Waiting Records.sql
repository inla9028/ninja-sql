--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List all records due for processing today.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ninja_ref_id, a.nrdb_ref_id, a.user_id, a.ctn, a.ban,
       a.number_owner_code, a.donor_code, a.recipient_code,
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.description, a.action, a.proc_attempts, a.status,
       a.ninja_action
  FROM ninjadata.ninja_time_port a
 WHERE a.date_time_port BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE + 1)
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List all type of port-in's due for processing today.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.donor_code, a.recipient_code, a.action, a.ninja_action, COUNT(*) AS "COUNT"
  FROM ninjadata.ninja_time_port a
 WHERE a.date_time_port BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE + 1)
GROUP BY a.donor_code, a.recipient_code, a.action, a.ninja_action
ORDER BY a.donor_code, a.recipient_code, a.action, a.ninja_action
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the date & time of all future registered port-in's
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_CHAR(a.date_time_port, 'YYYY-MM-DD HH24') || ':00-59' AS "DATE_TIME_PORT",
       a.ninja_action, COUNT(*) AS "COUNT"
  FROM ninjadata.ninja_time_port a
 WHERE a.status = 'WAITING'
GROUP BY TO_CHAR(a.date_time_port, 'YYYY-MM-DD HH24') || ':00-59', a.ninja_action
ORDER BY "DATE_TIME_PORT", a.ninja_action
;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List all records for a given subscriber.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.ninja_ref_id, a.nrdb_ref_id, a.user_id, a.ctn, a.ban,
       a.number_owner_code, a.donor_code, a.recipient_code,
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.description, a.action, a.proc_attempts, a.status,
       a.ninja_action
  FROM ninjadata.ninja_time_port a
 WHERE a.ctn    = '047' || '46355649'
--   AND a.status = 'WAITING'
ORDER BY a.ninja_ref_id
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the portings made yesterday, and the delay between the porting-
--== and process-time...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT ntp.*
  FROM ninja_time_port ntp
 WHERE ntp.action = 'MOVE'
   AND ntp.date_time_port BETWEEN TO_DATE('2016-05-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS')
                              AND TO_DATE('2016-05-11 10:00:01', 'YYYY-MM-DD HH24:MI:SS')
--   AND ntp.date_time_port BETWEEN TRUNC(SYSDATE - 1) AND TRUNC(SYSDATE)
--ORDER BY ntp.date_time_port
ORDER BY 1
;

SELECT ntp.proc_attempts, count(1) AS "COUNT"
  FROM ninja_time_port ntp
 WHERE ntp.action = 'MOVE'
   AND ntp.date_time_port BETWEEN TO_DATE('2016-05-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS')
                              AND TO_DATE('2016-05-11 10:00:01', 'YYYY-MM-DD HH24:MI:SS')
--   AND ntp.date_time_port BETWEEN TRUNC(SYSDATE - 1) AND TRUNC(SYSDATE)
--ORDER BY ntp.date_time_port
GROUP BY ntp.proc_attempts
ORDER BY ntp.proc_attempts
;
  
