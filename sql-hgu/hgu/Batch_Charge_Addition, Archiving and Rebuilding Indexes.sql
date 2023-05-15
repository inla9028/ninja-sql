--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.arch_batch_charge_addition
  SELECT * FROM ninjadata.batch_charge_addition a
    WHERE a.process_status       != 'WAITING'
      AND a.record_creation_date  < TRUNC(SYSDATE);

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== ...and remove the copied rows.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
DELETE FROM ninjadata.batch_charge_addition a
  WHERE a.process_status       != 'WAITING'
    AND a.record_creation_date  < TRUNC(SYSDATE);

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Rebuild the indexes of the tables etc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

-- *** BEFORE RUNNING THESE INDEX REBUILDS: make sure nobody has added any new 
--     indexes. If they have, add a rebuild here. (Not doing so seems to cause 
--     all sorts of problems.

--- ALTER TABLE batch_charge_addition MOVE TABLESPACE data; -- Testing in dev
ALTER TABLE batch_charge_addition MOVE TABLESPACE ninja_blob1;
ALTER INDEX batch_charge_addition_pk REBUILD;
ALTER INDEX batch_chg_add_idx4 REBUILD;
ALTER INDEX bat_chg_add_idx2 REBUILD;
ALTER INDEX batch_charge_addition_1ix REBUILD;
-- GLL: New index. I added this line on 31/01/2008:
ALTER INDEX batch_charge_addition_ix99 REBUILD;

COMMIT WORK;


