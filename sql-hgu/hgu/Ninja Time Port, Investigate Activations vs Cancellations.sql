SELECT a.ninja_ref_id, a.nrdb_ref_id, a.user_id, a.ctn, a.ban,
       a.number_owner_code, a.donor_code, a.recipient_code,
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.description, a.action, a.proc_attempts, a.status,
       a.ninja_action, a.dealer_code, a.sales_agent
  FROM ninja_time_port a
 WHERE a.ctn = '047'||'46664509'
 ORDER BY a.date_time_port
;

SELECT a.ninja_ref_id, a.nrdb_ref_id, a.user_id, a.ctn,
       a.action AS "ACTION_A", a.ninja_action AS "NINJA_ACTION_A", a.date_time_port AS "DATE_TIME_PORT_A", a.status AS "STATUS_A",
       b.action AS "ACTION_B", b.ninja_action AS "NINJA_ACTION_B", b.date_time_port AS "DATE_TIME_PORT_B", b.status AS "STATUS_B"
     -- a.*
     --, b.*
  FROM ninja_time_port a, ninja_time_port b
 WHERE a.action = 'MOVE'
   AND a.status = 'WAITING'
   AND a.date_time_port > TRUNC(SYSDATE - 3)
   AND a.ctn    = b.ctn
   AND b.action = 'CANC'
   AND b.date_time_port > TRUNC(SYSDATE - 3)
   AND a.user_id NOT IN ('PhoneroOnline')
--   AND b.date_time_port >= a.date_time_port
   AND b.date_time_port <= a.date_time_port
--   AND to_char(a.date_time_port, 'YYYY-MM-DD HH24') = to_char(b.date_time_port, 'YYYY-MM-DD HH24')
ORDER BY a.date_time_port
;

SELECT b.*
  FROM ninja_time_port a, ninja_time_port b
 WHERE a.action = 'MOVE' 
   AND a.status = 'WAITING'
   AND a.date_time_port > TRUNC(SYSDATE - 3)
   AND a.ctn    = b.ctn
   AND b.action = 'CANC'
   AND b.date_time_port > TRUNC(SYSDATE - 3)
   AND a.user_id NOT IN ('PhoneroOnline')
--   AND to_char(a.date_time_port, 'YYYY-MM-DD HH24') = to_char(b.date_time_port, 'YYYY-MM-DD HH24')
ORDER BY a.ctn, a.ninja_ref_id
;

UPDATE ninja_time_port a
   SET a.date_time_port = a.date_time_port + (1 / 24)
 WHERE a.action = 'CANC'
   AND a.status = 'WAITING'
   AND a.user_id NOT IN ('PhoneroOnline')
;
