--== Display all running jobs, sort by the 'status_time' in order to see how
--== long they've been running...
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') AS "NOW", a.machine_id, a.job_id, a.job_status, -- a.was_running,
       LTRIM(TO_CHAR(a.sleep_time/60000, '00')) || ':' || LTRIM(TO_CHAR(MOD(a.sleep_time/1000, 60), '00')) AS "SLEEP_TIME",
--       TO_CHAR(a.sleep_time/60000, '00') AS "SLEEP_MIN", TO_CHAR(MOD(a.sleep_time/1000, 60), '00') AS "SLEEP_SEC", a.sleep_time, 
       TO_CHAR(a.next_exec_time, 'HH24:MI:SS') AS "NEXT_EXEC_TIME", TO_CHAR(a.status_time, 'HH24:MI:SS') AS "STATUS_TIME",
       --TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), 'HH24:MI:SS') AS "RUNTIME",
       LTRIM(TO_CHAR(TRUNC(SYSDATE - a.status_time), '00')) || TO_CHAR(TRUNC(SYSDATE) + (SYSDATE - a.status_time), ':HH24:MI:SS') AS "RUNTIME",
       /*a.status_desc,*/ a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.job_status = 'RUNNING'
  ORDER BY a.status_time, a.machine_id, a.exec_method;

--== Display the jobs running on a specific server that isn't stopped.
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.job_status != 'STOPPED'
--      AND a.machine_id  IN ('NINJAP1Z_DEMON', 'NINJAP2Z_DEMON')
--    AND a.machine_id  = 'NINJAP1Z_DEMON'
    AND a.machine_id  = 'NINJAP2Z_DEMON'
  ORDER BY a.job_id;

--== Display the jobs that has been running for more than 8 hours...
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.job_status  = 'RUNNING'
    AND a.status_time < SYSDATE - (1 / 3)
  ORDER BY a.machine_id, a.job_id;

--== Demon Master Control (All servers)
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'MASTER'
    AND a.job_id      = 0;

--== Master Manipulator (Stream 1)
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterManipulator'
    AND a.machine_id  = 'NINJAP2Z_DEMON'
    AND a.job_id      = 50


--== Master Manipulator (All streams but 1)
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterManipulator'
    AND a.machine_id  = 'NINJAP2Z_DEMON'
    AND a.job_id     IN (51, 52, 53, 54, 55, 56, 57, 58, 59)
  ORDER BY a.job_id


--== Process Time Porting
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'processTimePortings'
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 1

--== Batch Charge Addition (Stream 1 - 14)
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchChargeAddition'
    AND a.machine_id IN ('NINJAP1Z_DEMON', 'NINJAP2Z_DEMON') -- Stream 1 = P1, Stream 2-14 = P2
--    AND a.job_id      = 8               -- Stream 1
  ORDER BY a.job_id

--== Batch Adjustment Addition
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchAdjustmentAddition'
    AND a.machine_id  = 'NINJAP1Z_DEMON'
--    AND a.job_id      = 62

--== Batch Discount Addition
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchDiscountAddition'
    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 39

--== Batch Name & Address Change
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchNameAddressUpdate'
    AND a.machine_id  = 'NINJAP1Z_DEMON'
--    AND a.job_id      = 61

--== XLDB Master Transaction
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterXLDBProcessor'
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 3

--== Master Change Priceplan Transaction
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterPPChanger'
    AND a.machine_id  = 'NINJAP1Z_DEMON'
--    AND a.job_id      = 32

--== CDA/PBX activations
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchFixedLineActivator'
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 91

--== NetWeb Kontant Registration
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'kontantRegistration'
--    AND a.machine_id  = 'NINJAP1Z_DEMON'
--    AND a.job_id      = 100

--== SP Priceplan Activations
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'spActivationsByPriceplan'
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 127

--== Service Transactions
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('serviceManipulator', 'batchServiceTransactions')
    AND a.job_id      IN (40, 41)
    AND a.machine_id  = 'NINJAP2Z_DEMON'
  ORDER BY a.job_id;

--== TB Processing Trans
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'tbTransProcessing'
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 36

--== BanTreeManipulator
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'banTreeManipulator'
--    AND a.machine_id  = 'NINJAP1Z_DEMON'
--    AND a.job_id      = 37

--== BatchExtractPromotions
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchExtractPromotions'
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 60

--== BatchPublishLevelUpdate
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'batchPublishLevelUpdate'
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 61

--== SP_PP Activations
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'spActivationsByPriceplan'
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 27

--== Master Memo Creator
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'masterMemoCreator'
    AND a.machine_id  = 'NINJAP1Z_DEMON'
    AND a.job_id      = 76
    
--== Populate Dealer IMEI Duplicate Registrations
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'populateDlrImeiDuplicateRegister'
    AND a.machine_id  = 'NINJAP1Z_DEMON'
    AND a.job_id      = 52;

--== Batch Job to control dependencies of the IMEI jobs
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'dlrImeiBatchJobsControl'
    AND a.machine_id  = 'NINJAP1Z_DEMON'
    AND a.job_id      = 44;

--== Change TB Priceplan Transaction
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'tbTransProcessing'
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
--    AND a.job_id      = 36

--== Populate Service Transaction
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'populateServiceTransactions'
--    AND a.job_id      = 5
--    AND a.machine_id  = 'NINJAP2Z_DEMON'
  
--== Status manipulator
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'statusManipulator'
    AND a.job_id     IN (57, 58, 59)
--    AND a.machine_id  = 'NINJAP1Z_DEMON'

--== Late IMEI registration records
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'populateDlrImeiLateRegisterForPorting'
--    AND a.job_id      = 54
--    AND a.machine_id  = 'NINJAP1Z_DEMON'

--== Populate Porting Welcome SMS (sent 2 days prior to porting)
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'populateBatchNPActvWelcomeSMS'
--    AND a.job_id      = 50
--    AND a.machine_id  = 'NINJAP1Z_DEMON'

--== BBS File Processing (Register eFaktura)
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method = 'bbsFileProcessorRedesign'
--    AND a.job_id      = 23
    AND a.machine_id  = 'NINJAP1Z_DEMON'

--== IMEI-related jobs...
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('dlrImeiBatchJobsControl', 'populateDlrImeiLateRegisterForPorting')
    AND a.job_id      IN (44, 54)
    AND a.machine_id  = 'NINJAP1Z_DEMON';


--== NetWeb jobs...
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('gsmInfoHomeRunProcessor', 
                          'gsmInfoSMSPlussProcessor', 
                          'gsmInfoTrillingSIMProcessor', 
                          'gsmInfoWirelessFamilyProcessor', 
                          'informationManager', 
                          'kontantRegistration')
    AND a.job_id      IN (2, 4, 5, 6, 7, 96)
    AND a.machine_id  = 'NINJAP1Z_DEMON'
  ORDER BY a.machine_id, a.job_id;

--== Release old reserved numbers, etc.
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('numberReleaser', 
                          'numberReconciler')
--    AND a.job_id      IN (25, 30)
--    AND a.machine_id  = 'NINJAP1Z_DEMON'
  ORDER BY a.machine_id, a.job_id;

--== BatchFixedLineActivator (cda_batch_activations)
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.exec_method IN ('batchFixedLineActivator')
    AND a.job_id      IN (91)
    AND a.machine_id  = 'NINJAP2Z_DEMON';


