DELETE
  FROM tmp_bans_w_account_type
;

--CREATE table tmp_bans_w_account_type
--AS
INSERT INTO tmp_bans_w_account_type
SELECT b.ban, b.curr_root_ban, b.sys_creation_date, b.account_type, b.account_sub_type
     , b.operator_id, b.credit_class, b.bill_cycle, b.bl_last_prod_date
     , b.bl_prt_category
  FROM billing_account b
 WHERE b.ban_status             IN ( 'O' )
   AND b.account_type            = 'I'
--   AND RTRIM(b.account_sub_type) = 'R'
--   AND ROWNUM < 11
;

COMMIT WORK;

SELECT b.account_type, b.account_sub_type, COUNT(1) AS "COUNT"
  FROM tmp_bans_w_account_type b
GROUP BY b.account_type, b.account_sub_type
ORDER BY b.account_type, b.account_sub_type
;

