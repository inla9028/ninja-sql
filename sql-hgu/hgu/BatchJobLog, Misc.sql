/*
** List all records.
*/
SELECT a.*
  FROM ninja_batchjob_log a
ORDER BY a.enter_date
;

/*
** List the last X days.
*/
SELECT a.*
  FROM ninja_batchjob_log a
 WHERE a.enter_date > TRUNC(SYSDATE - 4)
ORDER BY a.enter_date
;

/*
** List the last X days, and only inserts/deletes.
*/
SELECT a.*
  FROM ninja_batchjob_log a
 WHERE a.enter_date > TRUNC(SYSDATE - 8)
   AND (a.message LIKE 'Inserted%' OR a.message LIKE 'Removed%')
ORDER BY a.enter_date
;


