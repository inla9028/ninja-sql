SELECT a.*
  FROM arch_master_memo_transactions a
 WHERE a.process_status    != 'EXCLUDED'
   AND a.process_status     = 'PRSD_SUCCESS'
   AND a.enter_time   BETWEEN to_date('2015-03-17 23:00', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2015-03-18 10:00', 'YYYY-MM-DD HH24:MI')
   AND a.process_time BETWEEN to_date('2015-03-18 10:00', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2015-03-18 10:30', 'YYYY-MM-DD HH24:MI')
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

/*
** Create temporary table...
*/
CREATE TABLE tmp_memo_invest
NOLOGGING
AS
    (
SELECT a.*
  FROM arch_master_memo_transactions a
 WHERE a.enter_time   BETWEEN to_date('2015-03-17 23:00', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2015-03-18 10:00', 'YYYY-MM-DD HH24:MI')
);

COMMIT;

CREATE INDEX tmp_memo_invest_idx1
    ON tmp_memo_invest (subscriber_no, ban_no);

CREATE INDEX tmp_memo_invest_idx2
    ON tmp_memo_invest (enter_time, process_time, process_status);

COMMIT;

/*
** Drop temporary table..
*/
DROP TABLE tmp_memo_invest;
COMMIT;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

SELECT a.*
  FROM tmp_memo_invest a
 WHERE a.process_status = 'PRSD_SUCCESS'
   AND a.process_time BETWEEN to_date('2015-03-18 10:00', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2015-03-18 10:30', 'YYYY-MM-DD HH24:MI')
;

