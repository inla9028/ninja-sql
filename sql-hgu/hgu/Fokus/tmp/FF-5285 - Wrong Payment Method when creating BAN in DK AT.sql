SELECT m.memo_id, m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE",
       m.memo_id, m.memo_type, m.memo_subscriber, m.operator_id, 
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo m, users u
 WHERE m.memo_ban    = 415010909
   AND m.operator_id = u.user_id(+)
ORDER BY m.memo_id
;