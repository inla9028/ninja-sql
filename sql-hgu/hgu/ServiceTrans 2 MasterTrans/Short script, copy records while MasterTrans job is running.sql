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

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== In order to be able to run this job more than once a day, update the
--== request id's of the currently processed records, to the current time.
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


