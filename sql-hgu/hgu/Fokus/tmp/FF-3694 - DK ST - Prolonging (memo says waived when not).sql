SELECT m.memo_ban, TO_CHAR(m.memo_date, 'YYYY-MM-DD HH24:MI') AS "MEMO_DATE", m.memo_type, m.memo_subscriber,   m.operator_id,
       u.user_full_name, m.memo_system_txt, m.memo_manual_txt
  FROM memo m, users u
 WHERE m.memo_subscriber IN ('GSM045' || '27150414', 'GSM045' || '27150451' )
   AND m.operator_id     = u.user_id(+)
   AND m.memo_date       > TRUNC(SYSDATE - 1)
ORDER BY m.memo_id
;

select a.*
  from charge a
 where a.ban IN ( 518385802 )
   and a.subscriber_no IN ('GSM045' || '27150414', 'GSM045' || '27150451' )
   and a.sys_creation_date > TRUNC(SYSDATE - 1)
order by a.sys_creation_date
;
