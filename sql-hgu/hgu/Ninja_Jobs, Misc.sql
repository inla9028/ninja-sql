--== Display all running jobs, sort by the 'status_time' in order to see how
--== long they've been running...
SELECT a.machine_id, a.job_id, a.job_status, -- a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
--       TO_CHAR(a.sleep_time/60000, '00') AS "SLEEP_MIN", TO_CHAR(MOD(a.sleep_time/1000, 60), '00') AS "SLEEP_SEC", a.sleep_time, 
       TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", 
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME",
       --TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), 'HH24:MI:SS') AS "RUNTIME",
       LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME",
       /*a.status_desc,*/ a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninja_jobs a
 WHERE a.job_status = 'RUNNING'
    OR (a.job_id = 0 AND a.machine_id IN ('NINJAP1_DEMON', 'NINJAP2_DEMON'))
ORDER BY a.status_time, a.machine_id, a.exec_method
;

--== Display the jobs running on a specific server that isn't stopped.
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME",
       a.status_desc, a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE a.job_status != 'STOPPED'
   AND a.machine_id  IN ('NINJAP1_DEMON', 'NINJAP2_DEMON')
--  AND a.machine_id  = 'NINJAP1_DEMON'
--  AND a.machine_id  = 'NINJAP2_DEMON'
ORDER BY a.job_status DESC, a.job_id;


--== Start the job, if not already active (i.e. STOPPED)
UPDATE ninjaconfig.ninja_jobs a
--   SET a.job_status = 'STARTING', a.next_exec_time = TRUNC(SYSDATE)
   SET a.next_exec_time = TRUNC(SYSDATE)
 WHERE  a.machine_id = 'NINJAP2_DEMON' AND a.job_id = 61 AND a.exec_method = 'batchPublishLevelUpdate'
-- WHERE  a.machine_id = 'NINJAP2_DEMON' AND a.job_id = 80 AND a.exec_method IN ('batchSubscriberMover')
;

--== Stop the job in question...
UPDATE ninjaconfig.ninja_jobs a
   SET a.job_status = 'STOPPING'
  WHERE  a.machine_id = 'NINJAP2_DEMON' AND a.job_id IN ( 40 ) AND a.exec_method IN ( 'serviceManipulator' )
;

--== Display the jobs that has been running for more than 8 hours...
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.job_status  = 'RUNNING'
    AND TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME" < SYSDATE - (1 / 3)
  ORDER BY a.machine_id, a.job_id;

--== Demon Master Control (All servers)
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'MASTER'
    AND a.job_id      = 0;

--== Master Manipulator (Stream 1)
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterManipulator'
    AND a.machine_id  = 'NINJAP2_DEMON'
    AND a.job_id      = 50
;

--== Master Manipulator (All streams but 1)
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterManipulator'
    AND a.machine_id  = 'NINJAP2_DEMON'
    AND a.job_id     IN (51, 52, 53, 54, 55, 56, 57, 58, 59)
  ORDER BY a.job_id
;

--== Process Time Porting
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method LIKE 'processTimePortings%'
   AND a.machine_id  = 'NINJAP2_DEMON'
--   AND a.job_id      = 1
;

--== Batch Charge Addition (Stream 1 - 14)
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchChargeAddition'
    AND a.machine_id IN ('NINJAP1_DEMON', 'NINJAP2_DEMON') -- Stream 1 = P1, Stream 2-14 = P2
--    AND a.job_id      = 8               -- Stream 1
  ORDER BY a.job_id
;

--== Batch Adjustment Addition
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchAdjustmentAddition'
    AND a.machine_id  = 'NINJAP1_DEMON'
--    AND a.job_id      = 62

--== Batch Discount Addition
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchDiscountAddition'
    AND a.machine_id  = 'NINJAP2_DEMON'
--    AND a.job_id      = 39
;

--== Batch Name & Address Change
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchNameAddressUpdate'
    AND a.machine_id  = 'NINJAP1_DEMON'
--    AND a.job_id      = 61
;

--== XLDB Master Transaction
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterXLDBProcessor'
--    AND a.machine_id  = 'NINJAP2_DEMON'
--    AND a.job_id      = 3
;

--== Master Change Priceplan Transaction
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterPPChanger'
--    AND a.machine_id  = 'NINJAP1_DEMON'
--    AND a.job_id      = 32
;
--== CDA/PBX activations
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchFixedLineActivator'
--    AND a.machine_id  = 'NINJAP2_DEMON'
--    AND a.job_id      = 91
;

--== NetWeb Kontant Registration
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'kontantRegistration'
--    AND a.machine_id  = 'NINJAP1_DEMON'
--    AND a.job_id      = 100
;

--== SP Priceplan Activations
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'spActivationsByPriceplan'
--    AND a.machine_id  = 'NINJAP2_DEMON'
--    AND a.job_id      = 127
;

--== Service Transactions
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('serviceManipulator', 'batchServiceTransactions')
    AND a.job_id      IN (40, 41)
    AND a.machine_id  = 'NINJAP2_DEMON'
  ORDER BY a.job_id
;

--== TB Processing Trans
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'tbTransProcessing'
--    AND a.machine_id  = 'NINJAP2_DEMON'
--    AND a.job_id      = 36

--== BanTreeManipulator
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'banTreeManipulator'
--    AND a.machine_id  = 'NINJAP1_DEMON'
--    AND a.job_id      = 37

--== BatchExtractPromotions
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchExtractPromotions'
--    AND a.machine_id  = 'NINJAP2_DEMON'
--    AND a.job_id      = 60
;

--== BatchPublishLevelUpdate
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchPublishLevelUpdate'
--    AND a.machine_id  = 'NINJAP2_DEMON'
--    AND a.job_id      = 61
;
--== SP_PP Activations
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'spActivationsByPriceplan'
--    AND a.machine_id  = 'NINJAP2_DEMON'
--    AND a.job_id      = 27
;

--== Master Memo Creator
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ( 'batchMemoCreator', 'masterMemoCreator' )
    AND a.machine_id  = 'NINJAP1_DEMON'
    AND a.job_id      = 76
;    
--== Populate Dealer IMEI Duplicate Registrations
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'populateDlrImeiDuplicateRegister'
    AND a.machine_id  = 'NINJAP1_DEMON'
    AND a.job_id      = 52;

--== Batch Job to control dependencies of the IMEI jobs
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'dlrImeiBatchJobsControl'
    AND a.machine_id  = 'NINJAP1_DEMON'
    AND a.job_id      = 44;

--== Change TB Priceplan Transaction
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'tbTransProcessing'
--    AND a.machine_id  = 'NINJAP2_DEMON'
--    AND a.job_id      = 36
;
--== Populate Service Transaction
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'populateServiceTransactions'
--    AND a.job_id      = 5
--    AND a.machine_id  = 'NINJAP2_DEMON'
;
  
--== Status manipulator
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'statusManipulator'
    AND a.job_id     IN (57, 58, 59)
--    AND a.machine_id  = 'NINJAP1_DEMON'
;

--== Late IMEI registration records
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'populateDlrImeiLateRegisterForPorting'
--    AND a.job_id      = 54
--    AND a.machine_id  = 'NINJAP1_DEMON'
;

--== Populate Porting Welcome SMS (sent 2 days prior to porting)
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'populateBatchNPActvWelcomeSMS'
--    AND a.job_id      = 50
--    AND a.machine_id  = 'NINJAP1_DEMON'
;

--== BBS File Processing (Register eFaktura)
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'bbsFileProcessorRedesign'
--    AND a.job_id      = 23
    AND a.machine_id  = 'NINJAP1_DEMON'
;

--== IMEI-related jobs...
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('dlrImeiBatchJobsControl', 'populateDlrImeiLateRegisterForPorting')
    AND a.job_id      IN (44, 54)
    AND a.machine_id  = 'NINJAP1_DEMON';


--== NetWeb jobs...
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('gsmInfoHomeRunProcessor', 
                          'gsmInfoSMSPlussProcessor', 
                          'gsmInfoTrillingSIMProcessor', 
                          'gsmInfoWirelessFamilyProcessor', 
                          'informationManager', 
                          'kontantRegistration')
    AND a.job_id      IN (2, 4, 5, 6, 7, 96)
    AND a.machine_id  = 'NINJAP1_DEMON'
  ORDER BY a.machine_id, a.job_id;

--== Release old reserved numbers, etc.
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('numberReleaser', 
                          'numberReconciler')
--    AND a.job_id      IN (25, 30)
    AND a.machine_id  = 'NINJAP1_DEMON'
  ORDER BY a.machine_id, a.job_id;

--== BatchFixedLineActivator (cda_batch_activations)
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('batchFixedLineActivator')
    AND a.job_id      IN (91)
    AND a.machine_id  = 'NINJAP2_DEMON';

--== Batch Move Subscriber
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME", TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('batchSubscriberMover')
    AND a.job_id      IN (80)
    AND a.machine_id  = 'NINJAP2_DEMON';

--== Batch IMEI addition...
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME",
       TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('batchImeiAddition')
    AND a.job_id      IN (2)
    AND a.machine_id  = 'NINJAP2_DEMON';


-- Number Porting Activations...
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time AS "ORIG_SLEEP",
       TO_CHAR(LTRIM(a.sleep_time/3600000, '0000')) AS "SLEEP_HOURS",
       TO_CHAR(a.sleep_time/60000, '0000') AS "SLEEP_MIN",
       TO_CHAR(MOD(a.sleep_time/1000, 60), '00') AS "SLEEP_SEC",
       LTRIM(TO_CHAR(a.sleep_time/60000, '0000')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME",
       TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('NPActiviBatchJobsControl')
    AND a.job_id      IN (45)
    AND a.machine_id  = 'NINJAP1_DEMON';

--== Batch-sending of SMSes via a table in Ninja DB.
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME",
       TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method IN ('batchSendSMS')
   AND a.job_id      IN (69)
   AND a.machine_id  = 'NINJAP2_DEMON'
;

--== BAN status changes.
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, -- a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME",
       LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME",
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method = 'batchBansHandler'
   AND a.machine_id  IN ('NINJAP1_DEMON', 'NINJAP2_DEMON')
ORDER BY a.status_time, a.machine_id, a.exec_method
;

--== Porting activities
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME",
       TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", -- a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method IN (
         'NPActiviBatchJobsControl'
       , 'populateBatchNPActvWelcomeSMS'
       , 'processNPActivities'
       , 'processNPTimeCancellations'
       , 'processTimePortingActivations'
       , 'processTimePortingsParallel'
       , 'processTimePortingConfirmations'
     ) AND a.machine_id  IN ('NINJAP1_DEMON', 'NINJAP2_DEMON')
ORDER BY a.exec_method
;

--== DMS / Commission updates
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME",
       TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", -- a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method IN ( 'dmsUpdates', 'populateDlrImeiLateRegister', 'dlrImeiLateRegisterUpdate', 'populateDlrImeiDuplicateRegister' )
   AND a.machine_id  IN ( 'NINJAP1_DEMON', 'NINJAP2_DEMON' )
ORDER BY a.job_id   
;

SELECT a.*
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method IN ( 'dmsUpdates', 'populateDlrImeiLateRegister', 'dlrImeiLateRegisterUpdate', 'populateDlrImeiDuplicateRegister' )
   AND a.machine_id  IN ( 'NINJAP1_DEMON', 'NINJAP2_DEMON' )
ORDER BY a.job_id   
;

SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME",
       TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME", -- a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
 WHERE a.exec_method IN ( 'processChangeRatingAndSocs' )
   AND a.machine_id  IN ( 'NINJAP2_DEMON' )
ORDER BY a.job_id   
;

SELECT a.*
  FROM ninja_jobs a
 WHERE a.exec_method IN ( 'processChangeRatingAndSocs' )
   AND a.machine_id  IN ( 'NINJAP2_DEMON' )
ORDER BY a.job_id   
;

