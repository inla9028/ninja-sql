SELECT a.acc_type, a.acc_sub_type, a.description, a.sys_creation_date
     , a.operator_id, u.user_full_name
  FROM account_type a, users u
 WHERE a.acc_type          = 'S'
   AND a.sys_creation_date > TRUNC(SYSDATE, 'YEAR')
   AND a.operator_id       = u.user_id(+)
ORDER BY 1,2
;

SELECT a.dealer, a.dlr_name, a.start_date, a.operator_id, u.user_full_name
  FROM dealer_profile a, users u
 WHERE a.sys_creation_date > TRUNC(SYSDATE - 365, 'YEAR')
   AND a.dealer         LIKE 'SP%'
   AND a.operator_id       = u.user_id(+)
ORDER BY 1
;

SELECT RTRIM(a.soc), a.soc_description, a.customer_subtype, a.sale_eff_date
     , a.operator_id, u.user_full_name
  FROM soc a, users u
 WHERE a.service_type  = 'P'
   AND SYSDATE   BETWEEN NVL(a.sale_eff_date, a.effective_date) AND NVL(a.expiration_date, NVL(a.sale_exp_date, SYSDATE + 1))
   AND a.customer_type = 'S'
   AND NVL(a.sale_eff_date, a.effective_date) > TRUNC(SYSDATE, 'YEAR')
   AND a.operator_id   = u.user_id(+)
ORDER BY 1
;
