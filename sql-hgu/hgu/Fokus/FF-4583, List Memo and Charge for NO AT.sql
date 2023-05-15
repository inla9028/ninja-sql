SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo m, users u
 WHERE m.memo_subscriber IN ('GSM047' || '40623565' )
   AND m.operator_id     = u.user_id(+)
   AND m.memo_date       > TRUNC(SYSDATE)
ORDER BY m.memo_id
;

select a.*
  from charge a
 where a.ban = 755696507
   and a.sys_creation_date > TRUNC(SYSDATE)
;
