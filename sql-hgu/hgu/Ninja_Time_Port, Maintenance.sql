SELECT a.ninja_ref_id, a.nrdb_ref_id, a.user_id, a.ctn, a.ban,
       a.number_owner_code, a.donor_code, a.recipient_code,
       a.date_time_created, a.date_time_modified, a.date_time_port,
       a.description, a.action, a.proc_attempts, a.status,
       a.ninja_action
  FROM ninjadata.ninja_time_port a
  WHERE a.date_time_created > TO_DATE('2007-11-23', 'YYYY-MM-DD')
    AND a.nrdb_ref_id = '8170000000000'
--    AND a.user_id = 'Chess2'
--    AND a.donor_code = 701

--
SELECT a.status, a.date_time_port, COUNT(*) AS "COUNT"
  FROM ninjadata.ninja_time_port a
  WHERE a.date_time_created > TO_DATE('2007-11-22', 'YYYY-MM-DD')
    AND a.nrdb_ref_id = '8170000000000'
  GROUP BY a.status, a.date_time_port

--
UPDATE ninjadata.ninja_time_port a
  SET a.status = 'WAITING', a.date_time_modified = SYSDATE, a.description = NULL,
      a.date_time_port = TO_DATE('2007-11-28 01:00', 'YYYY-MM-DD HH24:MI')
  WHERE a.date_time_created > TO_DATE('2007-11-22', 'YYYY-MM-DD')
    AND a.nrdb_ref_id = '8170000000000'
    AND a.status = 'PRSD_ERROR'
  
