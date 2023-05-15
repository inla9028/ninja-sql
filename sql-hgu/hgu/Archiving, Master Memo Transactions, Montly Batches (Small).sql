--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140701', 'YYYYMMDD') AND (TO_DATE('20140701', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140701', 'YYYYMMDD') AND (TO_DATE('20140701', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140702', 'YYYYMMDD') AND (TO_DATE('20140702', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140702', 'YYYYMMDD') AND (TO_DATE('20140702', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140703', 'YYYYMMDD') AND (TO_DATE('20140703', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140703', 'YYYYMMDD') AND (TO_DATE('20140703', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140704', 'YYYYMMDD') AND (TO_DATE('20140704', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140704', 'YYYYMMDD') AND (TO_DATE('20140704', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140705', 'YYYYMMDD') AND (TO_DATE('20140705', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140705', 'YYYYMMDD') AND (TO_DATE('20140705', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140706', 'YYYYMMDD') AND (TO_DATE('20140706', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140706', 'YYYYMMDD') AND (TO_DATE('20140706', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140707', 'YYYYMMDD') AND (TO_DATE('20140707', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140707', 'YYYYMMDD') AND (TO_DATE('20140707', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140708', 'YYYYMMDD') AND (TO_DATE('20140708', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140708', 'YYYYMMDD') AND (TO_DATE('20140708', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140709', 'YYYYMMDD') AND (TO_DATE('20140709', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140709', 'YYYYMMDD') AND (TO_DATE('20140709', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140710', 'YYYYMMDD') AND (TO_DATE('20140710', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140710', 'YYYYMMDD') AND (TO_DATE('20140710', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140711', 'YYYYMMDD') AND (TO_DATE('20140711', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140711', 'YYYYMMDD') AND (TO_DATE('20140711', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140712', 'YYYYMMDD') AND (TO_DATE('20140712', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140712', 'YYYYMMDD') AND (TO_DATE('20140712', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140713', 'YYYYMMDD') AND (TO_DATE('20140713', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140713', 'YYYYMMDD') AND (TO_DATE('20140713', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140714', 'YYYYMMDD') AND (TO_DATE('20140714', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140714', 'YYYYMMDD') AND (TO_DATE('20140714', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140715', 'YYYYMMDD') AND (TO_DATE('20140715', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140715', 'YYYYMMDD') AND (TO_DATE('20140715', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140716', 'YYYYMMDD') AND (TO_DATE('20140716', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140716', 'YYYYMMDD') AND (TO_DATE('20140716', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140717', 'YYYYMMDD') AND (TO_DATE('20140717', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140717', 'YYYYMMDD') AND (TO_DATE('20140717', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140718', 'YYYYMMDD') AND (TO_DATE('20140718', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140718', 'YYYYMMDD') AND (TO_DATE('20140718', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140719', 'YYYYMMDD') AND (TO_DATE('20140719', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140719', 'YYYYMMDD') AND (TO_DATE('20140719', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140720', 'YYYYMMDD') AND (TO_DATE('20140720', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140720', 'YYYYMMDD') AND (TO_DATE('20140720', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140721', 'YYYYMMDD') AND (TO_DATE('20140721', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140721', 'YYYYMMDD') AND (TO_DATE('20140721', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140722', 'YYYYMMDD') AND (TO_DATE('20140722', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140722', 'YYYYMMDD') AND (TO_DATE('20140722', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140723', 'YYYYMMDD') AND (TO_DATE('20140723', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140723', 'YYYYMMDD') AND (TO_DATE('20140723', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140724', 'YYYYMMDD') AND (TO_DATE('20140724', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140724', 'YYYYMMDD') AND (TO_DATE('20140724', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140725', 'YYYYMMDD') AND (TO_DATE('20140725', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140725', 'YYYYMMDD') AND (TO_DATE('20140725', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140726', 'YYYYMMDD') AND (TO_DATE('20140726', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140726', 'YYYYMMDD') AND (TO_DATE('20140726', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140727', 'YYYYMMDD') AND (TO_DATE('20140727', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140727', 'YYYYMMDD') AND (TO_DATE('20140727', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140728', 'YYYYMMDD') AND (TO_DATE('20140728', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140728', 'YYYYMMDD') AND (TO_DATE('20140728', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140729', 'YYYYMMDD') AND (TO_DATE('20140729', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140729', 'YYYYMMDD') AND (TO_DATE('20140729', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140730', 'YYYYMMDD') AND (TO_DATE('20140730', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140730', 'YYYYMMDD') AND (TO_DATE('20140730', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140731', 'YYYYMMDD') AND (TO_DATE('20140731', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140731', 'YYYYMMDD') AND (TO_DATE('20140731', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140801', 'YYYYMMDD') AND (TO_DATE('20140801', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140801', 'YYYYMMDD') AND (TO_DATE('20140801', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140802', 'YYYYMMDD') AND (TO_DATE('20140802', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140802', 'YYYYMMDD') AND (TO_DATE('20140802', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140803', 'YYYYMMDD') AND (TO_DATE('20140803', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140803', 'YYYYMMDD') AND (TO_DATE('20140803', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140804', 'YYYYMMDD') AND (TO_DATE('20140804', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140804', 'YYYYMMDD') AND (TO_DATE('20140804', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140805', 'YYYYMMDD') AND (TO_DATE('20140805', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140805', 'YYYYMMDD') AND (TO_DATE('20140805', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140806', 'YYYYMMDD') AND (TO_DATE('20140806', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140806', 'YYYYMMDD') AND (TO_DATE('20140806', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140807', 'YYYYMMDD') AND (TO_DATE('20140807', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140807', 'YYYYMMDD') AND (TO_DATE('20140807', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140808', 'YYYYMMDD') AND (TO_DATE('20140808', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140808', 'YYYYMMDD') AND (TO_DATE('20140808', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140809', 'YYYYMMDD') AND (TO_DATE('20140809', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140809', 'YYYYMMDD') AND (TO_DATE('20140809', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140810', 'YYYYMMDD') AND (TO_DATE('20140810', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140810', 'YYYYMMDD') AND (TO_DATE('20140810', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140811', 'YYYYMMDD') AND (TO_DATE('20140811', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140811', 'YYYYMMDD') AND (TO_DATE('20140811', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140812', 'YYYYMMDD') AND (TO_DATE('20140812', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140812', 'YYYYMMDD') AND (TO_DATE('20140812', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140813', 'YYYYMMDD') AND (TO_DATE('20140813', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140813', 'YYYYMMDD') AND (TO_DATE('20140813', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140814', 'YYYYMMDD') AND (TO_DATE('20140814', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140814', 'YYYYMMDD') AND (TO_DATE('20140814', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140815', 'YYYYMMDD') AND (TO_DATE('20140815', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140815', 'YYYYMMDD') AND (TO_DATE('20140815', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140816', 'YYYYMMDD') AND (TO_DATE('20140816', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140816', 'YYYYMMDD') AND (TO_DATE('20140816', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140817', 'YYYYMMDD') AND (TO_DATE('20140817', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140817', 'YYYYMMDD') AND (TO_DATE('20140817', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140818', 'YYYYMMDD') AND (TO_DATE('20140818', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140818', 'YYYYMMDD') AND (TO_DATE('20140818', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140819', 'YYYYMMDD') AND (TO_DATE('20140819', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140819', 'YYYYMMDD') AND (TO_DATE('20140819', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140820', 'YYYYMMDD') AND (TO_DATE('20140820', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140820', 'YYYYMMDD') AND (TO_DATE('20140820', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140821', 'YYYYMMDD') AND (TO_DATE('20140821', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140821', 'YYYYMMDD') AND (TO_DATE('20140821', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140822', 'YYYYMMDD') AND (TO_DATE('20140822', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140822', 'YYYYMMDD') AND (TO_DATE('20140822', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140823', 'YYYYMMDD') AND (TO_DATE('20140823', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140823', 'YYYYMMDD') AND (TO_DATE('20140823', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140824', 'YYYYMMDD') AND (TO_DATE('20140824', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140824', 'YYYYMMDD') AND (TO_DATE('20140824', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140825', 'YYYYMMDD') AND (TO_DATE('20140825', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140825', 'YYYYMMDD') AND (TO_DATE('20140825', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140826', 'YYYYMMDD') AND (TO_DATE('20140826', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140826', 'YYYYMMDD') AND (TO_DATE('20140826', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140827', 'YYYYMMDD') AND (TO_DATE('20140827', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140827', 'YYYYMMDD') AND (TO_DATE('20140827', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140828', 'YYYYMMDD') AND (TO_DATE('20140828', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140828', 'YYYYMMDD') AND (TO_DATE('20140828', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140829', 'YYYYMMDD') AND (TO_DATE('20140829', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140829', 'YYYYMMDD') AND (TO_DATE('20140829', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140830', 'YYYYMMDD') AND (TO_DATE('20140830', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140830', 'YYYYMMDD') AND (TO_DATE('20140830', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140831', 'YYYYMMDD') AND (TO_DATE('20140831', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140831', 'YYYYMMDD') AND (TO_DATE('20140831', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140901', 'YYYYMMDD') AND (TO_DATE('20140901', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140901', 'YYYYMMDD') AND (TO_DATE('20140901', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140902', 'YYYYMMDD') AND (TO_DATE('20140902', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140902', 'YYYYMMDD') AND (TO_DATE('20140902', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140903', 'YYYYMMDD') AND (TO_DATE('20140903', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140903', 'YYYYMMDD') AND (TO_DATE('20140903', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140904', 'YYYYMMDD') AND (TO_DATE('20140904', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140904', 'YYYYMMDD') AND (TO_DATE('20140904', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140905', 'YYYYMMDD') AND (TO_DATE('20140905', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140905', 'YYYYMMDD') AND (TO_DATE('20140905', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140906', 'YYYYMMDD') AND (TO_DATE('20140906', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140906', 'YYYYMMDD') AND (TO_DATE('20140906', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140907', 'YYYYMMDD') AND (TO_DATE('20140907', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140907', 'YYYYMMDD') AND (TO_DATE('20140907', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140908', 'YYYYMMDD') AND (TO_DATE('20140908', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140908', 'YYYYMMDD') AND (TO_DATE('20140908', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140909', 'YYYYMMDD') AND (TO_DATE('20140909', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140909', 'YYYYMMDD') AND (TO_DATE('20140909', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140910', 'YYYYMMDD') AND (TO_DATE('20140910', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140910', 'YYYYMMDD') AND (TO_DATE('20140910', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140911', 'YYYYMMDD') AND (TO_DATE('20140911', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140911', 'YYYYMMDD') AND (TO_DATE('20140911', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140912', 'YYYYMMDD') AND (TO_DATE('20140912', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140912', 'YYYYMMDD') AND (TO_DATE('20140912', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140913', 'YYYYMMDD') AND (TO_DATE('20140913', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140913', 'YYYYMMDD') AND (TO_DATE('20140913', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140914', 'YYYYMMDD') AND (TO_DATE('20140914', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140914', 'YYYYMMDD') AND (TO_DATE('20140914', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140915', 'YYYYMMDD') AND (TO_DATE('20140915', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140915', 'YYYYMMDD') AND (TO_DATE('20140915', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140916', 'YYYYMMDD') AND (TO_DATE('20140916', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140916', 'YYYYMMDD') AND (TO_DATE('20140916', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140917', 'YYYYMMDD') AND (TO_DATE('20140917', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140917', 'YYYYMMDD') AND (TO_DATE('20140917', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140918', 'YYYYMMDD') AND (TO_DATE('20140918', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140918', 'YYYYMMDD') AND (TO_DATE('20140918', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140919', 'YYYYMMDD') AND (TO_DATE('20140919', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140919', 'YYYYMMDD') AND (TO_DATE('20140919', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140920', 'YYYYMMDD') AND (TO_DATE('20140920', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140920', 'YYYYMMDD') AND (TO_DATE('20140920', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140921', 'YYYYMMDD') AND (TO_DATE('20140921', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140921', 'YYYYMMDD') AND (TO_DATE('20140921', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140922', 'YYYYMMDD') AND (TO_DATE('20140922', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140922', 'YYYYMMDD') AND (TO_DATE('20140922', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140923', 'YYYYMMDD') AND (TO_DATE('20140923', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140923', 'YYYYMMDD') AND (TO_DATE('20140923', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140924', 'YYYYMMDD') AND (TO_DATE('20140924', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140924', 'YYYYMMDD') AND (TO_DATE('20140924', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140925', 'YYYYMMDD') AND (TO_DATE('20140925', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140925', 'YYYYMMDD') AND (TO_DATE('20140925', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140926', 'YYYYMMDD') AND (TO_DATE('20140926', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140926', 'YYYYMMDD') AND (TO_DATE('20140926', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140927', 'YYYYMMDD') AND (TO_DATE('20140927', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140927', 'YYYYMMDD') AND (TO_DATE('20140927', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140928', 'YYYYMMDD') AND (TO_DATE('20140928', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140928', 'YYYYMMDD') AND (TO_DATE('20140928', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140929', 'YYYYMMDD') AND (TO_DATE('20140929', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140929', 'YYYYMMDD') AND (TO_DATE('20140929', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20140930', 'YYYYMMDD') AND (TO_DATE('20140930', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20140930', 'YYYYMMDD') AND (TO_DATE('20140930', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141001', 'YYYYMMDD') AND (TO_DATE('20141001', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141001', 'YYYYMMDD') AND (TO_DATE('20141001', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141002', 'YYYYMMDD') AND (TO_DATE('20141002', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141002', 'YYYYMMDD') AND (TO_DATE('20141002', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141003', 'YYYYMMDD') AND (TO_DATE('20141003', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141003', 'YYYYMMDD') AND (TO_DATE('20141003', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141004', 'YYYYMMDD') AND (TO_DATE('20141004', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141004', 'YYYYMMDD') AND (TO_DATE('20141004', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141005', 'YYYYMMDD') AND (TO_DATE('20141005', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141005', 'YYYYMMDD') AND (TO_DATE('20141005', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141006', 'YYYYMMDD') AND (TO_DATE('20141006', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141006', 'YYYYMMDD') AND (TO_DATE('20141006', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141007', 'YYYYMMDD') AND (TO_DATE('20141007', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141007', 'YYYYMMDD') AND (TO_DATE('20141007', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141008', 'YYYYMMDD') AND (TO_DATE('20141008', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141008', 'YYYYMMDD') AND (TO_DATE('20141008', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141009', 'YYYYMMDD') AND (TO_DATE('20141009', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141009', 'YYYYMMDD') AND (TO_DATE('20141009', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141010', 'YYYYMMDD') AND (TO_DATE('20141010', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141010', 'YYYYMMDD') AND (TO_DATE('20141010', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141011', 'YYYYMMDD') AND (TO_DATE('20141011', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141011', 'YYYYMMDD') AND (TO_DATE('20141011', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141012', 'YYYYMMDD') AND (TO_DATE('20141012', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141012', 'YYYYMMDD') AND (TO_DATE('20141012', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141013', 'YYYYMMDD') AND (TO_DATE('20141013', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141013', 'YYYYMMDD') AND (TO_DATE('20141013', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141014', 'YYYYMMDD') AND (TO_DATE('20141014', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141014', 'YYYYMMDD') AND (TO_DATE('20141014', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141015', 'YYYYMMDD') AND (TO_DATE('20141015', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141015', 'YYYYMMDD') AND (TO_DATE('20141015', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141016', 'YYYYMMDD') AND (TO_DATE('20141016', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141016', 'YYYYMMDD') AND (TO_DATE('20141016', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141017', 'YYYYMMDD') AND (TO_DATE('20141017', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141017', 'YYYYMMDD') AND (TO_DATE('20141017', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141018', 'YYYYMMDD') AND (TO_DATE('20141018', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141018', 'YYYYMMDD') AND (TO_DATE('20141018', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141019', 'YYYYMMDD') AND (TO_DATE('20141019', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141019', 'YYYYMMDD') AND (TO_DATE('20141019', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141020', 'YYYYMMDD') AND (TO_DATE('20141020', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141020', 'YYYYMMDD') AND (TO_DATE('20141020', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141021', 'YYYYMMDD') AND (TO_DATE('20141021', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141021', 'YYYYMMDD') AND (TO_DATE('20141021', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141022', 'YYYYMMDD') AND (TO_DATE('20141022', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141022', 'YYYYMMDD') AND (TO_DATE('20141022', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141023', 'YYYYMMDD') AND (TO_DATE('20141023', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141023', 'YYYYMMDD') AND (TO_DATE('20141023', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141024', 'YYYYMMDD') AND (TO_DATE('20141024', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141024', 'YYYYMMDD') AND (TO_DATE('20141024', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141025', 'YYYYMMDD') AND (TO_DATE('20141025', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141025', 'YYYYMMDD') AND (TO_DATE('20141025', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141026', 'YYYYMMDD') AND (TO_DATE('20141026', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141026', 'YYYYMMDD') AND (TO_DATE('20141026', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141027', 'YYYYMMDD') AND (TO_DATE('20141027', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141027', 'YYYYMMDD') AND (TO_DATE('20141027', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141028', 'YYYYMMDD') AND (TO_DATE('20141028', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141028', 'YYYYMMDD') AND (TO_DATE('20141028', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141029', 'YYYYMMDD') AND (TO_DATE('20141029', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141029', 'YYYYMMDD') AND (TO_DATE('20141029', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141030', 'YYYYMMDD') AND (TO_DATE('20141030', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141030', 'YYYYMMDD') AND (TO_DATE('20141030', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141031', 'YYYYMMDD') AND (TO_DATE('20141031', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141031', 'YYYYMMDD') AND (TO_DATE('20141031', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141101', 'YYYYMMDD') AND (TO_DATE('20141101', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141101', 'YYYYMMDD') AND (TO_DATE('20141101', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141102', 'YYYYMMDD') AND (TO_DATE('20141102', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141102', 'YYYYMMDD') AND (TO_DATE('20141102', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141103', 'YYYYMMDD') AND (TO_DATE('20141103', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141103', 'YYYYMMDD') AND (TO_DATE('20141103', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141104', 'YYYYMMDD') AND (TO_DATE('20141104', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141104', 'YYYYMMDD') AND (TO_DATE('20141104', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141105', 'YYYYMMDD') AND (TO_DATE('20141105', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141105', 'YYYYMMDD') AND (TO_DATE('20141105', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141106', 'YYYYMMDD') AND (TO_DATE('20141106', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141106', 'YYYYMMDD') AND (TO_DATE('20141106', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141107', 'YYYYMMDD') AND (TO_DATE('20141107', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141107', 'YYYYMMDD') AND (TO_DATE('20141107', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141108', 'YYYYMMDD') AND (TO_DATE('20141108', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141108', 'YYYYMMDD') AND (TO_DATE('20141108', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141109', 'YYYYMMDD') AND (TO_DATE('20141109', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141109', 'YYYYMMDD') AND (TO_DATE('20141109', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141110', 'YYYYMMDD') AND (TO_DATE('20141110', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141110', 'YYYYMMDD') AND (TO_DATE('20141110', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141111', 'YYYYMMDD') AND (TO_DATE('20141111', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141111', 'YYYYMMDD') AND (TO_DATE('20141111', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141112', 'YYYYMMDD') AND (TO_DATE('20141112', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141112', 'YYYYMMDD') AND (TO_DATE('20141112', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141113', 'YYYYMMDD') AND (TO_DATE('20141113', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141113', 'YYYYMMDD') AND (TO_DATE('20141113', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141114', 'YYYYMMDD') AND (TO_DATE('20141114', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141114', 'YYYYMMDD') AND (TO_DATE('20141114', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141115', 'YYYYMMDD') AND (TO_DATE('20141115', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141115', 'YYYYMMDD') AND (TO_DATE('20141115', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141116', 'YYYYMMDD') AND (TO_DATE('20141116', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141116', 'YYYYMMDD') AND (TO_DATE('20141116', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141117', 'YYYYMMDD') AND (TO_DATE('20141117', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141117', 'YYYYMMDD') AND (TO_DATE('20141117', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141118', 'YYYYMMDD') AND (TO_DATE('20141118', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141118', 'YYYYMMDD') AND (TO_DATE('20141118', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141119', 'YYYYMMDD') AND (TO_DATE('20141119', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141119', 'YYYYMMDD') AND (TO_DATE('20141119', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141120', 'YYYYMMDD') AND (TO_DATE('20141120', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141120', 'YYYYMMDD') AND (TO_DATE('20141120', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141121', 'YYYYMMDD') AND (TO_DATE('20141121', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141121', 'YYYYMMDD') AND (TO_DATE('20141121', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141122', 'YYYYMMDD') AND (TO_DATE('20141122', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141122', 'YYYYMMDD') AND (TO_DATE('20141122', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141123', 'YYYYMMDD') AND (TO_DATE('20141123', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141123', 'YYYYMMDD') AND (TO_DATE('20141123', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141124', 'YYYYMMDD') AND (TO_DATE('20141124', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141124', 'YYYYMMDD') AND (TO_DATE('20141124', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141125', 'YYYYMMDD') AND (TO_DATE('20141125', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141125', 'YYYYMMDD') AND (TO_DATE('20141125', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141126', 'YYYYMMDD') AND (TO_DATE('20141126', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141126', 'YYYYMMDD') AND (TO_DATE('20141126', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141127', 'YYYYMMDD') AND (TO_DATE('20141127', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141127', 'YYYYMMDD') AND (TO_DATE('20141127', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141128', 'YYYYMMDD') AND (TO_DATE('20141128', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141128', 'YYYYMMDD') AND (TO_DATE('20141128', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141129', 'YYYYMMDD') AND (TO_DATE('20141129', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141129', 'YYYYMMDD') AND (TO_DATE('20141129', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141130', 'YYYYMMDD') AND (TO_DATE('20141130', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141130', 'YYYYMMDD') AND (TO_DATE('20141130', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141201', 'YYYYMMDD') AND (TO_DATE('20141201', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141201', 'YYYYMMDD') AND (TO_DATE('20141201', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141202', 'YYYYMMDD') AND (TO_DATE('20141202', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141202', 'YYYYMMDD') AND (TO_DATE('20141202', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141203', 'YYYYMMDD') AND (TO_DATE('20141203', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141203', 'YYYYMMDD') AND (TO_DATE('20141203', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141204', 'YYYYMMDD') AND (TO_DATE('20141204', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141204', 'YYYYMMDD') AND (TO_DATE('20141204', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141205', 'YYYYMMDD') AND (TO_DATE('20141205', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141205', 'YYYYMMDD') AND (TO_DATE('20141205', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141206', 'YYYYMMDD') AND (TO_DATE('20141206', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141206', 'YYYYMMDD') AND (TO_DATE('20141206', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141207', 'YYYYMMDD') AND (TO_DATE('20141207', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141207', 'YYYYMMDD') AND (TO_DATE('20141207', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141208', 'YYYYMMDD') AND (TO_DATE('20141208', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141208', 'YYYYMMDD') AND (TO_DATE('20141208', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141209', 'YYYYMMDD') AND (TO_DATE('20141209', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141209', 'YYYYMMDD') AND (TO_DATE('20141209', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141210', 'YYYYMMDD') AND (TO_DATE('20141210', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141210', 'YYYYMMDD') AND (TO_DATE('20141210', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141211', 'YYYYMMDD') AND (TO_DATE('20141211', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141211', 'YYYYMMDD') AND (TO_DATE('20141211', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141212', 'YYYYMMDD') AND (TO_DATE('20141212', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141212', 'YYYYMMDD') AND (TO_DATE('20141212', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141213', 'YYYYMMDD') AND (TO_DATE('20141213', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141213', 'YYYYMMDD') AND (TO_DATE('20141213', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141214', 'YYYYMMDD') AND (TO_DATE('20141214', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141214', 'YYYYMMDD') AND (TO_DATE('20141214', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141215', 'YYYYMMDD') AND (TO_DATE('20141215', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141215', 'YYYYMMDD') AND (TO_DATE('20141215', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141216', 'YYYYMMDD') AND (TO_DATE('20141216', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141216', 'YYYYMMDD') AND (TO_DATE('20141216', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141217', 'YYYYMMDD') AND (TO_DATE('20141217', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141217', 'YYYYMMDD') AND (TO_DATE('20141217', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141218', 'YYYYMMDD') AND (TO_DATE('20141218', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141218', 'YYYYMMDD') AND (TO_DATE('20141218', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141219', 'YYYYMMDD') AND (TO_DATE('20141219', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141219', 'YYYYMMDD') AND (TO_DATE('20141219', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141220', 'YYYYMMDD') AND (TO_DATE('20141220', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141220', 'YYYYMMDD') AND (TO_DATE('20141220', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141221', 'YYYYMMDD') AND (TO_DATE('20141221', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141221', 'YYYYMMDD') AND (TO_DATE('20141221', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141222', 'YYYYMMDD') AND (TO_DATE('20141222', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141222', 'YYYYMMDD') AND (TO_DATE('20141222', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141223', 'YYYYMMDD') AND (TO_DATE('20141223', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141223', 'YYYYMMDD') AND (TO_DATE('20141223', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141224', 'YYYYMMDD') AND (TO_DATE('20141224', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141224', 'YYYYMMDD') AND (TO_DATE('20141224', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141225', 'YYYYMMDD') AND (TO_DATE('20141225', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141225', 'YYYYMMDD') AND (TO_DATE('20141225', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141226', 'YYYYMMDD') AND (TO_DATE('20141226', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141226', 'YYYYMMDD') AND (TO_DATE('20141226', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141227', 'YYYYMMDD') AND (TO_DATE('20141227', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141227', 'YYYYMMDD') AND (TO_DATE('20141227', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141228', 'YYYYMMDD') AND (TO_DATE('20141228', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141228', 'YYYYMMDD') AND (TO_DATE('20141228', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141229', 'YYYYMMDD') AND (TO_DATE('20141229', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141229', 'YYYYMMDD') AND (TO_DATE('20141229', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141230', 'YYYYMMDD') AND (TO_DATE('20141230', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141230', 'YYYYMMDD') AND (TO_DATE('20141230', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20141231', 'YYYYMMDD') AND (TO_DATE('20141231', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20141231', 'YYYYMMDD') AND (TO_DATE('20141231', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150101', 'YYYYMMDD') AND (TO_DATE('20150101', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150101', 'YYYYMMDD') AND (TO_DATE('20150101', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150102', 'YYYYMMDD') AND (TO_DATE('20150102', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150102', 'YYYYMMDD') AND (TO_DATE('20150102', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150103', 'YYYYMMDD') AND (TO_DATE('20150103', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150103', 'YYYYMMDD') AND (TO_DATE('20150103', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150104', 'YYYYMMDD') AND (TO_DATE('20150104', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150104', 'YYYYMMDD') AND (TO_DATE('20150104', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150105', 'YYYYMMDD') AND (TO_DATE('20150105', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150105', 'YYYYMMDD') AND (TO_DATE('20150105', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150106', 'YYYYMMDD') AND (TO_DATE('20150106', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150106', 'YYYYMMDD') AND (TO_DATE('20150106', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150107', 'YYYYMMDD') AND (TO_DATE('20150107', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150107', 'YYYYMMDD') AND (TO_DATE('20150107', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150108', 'YYYYMMDD') AND (TO_DATE('20150108', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150108', 'YYYYMMDD') AND (TO_DATE('20150108', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150109', 'YYYYMMDD') AND (TO_DATE('20150109', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150109', 'YYYYMMDD') AND (TO_DATE('20150109', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150110', 'YYYYMMDD') AND (TO_DATE('20150110', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150110', 'YYYYMMDD') AND (TO_DATE('20150110', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150111', 'YYYYMMDD') AND (TO_DATE('20150111', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150111', 'YYYYMMDD') AND (TO_DATE('20150111', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150112', 'YYYYMMDD') AND (TO_DATE('20150112', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150112', 'YYYYMMDD') AND (TO_DATE('20150112', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150113', 'YYYYMMDD') AND (TO_DATE('20150113', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150113', 'YYYYMMDD') AND (TO_DATE('20150113', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150114', 'YYYYMMDD') AND (TO_DATE('20150114', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150114', 'YYYYMMDD') AND (TO_DATE('20150114', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150115', 'YYYYMMDD') AND (TO_DATE('20150115', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150115', 'YYYYMMDD') AND (TO_DATE('20150115', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150116', 'YYYYMMDD') AND (TO_DATE('20150116', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150116', 'YYYYMMDD') AND (TO_DATE('20150116', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150117', 'YYYYMMDD') AND (TO_DATE('20150117', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150117', 'YYYYMMDD') AND (TO_DATE('20150117', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150118', 'YYYYMMDD') AND (TO_DATE('20150118', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150118', 'YYYYMMDD') AND (TO_DATE('20150118', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150119', 'YYYYMMDD') AND (TO_DATE('20150119', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150119', 'YYYYMMDD') AND (TO_DATE('20150119', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150120', 'YYYYMMDD') AND (TO_DATE('20150120', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150120', 'YYYYMMDD') AND (TO_DATE('20150120', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150121', 'YYYYMMDD') AND (TO_DATE('20150121', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150121', 'YYYYMMDD') AND (TO_DATE('20150121', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150122', 'YYYYMMDD') AND (TO_DATE('20150122', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150122', 'YYYYMMDD') AND (TO_DATE('20150122', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150123', 'YYYYMMDD') AND (TO_DATE('20150123', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150123', 'YYYYMMDD') AND (TO_DATE('20150123', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150124', 'YYYYMMDD') AND (TO_DATE('20150124', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150124', 'YYYYMMDD') AND (TO_DATE('20150124', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150125', 'YYYYMMDD') AND (TO_DATE('20150125', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150125', 'YYYYMMDD') AND (TO_DATE('20150125', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150126', 'YYYYMMDD') AND (TO_DATE('20150126', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150126', 'YYYYMMDD') AND (TO_DATE('20150126', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150127', 'YYYYMMDD') AND (TO_DATE('20150127', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150127', 'YYYYMMDD') AND (TO_DATE('20150127', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150128', 'YYYYMMDD') AND (TO_DATE('20150128', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150128', 'YYYYMMDD') AND (TO_DATE('20150128', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150129', 'YYYYMMDD') AND (TO_DATE('20150129', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150129', 'YYYYMMDD') AND (TO_DATE('20150129', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150130', 'YYYYMMDD') AND (TO_DATE('20150130', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150130', 'YYYYMMDD') AND (TO_DATE('20150130', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150131', 'YYYYMMDD') AND (TO_DATE('20150131', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150131', 'YYYYMMDD') AND (TO_DATE('20150131', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150201', 'YYYYMMDD') AND (TO_DATE('20150201', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150201', 'YYYYMMDD') AND (TO_DATE('20150201', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150202', 'YYYYMMDD') AND (TO_DATE('20150202', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150202', 'YYYYMMDD') AND (TO_DATE('20150202', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150203', 'YYYYMMDD') AND (TO_DATE('20150203', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150203', 'YYYYMMDD') AND (TO_DATE('20150203', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150204', 'YYYYMMDD') AND (TO_DATE('20150204', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150204', 'YYYYMMDD') AND (TO_DATE('20150204', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150205', 'YYYYMMDD') AND (TO_DATE('20150205', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150205', 'YYYYMMDD') AND (TO_DATE('20150205', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150206', 'YYYYMMDD') AND (TO_DATE('20150206', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150206', 'YYYYMMDD') AND (TO_DATE('20150206', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150207', 'YYYYMMDD') AND (TO_DATE('20150207', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150207', 'YYYYMMDD') AND (TO_DATE('20150207', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150208', 'YYYYMMDD') AND (TO_DATE('20150208', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150208', 'YYYYMMDD') AND (TO_DATE('20150208', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150209', 'YYYYMMDD') AND (TO_DATE('20150209', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150209', 'YYYYMMDD') AND (TO_DATE('20150209', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150210', 'YYYYMMDD') AND (TO_DATE('20150210', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150210', 'YYYYMMDD') AND (TO_DATE('20150210', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150211', 'YYYYMMDD') AND (TO_DATE('20150211', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150211', 'YYYYMMDD') AND (TO_DATE('20150211', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150212', 'YYYYMMDD') AND (TO_DATE('20150212', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150212', 'YYYYMMDD') AND (TO_DATE('20150212', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150213', 'YYYYMMDD') AND (TO_DATE('20150213', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150213', 'YYYYMMDD') AND (TO_DATE('20150213', 'YYYYMMDD') + 1)
;

COMMIT WORK;
--== Copy the rows that has been processed...
INSERT INTO ninjadata.arch_master_memo_transactions
  SELECT *
    FROM ninjadata.master_memo_transactions a
   WHERE a.process_status != 'WAITING'
     AND a.enter_time BETWEEN TO_DATE('20150214', 'YYYYMMDD') AND (TO_DATE('20150214', 'YYYYMMDD') + 1)
;

COMMIT WORK;

--== ...and remove the copied rows.
DELETE FROM ninjadata.master_memo_transactions a
  WHERE a.process_status != 'WAITING'
    AND a.enter_time BETWEEN TO_DATE('20150214', 'YYYYMMDD') AND (TO_DATE('20150214', 'YYYYMMDD') + 1)
;

COMMIT WORK;
