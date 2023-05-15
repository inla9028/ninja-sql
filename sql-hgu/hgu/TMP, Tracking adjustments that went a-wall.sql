SELECT a.*
  FROM batch_adjustment_addition a
 WHERE 1 = 1
--   AND a.record_creation_date > to_date('2015-03-17 23:00', 'YYYY-MM-DD HH24:MI')
--   AND a.process_time         > a.record_creation_date + (1/96)
   AND a.process_time BETWEEN to_date('2015-03-18 09:58', 'YYYY-MM-DD HH24:MI')
                          AND to_date('2015-03-18 10:30', 'YYYY-MM-DD HH24:MI')
;

SELECT a.*
  FROM batch_adjustment_addition a
 WHERE subscriber_no = '04792874238'
;

SELECT count(*) AS "COUNT"
  FROM charge@fokus c
WHERE 1 = 1
  AND c.ban               = 691327803
  AND c.subscriber_no     = 'GSM04792874238'
  AND c.sys_creation_date BETWEEN to_date('2015-03-18 08:35', 'YYYY-MM-DD HH24:MI')
                              AND to_date('2015-03-18 10:01', 'YYYY-MM-DD HH24:MI')
;

SELECT c.*
  FROM charge@fokus c
WHERE 1 = 1
  AND c.ban               = 691327803
  AND c.subscriber_no     = 'GSM04792874238'
  AND c.sys_creation_date BETWEEN to_date('2015-03-18 08:35', 'YYYY-MM-DD HH24:MI')
                              AND to_date('2015-03-18 10:01', 'YYYY-MM-DD HH24:MI')
;

SELECT sum(c.actv_amt)
  FROM charge@fokus c
WHERE 1 = 1
  AND c.ban               = 691327803
  AND c.subscriber_no     = 'GSM04792874238'
  AND c.sys_creation_date BETWEEN to_date('2015-03-18 08:35', 'YYYY-MM-DD HH24:MI')
                              AND to_date('2015-03-18 10:01', 'YYYY-MM-DD HH24:MI')
;

SELECT a.*
  FROM all_tables@fokus a
 WHERE a.table_name LIKE '%CHARGE%'
  ORDER BY a.owner, a.table_name
;


