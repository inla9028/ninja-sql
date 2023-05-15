/*
** List all NEW operations since deployment
*/
SELECT a.nrdb_ref_id, a.user_id, a.ctn, 
       a.donor_code, a.recipient_code,
       a.date_time_created, a.date_time_port,
       a.action, a.status,a.proc_attempts
  FROM ninja_time_port a
 WHERE a.date_time_port    > TO_DATE('2018-11-28 21:00', 'YYYY-MM-DD HH24:MI')
   AND a.date_time_created > TO_DATE('2018-11-28 21:00', 'YYYY-MM-DD HH24:MI')
   AND a.action            = 'NEW'
ORDER BY date_time_port ASC
;
/*
** List overdue operations...
*/
SELECT a.nrdb_ref_id, a.user_id, a.ctn, 
       a.donor_code, a.recipient_code,
       a.date_time_created,
       a.date_time_port - (a.proc_attempts / 1440) AS "ORIG_TIME_PORT",
       a.date_time_port,
       a.action, a.status,a.proc_attempts
  FROM ninja_time_port a
 WHERE a.date_time_port    > TO_DATE('2018-11-28 21:00', 'YYYY-MM-DD HH24:MI')
   AND a.date_time_created > TO_DATE('2018-11-28 21:00', 'YYYY-MM-DD HH24:MI')
   AND a.action            = 'NEW'
   AND a.status            = 'WAITING'
   AND a.proc_attempts    != 0
ORDER BY date_time_port ASC
;

