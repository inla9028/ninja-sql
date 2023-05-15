--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.arch_ninja_sub_change_status
  SELECT * FROM ninja_sub_change_status a
    WHERE a.process_status != 'WAITING'
      AND a.process_time    < TRUNC(SYSDATE);

COMMIT;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== ...and remove the copied rows.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
DELETE FROM ninja_sub_change_status a
  WHERE a.process_status != 'WAITING'
    AND a.process_time    < TRUNC(SYSDATE);

COMMIT;
