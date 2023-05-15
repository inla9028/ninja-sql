SELECT a.*
  FROM ninja_jobs a
 WHERE a.exec_method IN ('masterManipulator', 'batchMasterTransactions')
   AND a.machine_id = 'NINJAP2_DEMON'
;

UPDATE ninja_jobs a
   SET a.job_status = 'STOPPING'
 WHERE a.exec_method IN ('masterManipulator', 'batchMasterTransactions')
   AND a.machine_id = 'NINJAP2_DEMON'
;

UPDATE ninja_jobs a
--   SET a.exec_method = 'batchMasterTransactions'
   SET a.exec_method = 'masterManipulator'
 WHERE a.exec_method IN ('masterManipulator', 'batchMasterTransactions')
   AND a.machine_id = 'NINJAP2_DEMON'
;

UPDATE ninja_jobs a
   SET a.job_status = 'STARTING', a.next_exec_time = SYSDATE
 WHERE a.exec_method IN ('masterManipulator', 'batchMasterTransactions')
   AND a.machine_id = 'NINJAP2_DEMON'
;
