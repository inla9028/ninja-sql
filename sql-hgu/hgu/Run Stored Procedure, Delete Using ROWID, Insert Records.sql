/*
** Insert records from the table currently hard-coded in the stored procedure.
*/
INSERT INTO ninjamain.tmp_rowid_list
SELECT a.rowid AS "ID"
  FROM master_transactions a
 WHERE a.request_id    IN ( 'OLRA2127 19.09.2019', 'OLRA2127 20.09.2019' )
   AND a.process_status = 'ON_HOLD'
;

/*
** Execute the stored procedure.
*/
-- execute HGU_UTILS.DELETE_OLD_DATA(5000);
execute HGU_UTILS.delete_old_data_from_table(5000, 'ninjadata.' || 'master_transactions')
;

/*
** Clear any old rowids.
*/
DELETE
  FROM ninjamain.tmp_rowid_list
;

/*
** Commit...
*/
COMMIT WORK
;
