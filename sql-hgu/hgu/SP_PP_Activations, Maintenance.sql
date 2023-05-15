--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the files currently processing. ==--==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.load_file_ref_id, COUNT(*) AS "COUNT"
  FROM ninjadata.sp_pp_activations a
  WHERE a.process_status = 'WAITING'
  GROUP BY a.load_file_ref_id
  ORDER BY a.load_file_ref_id

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the files processed during the last two days. --==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.load_file_ref_id, COUNT(*) AS "COUNT"
  FROM ninjadata.sp_pp_activations a
  WHERE a.process_time > SYSDATE - 2
  GROUP BY a.load_file_ref_id
  ORDER BY a.load_file_ref_id

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Locate the correct file by check the name without suffix. =--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.load_file_ref_id, COUNT(*) AS "COUNT"
  FROM ninjadata.sp_pp_activations a
  WHERE a.load_file_ref_id like 'po-NCLO-P-4408.%'
  GROUP BY a.load_file_ref_id
  ORDER BY a.load_file_ref_id

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records for a specific file. ==--==--==--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.subscriber_no, a.sim_no, a.sp_code,
       a.priceplan, a.imei, a.process_status, a.process_time,
       a.status_desc, a.load_file_ref_id, a.add_mms_gprs
  FROM ninjadata.sp_pp_activations a
  WHERE a.load_file_ref_id IN ('po-NCLO-P-4408.IN.CSV')
    AND a.process_status   = 'PRSD_ERROR'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status' of the records associated with the specified file. --==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.load_file_ref_id, a.process_status, COUNT(*) AS "COUNT"
  FROM ninjadata.sp_pp_activations a
  WHERE a.load_file_ref_id IN ('po-NCLO-P-4408.IN.CSV')
  GROUP BY a.load_file_ref_id, a.process_status
  ORDER BY a.load_file_ref_id, a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the status' of the records associated with the specified file, --==
--== and an estimate (in hours and minutes) of the remaining time...        --==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) AS "COUNT",
       SUBSTR(COUNT(*)/23/60, 0, 6) AS "Hours, or", 
       SUBSTR(COUNT(*)/23, 0, 6) AS "Minutes"
  FROM ninjadata.sp_pp_activations a
  WHERE a.load_file_ref_id IN ('po-NCLO-P-4408.IN.CSV')
  GROUP BY a.process_status
  ORDER BY a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Reset the status (and thereby re-run) the records =--==--==--==--==--==--==
--== that failed due to the lack of activation BANs.   =--==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.sp_pp_activations a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  WHERE a.load_file_ref_id IN ('po-NCLO-P-4408.IN.CSV')
    AND a.process_status   = 'PRSD_ERROR'
    AND (a.status_desc LIKE '%BAN number cannot be null%'
      OR a.status_desc LIKE '%Has Status [AG]%'
    )

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the time of the first- and last processed records. --==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT MIN(a.process_time) AS "FIRST_PROCESSED", MAX(a.process_time) AS "LAST_PROCESSED"
  FROM ninjadata.sp_pp_activations a
  WHERE a.load_file_ref_id IN ('po-NCLO-P-4408.IN.CSV')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the number of processed records per minute. -==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT to_char(a.process_time, 'YYYY-MM-DD HH24:MI') AS time, COUNT(*) AS "COUNT"
  FROM ninjadata.sp_pp_activations a
  WHERE a.load_file_ref_id IN ('po-NCLO-P-4408.IN.CSV')
  GROUP BY to_char(a.process_time, 'YYYY-MM-DD HH24:MI')

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the records for a specific file, with trimmed error. ==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.subscriber_no, a.load_file_ref_id, RTRIM(substr(a.status_desc, 0, INSTR(a.status_desc, ' [ID'))) AS "STATUS_DESC"
  FROM ninjadata.sp_pp_activations a
  WHERE a.load_file_ref_id IN ('po-NCLO-P-4408.IN.CSV')
    AND a.process_status   = 'PRSD_ERROR'
--    AND a.status_desc NOT LIKE '%Has Status [AG]%'
  ORDER BY a.subscriber_no

