--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.arch_service_transactions
  SELECT * FROM service_transactions a
    WHERE a.process_status != 'WAITING'
      AND a.process_time    < TRUNC(SYSDATE);

COMMIT;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== ...and remove the copied rows.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
DELETE FROM service_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.process_time    < TRUNC(SYSDATE);

COMMIT;

