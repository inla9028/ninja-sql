--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--==
--== Note!!!
--== Make sure the 'masterMemoCreator' job isn't running while using this SQL!!!!
--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Exclude all records where the Memo text is shorter than 45 characters
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_memo_transactions a
  SET a.process_status = 'EXCLUDED', a.process_time = SYSDATE,
      a.status_desc = 'Excluded by HGU (LENGTH(a.memo_text) < 45)'
  WHERE a.exclude_ind       = 'T'
    AND a.process_status    = 'WAITING'
    AND LENGTH(a.memo_text) < 45;

COMMIT;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Exclude all records that doesn't require a memo to be created.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
UPDATE ninjadata.master_memo_transactions a
  SET a.process_status = 'EXCLUDED', a.process_time = SYSDATE,
      a.status_desc = 'Excluded by HGU (no match in ninjaconfig.sms_messages)'
  WHERE a.exclude_ind    = 'T'
    AND a.process_status = 'WAITING'
--    AND a.enter_time     > TRUNC(SYSDATE)
    AND NOT EXISTS (
      SELECT '' FROM ninjaconfig.sms_messages b
        WHERE INSTR(a.memo_text, SUBSTR(b.msg_text, 1, 45)) != 0
    );

COMMIT;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT * FROM ninjadata.master_memo_transactions a
    --WHERE a.process_status IN ('EXCLUDED', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_FATAL', 'EXPIRED')
    WHERE a.process_status != 'WAITING'
      AND a.enter_time      < TRUNC(SYSDATE);

COMMIT;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== ...and remove the copied rows.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
DELETE FROM ninjadata.master_memo_transactions a
  --WHERE a.process_status IN ('EXCLUDED', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_FATAL', 'EXPIRED')
  WHERE a.process_status != 'WAITING'
    AND a.enter_time    < TRUNC(SYSDATE);

COMMIT;

