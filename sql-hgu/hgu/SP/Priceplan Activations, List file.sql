--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Lists the records added from a specific file.
--== Note: Spaces in the filename should be URL encoded as '%20'.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.transaction_number, a.subscriber_no, a.sim_no, a.sp_code,
       a.priceplan, a.imei, a.process_status, a.process_time,
       a.status_desc, a.load_file_ref_id, a.add_mms_gprs
  FROM ninjadata.sp_pp_activations a
  WHERE a.load_file_ref_id = 'Chess-P-3981%20in.txt'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Lists status of the records added from a specific file.
--== Note: Spaces in the filename should be URL encoded as '%20'.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.process_status, COUNT(*) as "COUNT"
  FROM ninjadata.sp_pp_activations a
  WHERE a.load_file_ref_id = 'Chess-P-3981%20in.txt'
  GROUP BY a.process_status

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Re-process the records added from a specific file.
--== Note: Spaces in the filename should be URL encoded as '%20'.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.sp_pp_activations a
  SET a.process_status = 'WAITING', a.process_time = NULL, a.status_desc = NULL
  WHERE a.load_file_ref_id = 'Chess-P-3981%20in.txt'
    AND a.process_status   = 'PRSD_ERROR'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
