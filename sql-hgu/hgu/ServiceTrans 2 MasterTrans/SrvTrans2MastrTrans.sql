--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the Master- & Service-transaction jobs.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT SYSDATE as "NOW", a.machine_id, a.job_id, a.job_status, a.was_running,
       a.sleep_time, a.next_exec_time, a.status_time, a.status_desc,
       a.exec_method, a.job_desc, a.fixed_start, a.hlr_based
  FROM ninjaconfig.ninja_jobs a
  WHERE a.machine_id  = 'NINJAP2Z_DEMON'
    AND ((a.exec_method = 'serviceManipulator' AND a.job_id = 40)
      OR (a.exec_method = 'masterManipulator'  AND a.job_id = 50));

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Stop the Service-transaction job.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STOPPING'
  WHERE a.machine_id  = 'NINJAP2Z_DEMON'
    AND a.exec_method = 'serviceManipulator'
    AND a.job_id      = 40
    AND a.job_status NOT IN ('STOPPING', 'STOPPED');

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Set the currently waiting to a temporary status --==--==--==--==--==--==--=
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.service_transactions a
  SET a.process_status = 'TRANSFER', 
      a.status_desc    = 'TRANSFER ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD'), 
	  a.process_time   = SYSDATE
  WHERE a.process_status = 'WAITING';

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy all waiting entries from service_transactions, into
--== ninjadata.master_transactions and spread the stream-id in based on the GSM.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.master_transactions (
    TRANS_NUMBER, SUBSCRIBER_NO, SOC, ACTION_CODE, NEW_SOC, ENTER_TIME,
    REQUEST_TIME, PROCESS_TIME, PROCESS_STATUS, STATUS_DESC, DEALER_CODE,
    SALES_AGENT, PRIORITY, REQUEST_ID, MEMO_TEXT,
    STREAM
  )
  SELECT
      NULL, b.subscriber_no, b.soc, b.action_code, NULL, NULL,
      NULL, NULL, 'WAITING', NULL, NULL,
      NULL, b.priority, 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD'), NULL,
      DECODE(MOD(SUBSTR(b.subscriber_no, 4), 10) + 1, null, 1, MOD(SUBSTR(b.subscriber_no, 4), 10) + 1)
      FROM ninjadata.service_transactions b
      WHERE b.process_status = 'TRANSFER'
        AND b.status_desc    = 'TRANSFER ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
      ORDER BY b.priority, b.trans_number;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== In order to be able to run this job more than once a day, update the
--== request id's of the records we've copied in service_transactions, so that
--== we don't copy them again (by accident).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.service_transactions a
  SET   a.status_desc    = 'TRANSFER ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD HH24:MI')
  WHERE a.process_status = 'TRANSFER'
    AND a.status_desc    = 'TRANSFER ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD');

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start the Master transactions jobs.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STARTING', a.next_exec_time = TRUNC(SYSDATE)
  WHERE a.exec_method = 'masterManipulator'
    AND a.job_status IN ('STOPPED') -- Should only start the stopped processes?
    AND a.job_id IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59);

UPDATE ninjaconfig.ninja_jobs a
  SET a.next_exec_time = TRUNC(SYSDATE)
  WHERE a.exec_method = 'masterManipulator'
    AND a.job_status IN ('SLEEPING') -- Should only start the stopped processes?
    AND a.job_id IN (50, 51, 52, 53, 54, 55, 56, 57, 58, 59);

COMMIT WORK;


--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==
--== Now, go and monitor the jobs being processed in ninjadata.master_transactions,
--== it can be monitored using:
--== <http://subversion.netcom.no/ninja/branches/SQL/hgu/Master_Transactions, Batch-job.sql>
--== Once all records are processed, one must:
--== 1) Stop the additional threads handling ninjadata.master_transactions, and
--== 2) Start the Service Transactions job.
--==

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Monitor the jobs in ninjadata.master_transactions as they are processed.
--== Once no records has the status 'WAITING', go to the next step...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT TO_NUMBER(a.stream) AS "STREAM", a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.master_transactions a
  WHERE a.request_id     = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_status = 'WAITING'
  GROUP BY a.process_status, TO_NUMBER(a.stream)
  ORDER BY TO_NUMBER(a.stream), a.process_status;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Once no more records are waiting (see the step above); run the following
--== update. If any rows are updated, go back one step (above). If no rows are
--== updated, continue with the next step (down).
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
     , a.stream = '1'
  WHERE a.request_id      = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD')
    AND a.process_status  = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%No Jolt connections available%'
      OR a.status_desc LIKE '%Could not retrieve fokus dates%'
      OR a.status_desc LIKE '%Records have been updated since last retrieve%'
      OR a.status_desc LIKE '%Please try accessing account again later%'
      OR a.status_desc LIKE '%Tuxedo system exception occurred during the execution of the Tuxedo service: arGtBan00%'
    );
COMMIT WORK;
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Stop the additional Master transaction jobs.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STOPPING'
  WHERE a.exec_method = 'masterManipulator'
    AND a.job_status  IN ('RUNNING', 'SLEEPING') -- Should only stop the sleeping processes!
    AND a.job_id IN (51, 52, 53, 54, 55, 56, 57, 58, 59);

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Start the Service transactions job.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjaconfig.ninja_jobs a
  SET a.job_status = 'STARTING', a.next_exec_time = TRUNC(SYSDATE)
  WHERE a.machine_id  = 'NINJAP2Z_DEMON'
    AND (a.exec_method = 'serviceManipulator'  AND a.job_id = 40)
    AND a.job_status IN ('STOPPED');

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== In order to be able to run this job more than once a day, update the
--== request id's of the currently processed records, to the current time.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_transactions a
  SET   a.request_id = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD HH24:MI')
  WHERE a.request_id = 'TRANS ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD');

UPDATE ninjadata.service_transactions a
  SET   a.status_desc    = 'TRANSFER ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD HH24:MI')
  WHERE a.process_status = 'TRANSFER'
    AND a.status_desc    = 'TRANSFER ' || TO_CHAR(SYSDATE, 'YYYY.MM.DD');

COMMIT WORK;

--==
--== Give yourself a pat on the back, you've been a good boy (or if you're Ina - girl)!
--==
