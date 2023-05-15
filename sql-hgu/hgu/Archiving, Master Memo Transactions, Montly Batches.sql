--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO MEMO
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('2014-07', 'YYYY-MM') AND TO_DATE('2014-08', 'YYYY-MM')
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('2014-07', 'YYYY-MM') AND TO_DATE('2014-08', 'YYYY-MM')
;

COMMIT WORK;
