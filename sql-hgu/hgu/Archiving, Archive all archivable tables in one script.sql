--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== ADJUSTMENTS ADJUSTMENTS ADJUSTMENTS ADJUSTMENTS ADJUSTMENTS ADJUSTMENTS
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_batch_adjustment_addition
  SELECT * FROM ninjadata.batch_adjustment_addition a
    WHERE a.process_status       != 'WAITING'
      AND a.record_creation_date  < TRUNC(SYSDATE);

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.batch_adjustment_addition a
  WHERE a.process_status       != 'WAITING'
    AND a.record_creation_date  < TRUNC(SYSDATE);

COMMIT WORK;

--== Rebuild the indexes of the tables etc.
ALTER TABLE batch_adjustment_addition MOVE TABLESPACE ninja_data1;
ALTER INDEX batch_adj_add_uix REBUILD;
ALTER INDEX batch_adjustment_addition_ix69 REBUILD;
ALTER INDEX batch_adjustment_addition_ix90 REBUILD;
ALTER INDEX batch_adjustment_addition_ix99 REBUILD;

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== CHARGES CHARGES CHARGES CHARGES CHARGES CHARGES CHARGES CHARGES CHARGES
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_batch_charge_addition
  SELECT * FROM ninjadata.batch_charge_addition a
    WHERE a.process_status       != 'WAITING'
      AND a.record_creation_date  < TRUNC(SYSDATE - 31);

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.batch_charge_addition a
  WHERE a.process_status       != 'WAITING'
    AND a.record_creation_date  < TRUNC(SYSDATE - 31);

COMMIT WORK;

--== Rebuild the indexes of the tables etc.
--- ALTER TABLE batch_charge_addition MOVE TABLESPACE data; -- Testing in dev
ALTER TABLE batch_charge_addition MOVE TABLESPACE ninja_blob1;
ALTER INDEX batch_charge_addition_pk REBUILD;
ALTER INDEX batch_chg_add_idx4 REBUILD;
ALTER INDEX bat_chg_add_idx2 REBUILD;
ALTER INDEX batch_charge_addition_1ix REBUILD;
ALTER INDEX batch_charge_addition_ix99 REBUILD;
ALTER INDEX batch_charge_addition_req_time REBUILD; -- New 2020-08-07

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== CHANGE_PP CHANGE_PP CHANGE_PP CHANGE_PP CHANGE_PP CHANGE_PP CHANGE_PP
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_chg_pp_trans
  SELECT * FROM master_chg_pp_trans a
    WHERE a.process_status NOT IN ('WAITING', 'IN_PROGRESS', 'ON_HOLD')
      AND a.request_time < TRUNC(SYSDATE);

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM master_chg_pp_trans a
  WHERE a.process_status NOT IN ('WAITING', 'IN_PROGRESS', 'ON_HOLD')
    AND a.request_time < TRUNC(SYSDATE);

COMMIT WORK;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== SERVICES SERVICES SERVICES SERVICES SERVICES SERVICES SERVICES SERVICES
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_service_transactions
  SELECT * FROM service_transactions a
    WHERE a.process_status != 'WAITING'
      AND a.process_time    < TRUNC(SYSDATE);

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM service_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.process_time    < TRUNC(SYSDATE);

COMMIT WORK;

/*
--== As of March 2015, this is archived by a batch-job at 04:00 every day...
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
    --WHERE a.process_status IN ('EXCLUDED', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_FATAL', 'EXPIRED')
   WHERE a.process_status != 'WAITING'
     AND a.enter_time      < TRUNC(SYSDATE);

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  --WHERE a.process_status IN ('EXCLUDED', 'PRSD_SUCCESS', 'PRSD_ERROR', 'PRSD_FATAL', 'EXPIRED')
  WHERE a.process_status != 'WAITING'
    AND a.enter_time    < TRUNC(SYSDATE);

COMMIT WORK;
*/

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== STATUS STATUS STATUS STATUS STATUS STATUS STATUS STATUS STATUS STATUS
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_ninja_sub_change_status
  SELECT *
     FROM ninja_sub_change_status a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time      < TRUNC(SYSDATE);

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninja_sub_change_status a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time      < TRUNC(SYSDATE);

COMMIT WORK;

