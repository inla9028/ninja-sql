SELECT a.subscriber_no, a.customer_id, a.sub_status, a.sub_status_date
     , a.operator_id, u.user_full_name, a.dealer_code, a.sales_agent
 FROM subscriber a, users u
WHERE a.subscriber_no = 'GSM047'||'95963395'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.operator_id   = u.user_id(+)
;

SELECT b.ban, b.curr_root_ban, b.sys_creation_date, b.account_type, b.account_sub_type
     , b.operator_id, u.user_full_name, b.credit_class, b.bill_cycle, b.bl_last_prod_date
     , b.bl_prt_category
  FROM billing_account b,  subscriber a, users u
WHERE a.subscriber_no = 'GSM047'||'95963395'
  AND a.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.customer_id   = b.ban
  AND b.operator_id   = u.user_id(+)
;

SELECT a.ctn, a.ctn_status, a.nl, a.ngp, a.tn_in_use, a.sys_creation_date, a.sys_update_date
     , a.last_trx_date, a.last_trx_code, a.last_trx_uid, u.user_full_name
  FROM tn_inv a, users u
 WHERE a.ctn = '047'||'95963395'
   AND a.last_trx_uid = u.user_id(+)
;

SELECT * FROM (
    SELECT a.ctn, a.ctn_status, a.nl, a.ngp, a.tn_in_use, a.sys_creation_date, a.sys_update_date
         , a.last_trx_date, a.last_trx_code, a.last_trx_uid, u.user_full_name
      FROM tn_inv a, users u
     WHERE a.ctn          = '047'||'95963395'
       AND a.last_trx_uid = u.user_id(+)
    UNION
    SELECT a.ctn, a.ctn_status, a.nl, a.ngp, a.tn_in_use, a.sys_creation_date, a.sys_update_date
         , a.last_trx_date, a.last_trx_code, a.last_trx_uid, u.user_full_name
      FROM tn_inv_history a, users u
     WHERE a.ctn          = '047'||'95963395'
       AND a.last_trx_uid = u.user_id(+)
) ORDER BY 8,6
;

SELECT a.ban, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
  FROM service_agreement a, users u
 WHERE a.subscriber_no = 'GSM047'||'95963395'
   AND SYSDATE   BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, a.ftr_add_sw_prm
  FROM service_feature a
 WHERE a.subscriber_no = 'GSM047'||'95963395'
   AND   SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
--   AND a.soc LIKE 'HPISDN%'
   AND a.feature_code LIKE 'F-SWC%' -- Switch
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
ORDER BY 1,2,3,8
;

SELECT s.subscriber_no, a.subscriber_id, a.sys_creation_date, a.loan_seq_no
     , a.soc, a.full_amt, a.first_install_rate, a.other_install_rate
     , a.last_install_rate, a.no_of_installments
  FROM subscriber_loan a, subscriber s
 WHERE a.subscriber_id = s.subscriber_id
   AND s.subscriber_no = 'GSM047'||'95963395'
   AND s.cnt_seq_no    = (SELECT MAX(b.cnt_seq_no)
                           FROM subscriber b
                          WHERE b.subscriber_no = s.subscriber_no)
ORDER BY s.subscriber_no, a.loan_seq_no
;

SELECT a.memo_id, a.memo_ban, a.memo_subscriber, a.memo_date
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo a, users u
 WHERE a.memo_subscriber = 'GSM047'||'95963395'
--   AND a.memo_date       > TRUNC(SYSDATE - 90, 'YEAR')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;


