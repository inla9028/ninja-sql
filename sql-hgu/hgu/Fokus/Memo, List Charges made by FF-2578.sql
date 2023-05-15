/*
**
** List charges made due to FF-2578 containing a bug.
** First extract at 2012-09-14 contained 1527 rows, last was [2012-09-14 10:15, GSM04746545331]
** Second extract at 2012-09-14 contained 1784 rows, last was [2012-09-17 22:31, GSM04792806718]
**
*/
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo m, users u
 WHERE 1 = 1
--   AND m.memo_subscriber IN ('GSM047' || '40458282', '047' || '40458282')
   AND m.memo_manual_txt LIKE 'Penalty accepted%'
   AND m.operator_id     = u.user_id(+)
   AND m.memo_date       > TO_DATE('2012-08-26', 'YYYY-MM-DD')
 ORDER BY m.memo_id
;
