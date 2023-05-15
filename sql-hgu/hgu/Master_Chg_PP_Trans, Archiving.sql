--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.arch_master_chg_pp_trans
  SELECT * FROM master_chg_pp_trans a
    WHERE a.process_status NOT IN ('WAITING', 'IN_PROGRESS', 'ON_HOLD')
      AND a.request_time < TRUNC(SYSDATE);

COMMIT;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== ...and remove the copied rows.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
DELETE FROM master_chg_pp_trans a
  WHERE a.process_status NOT IN ('WAITING', 'IN_PROGRESS', 'ON_HOLD')
    AND a.request_time < TRUNC(SYSDATE);

COMMIT;

