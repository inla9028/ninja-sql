--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get all memos for a specified subscriber on a specified ban.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_id, m.memo_type, m.memo_subscriber, 
       m.operator_id, u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo m, users u
 WHERE m.memo_subscriber IN ('GSM047' || '92066443', '047' || '92066443')
--   AND*/ m.memo_ban        = 145661609
   AND m.operator_id     = u.user_id(+)
--   AND m.memo_id = 201782241
--  and lower(m.memo_system_txt) like '%indicator%'
ORDER BY m.memo_id
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the memos for the current year only.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo m, users u
 WHERE m.memo_subscriber IN ( 'GSM047' || '92066443', '047' || '92066443', 'CDA047' || '92066443')
--    OR */m.memo_ban        =  145661609
   AND m.operator_id     = u.user_id(+)
   AND m.memo_date       > TRUNC(SYSDATE, 'YEAR')
--   AND m.memo_date BETWEEN TO_DATE('2008-12-31', 'YYYY-MM-DD') AND TO_DATE('2009-01-02', 'YYYY-MM-DD')
ORDER BY m.memo_id
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the memos for the current month only.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo m, users u
 WHERE m.memo_subscriber IN ('GSM047' || '93001860', '047' || '93001860')
--   AND*/ m.memo_ban        = 705660017
   AND m.operator_id     = u.user_id(+)
   AND m.memo_date       > TRUNC(SYSDATE, 'MON')
ORDER BY m.memo_id
;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the memos for the current week only.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo m, users u
 WHERE /*m.memo_subscriber IN ('GSM047' || '91683236', 'GSM047' || '92452450', 'GSM047' || '91316750', 'GSM047' || '93005546', 'GSM047' || '90182352' )
--   AND */m.memo_ban        = 270150014
   AND m.operator_id     = u.user_id(+)
   AND m.memo_date       > TRUNC(SYSDATE, 'DAY')
ORDER BY m.memo_id
;
