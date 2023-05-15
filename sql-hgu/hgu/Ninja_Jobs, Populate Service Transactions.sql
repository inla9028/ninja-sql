SELECT a.*
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method = 'populateServiceTransactions'
   AND a.job_id      = 5
   AND a.machine_id  = 'NINJAP2Z_DEMON'
;

UPDATE ninja_jobs a
--   SET a.next_exec_time = to_date('2012-07-04 04:00', 'YYYY-MM-DD HH24:MI')
   SET a.next_exec_time = TO_DATE(TO_CHAR(TRUNC(SYSDATE) + 1), 'YYYY-MM-DD') || ' 04:00', 'YYYY-MM-DD HH24:MI')
       '2012-07-04 04:00', 'YYYY-MM-DD HH24:MI')
     , a.fixed_start    = 'Y'
 WHERE a.exec_method = 'populateServiceTransactions'
   AND a.job_id      = 5
   AND a.machine_id  = 'NINJAP2Z_DEMON'
;
