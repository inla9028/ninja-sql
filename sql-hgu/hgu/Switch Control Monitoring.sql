--==
--== Check the current status of the queues, according to Ninja.
--== According to Staffan, each transaction takes 300 ms in switch-control...
--==
SELECT a.queue_name, a.queue_size AS "SIZE", a.queue_capacity AS "CAPACITY",
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((a.queue_size * 0.300) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((a.queue_size * 0.300) / 60, 60), '9999999'))) || ' min' AS "QUEUE_TIME",
       a.lower_threshold AS "LOWER", a.upper_threshold AS "UPPER", a.update_interval AS "INTERVAL",
       TO_CHAR(a.last_update_date, 'HH24:MI:SS') AS "LAST_UPDATED",
       TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", 
       TO_CHAR(a.last_update_date + (a.update_interval / 86400), 'HH24:MI:SS') AS "NEXT_UPDATE",  
       a.description
  FROM switch_control_monitoring a
ORDER BY a.queue_name
;


SELECT a.queue_name, a.queue_size, a.queue_capacity,
       TO_NUMBER(LTRIM(TO_CHAR(FLOOR((a.queue_size * 0.300) / 3600), '9999999'))) || ' hours ' ||
       TO_NUMBER(LTRIM(TO_CHAR(MOD((a.queue_size * 0.300) / 60, 60), '9999999'))) || ' min' AS "QUEUE_TIME",
       a.lower_threshold, a.upper_threshold, a.switch_phd_id, a.switch_priority,
       a.update_interval, a.last_update_date, TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.description
  FROM switch_control_monitoring a
ORDER BY a.queue_name
;

SELECT a.queue_name, a.queue_size, a.queue_capacity, a.lower_threshold,
       a.upper_threshold, a.switch_phd_id, a.switch_priority,
       a.update_interval, a.last_update_date, a.description
  FROM switch_control_monitoring a
ORDER BY a.queue_name
;

/*
Marv (fokus user_id =100) is going now to its own queue (SWITCH_PHD_ID), so it moved from hlri to hlr3.
Priority is not used for marv user, all trx have the same priority 30.
We introduced a new table SC_THREAD_CONF that tell which user goes to which thread (phd_id = hlr || thread_id).

SC_THREAD_CONF
USER_ID              THREAD_ID         PRIORITY
100                         3                              30

*/

/*
** The "query" used within Ninja towards Fokus...
*/
SELECT COUNT(1) AS "QUEUE_SIZE"
  FROM q3
 WHERE phd_id    = '${SWITCH_PHD_ID}'
   AND priority IN (${SWITCH_PRIORITY});

-- Test MARV...
SELECT COUNT(1) AS "QUEUE_SIZE"
  FROM q3@fokus
 WHERE phd_id    = 'hlr3'
   AND priority IN (30)
;


SELECT * -- COUNT(1) AS "QUEUE_SIZE"
  FROM q3@fokus
 WHERE phd_id    = 'hlr2'
   AND priority IN (30)
;


SELECT phd_id, priority, COUNT(1) AS "QUEUE_SIZE"
  FROM q3@fokus
 WHERE phd_id    = 'hlr2'
   AND priority IN (30)
GROUP BY phd_id, priority
ORDER BY phd_id, priority
;

