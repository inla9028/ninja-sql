SELECT a.account_type AS "ACC_TYPE", a.account_sub_type AS "ACC_SUB_TYPE",
       '' AS "DESCRIPTION", COUNT(*) AS "COUNT (# of BANs)"
  FROM billing_account a
  WHERE a.ban_status = 'O'
  GROUP BY a.account_type, a.account_sub_type, ''
  ORDER BY "ACC_TYPE", "ACC_SUB_TYPE", "DESCRIPTION";
