--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get all memos for a specified subscriber on a specified ban.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_id, m.memo_type, m.memo_subscriber, 
       m.operator_id, u.user_full_name, m.memo_system_txt, m.memo_manual_txt
 FROM memo@fokus m, users@fokus u
  WHERE m.memo_ban        = 648549806
    AND m.operator_id     = u.user_id(+)
--    AND m.memo_id = 201782241
--   and lower(m.memo_system_txt) like '%indicator%'
--    AND m.memo_date       > TRUNC(SYSDATE)
  ORDER BY m.memo_id;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the memos for the current year only.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt
       , m.*
 FROM memo@fokus m, users@fokus u
  WHERE m.memo_subscriber IN ( 'GSM047' || '48167484', '047' || '48167484', 'CDA047' || '48167484')
--     OR */m.memo_ban        =  160956405
    AND m.operator_id     = u.user_id(+)
    AND m.memo_date       > TRUNC(SYSDATE, 'YEAR')
--    AND m.memo_date BETWEEN TO_DATE('2008-12-31', 'YYYY-MM-DD') AND TO_DATE('2009-01-02', 'YYYY-MM-DD')
  ORDER BY m.memo_id;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the memos for the current month only.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt, m.*
 FROM memo@fokus m, users@fokus u
  WHERE m.memo_subscriber IN ('GSM047' || '47526944', '047' || '47526944')
--    AND*/ m.memo_ban        = 720273804
    AND m.operator_id     = u.user_id(+)
    AND m.memo_date       > TRUNC(SYSDATE, 'MON')
  ORDER BY m.memo_id;

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Get the memos for the current week only.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,
       m.operator_id, u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo@fokus m, users@fokus u
 WHERE m.memo_subscriber IN ('GSM047' || '92653600', 'GSM04798323543', 'GSM04793297222' )
--   AND */m.memo_ban        = 645955600
   AND m.operator_id     = u.user_id(+)
   AND m.memo_date       > TRUNC(SYSDATE, 'DAY')
   AND m.memo_id         > 288848839
ORDER BY 1, m.memo_id
;

