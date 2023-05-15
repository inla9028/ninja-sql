/*
** Via DB link
*/
select a.port_number
     , to_char(a.sys_creation_date, 'YYYY-MM-DD HH24:MI:SS') as "SYS_CREATION_DATE"
     , to_char(a.effective_date,    'YYYY-MM-DD HH24:MI:SS') as "EFFECTIVE_DATE"
     , to_char(a.expiration_date,   'YYYY-MM-DD HH24:MI:SS') as "EXPIRATION_DATE"
     , a.operator_id, u.user_full_name, a.int_order_id, a.last_int_ord_id
     , a.org_customer_id, a.port_ind, a.org_operator
  from np_number_info@fokus a, users@fokus u
 where a.port_number = '91325179'
   and a.operator_id = u.user_id(+)
order by 1,2,3
;

/*
** Directly in Fokus
*/
select a.port_number
     , to_char(a.sys_creation_date, 'YYYY-MM-DD HH24:MI:SS') as "SYS_CREATION_DATE"
     , to_char(a.effective_date,    'YYYY-MM-DD HH24:MI:SS') as "EFFECTIVE_DATE"
     , to_char(a.expiration_date,   'YYYY-MM-DD HH24:MI:SS') as "EXPIRATION_DATE"
     , a.operator_id, u.user_full_name, a.int_order_id, a.last_int_ord_id
     , a.org_customer_id, a.port_ind, a.org_operator
  from np_number_info a, users u
 where a.port_number = '91325179'
   and a.operator_id = u.user_id(+)
order by 1,2,3
;