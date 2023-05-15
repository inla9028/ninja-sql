/*
** Indexes of ninjadata.arch_master_memo_transactions
** Idx #1
**   * process_status
**   * priority
**   * enter_time
** Idx #2
**   * subscriber_no
**
*/

SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME", a.exclude_ind, COUNT(1) AS "COUNT"
  FROM ninjadata.arch_master_memo_transactions a
 WHERE a.enter_time > TO_DATE('2012-08-01', 'YYYY-MM-DD')
GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD'), a.exclude_ind
ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD'), a.exclude_ind
;

SELECT TO_CHAR(a.process_time, 'YYYY-MM-DD') AS "PROCESS_TIME", COUNT(1) AS "COUNT"
  FROM ninjadata.arch_master_memo_transactions a
 WHERE a.enter_time > TO_DATE('2012-08-01', 'YYYY-MM-DD')
   AND a.process_status != 'EXCLUDED'
GROUP BY TO_CHAR(a.process_time, 'YYYY-MM-DD')
ORDER BY TO_CHAR(a.process_time, 'YYYY-MM-DD')
;


