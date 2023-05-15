--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
INSERT INTO ninjadata.arch_batch_adjustment_addition
  SELECT * FROM ninjadata.batch_adjustment_addition a
    WHERE a.process_status       != 'WAITING'
      AND a.record_creation_date  < TRUNC(SYSDATE);

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== ...and remove the copied rows.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
DELETE FROM ninjadata.batch_adjustment_addition a
  WHERE a.process_status       != 'WAITING'
    AND a.record_creation_date  < TRUNC(SYSDATE);

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Rebuild the indexes of the tables etc.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

-- *** BEFORE RUNNING THESE INDEX REBUILDS: make sure nobody has added any new 
--     indexes. If they have, add a rebuild here. (Not doing so seems to cause 
--     all sorts of problems.

ALTER TABLE batch_adjustment_addition MOVE TABLESPACE ninja_data1;
ALTER INDEX batch_adj_add_uix REBUILD;
ALTER INDEX batch_adjustment_addition_ix69 REBUILD;
ALTER INDEX batch_adjustment_addition_ix90 REBUILD;
ALTER INDEX batch_adjustment_addition_ix99 REBUILD;

COMMIT WORK;


