-- Subscriber; status
SELECT /*+ driving_site(a)*/
       a.subscriber_no, a.customer_id, a.sub_status, a.sub_status_date
     , a.operator_id, u.user_full_name, a.dealer_code, a.sales_agent
     , a.subscriber_id, rtrim(A.publish_level) AS "PUBLISH_LEVEL"
     , a.ctn_seq_no, a.fixed_as_gsm_ind
 FROM subscriber@fokus a, users@fokus u
WHERE a.subscriber_no = 'GSM047'||'96734232'
  AND a.ctn_seq_no    = (SELECT MAX(b.ctn_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.operator_id   = u.user_id(+)
order by a.ctn_seq_no
;

-- BAN; status, account types...
SELECT /*+ driving_site(b)*/
       b.ban, b.curr_root_ban, b.sys_creation_date, b.ban_status
     , b.account_type, b.account_sub_type, c.customer_telno
     , b.operator_id, u.user_full_name
     , b.credit_class, b.bill_cycle, b.bl_last_prod_date, b.bl_prt_category
  FROM billing_account@fokus b, subscriber@fokus a, users@fokus u, customer@fokus c
WHERE a.subscriber_no = 'GSM047'||'96734232'
  AND a.ctn_seq_no    = (SELECT MAX(b.ctn_seq_no)
                           FROM subscriber@fokus b
                          WHERE b.subscriber_no = a.subscriber_no)
  AND a.customer_id   = b.ban
  AND c.customer_id   = a.customer_id
  AND b.operator_id   = u.user_id(+)
;

-- Inventory...
SELECT /*+ driving_site(a)*/
       a.ctn, a.ctn_status, a.nl, a.ngp, a.tn_in_use, a.sys_creation_date, a.sys_update_date
     , a.last_trx_date, a.last_trx_code, a.last_trx_uid, u.user_full_name
  FROM tn_inv@fokus a, users@fokus u
 WHERE a.ctn          = '047'||'96734232'
   AND a.last_trx_uid = u.user_id(+)
;

-- Inventory history...
SELECT * FROM (
    SELECT /*+ driving_site(a)*/
           a.ctn, a.ctn_status, a.nl, a.ngp, a.tn_in_use, a.sys_creation_date, a.sys_update_date
         , a.last_trx_date, a.last_trx_code, a.last_trx_uid, u.user_full_name
      FROM tn_inv@fokus a, users@fokus u
     WHERE a.ctn          = '047'||'96734232'
       AND a.last_trx_uid = u.user_id(+)
    UNION
    SELECT /*+ driving_site(a)*/
           a.ctn, a.ctn_status, a.nl, a.ngp, a.tn_in_use, a.sys_creation_date, a.sys_update_date
         , a.last_trx_date, a.last_trx_code, a.last_trx_uid, u.user_full_name
      FROM tn_inv_history@fokus a, users@fokus u
     WHERE a.ctn          = '047'||'96734232'
       AND a.last_trx_uid = u.user_id(+)
) ORDER BY 8,6
;

-- Names & Addresses...
SELECT /*+ driving_site(s)*/
       anl.ban, decode(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
     , anl.link_type, anl.birth_date
     , nd.tpid, nd.comp_reg_id, nd.e_faktura_ref, nd.first_name, nd.last_business_name, nd.additional_title
     , ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email
     , nd.name_format, ad.adr_type, nd.role_ind
     , nd.id_type, nd.identify
--       , anl.name_id, anl.address_id
--       , nd.*
  FROM subscriber@fokus        s
     , address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
 WHERE s.subscriber_no    = 'GSM047'||'96734232'
   AND s.ctn_seq_no       = (SELECT MAX(s2.ctn_seq_no)
                              FROM subscriber@fokus s2
                             WHERE s2.subscriber_no = s.subscriber_no)
   AND anl.ban            = s.customer_id 
   AND anl.subscriber_no IN ( '0000000000', s.subscriber_no )
   AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.link_type     IN ( 'B', 'L', 'U' )
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
--ORDER BY anl.ban, anl.subscriber_no, anl.link_type
ORDER BY anl.ban, decode(anl.link_type, 'C', 0, 'L', 1, 'B', 2, 'U', 3, 4), anl.subscriber_no
;

-- SIM(s)
SELECT /*+ driving_site(s)*/
       s.subscriber_no, sii.serial_number, sii.act_issue_date, pd.equipment_level
     , sii.puk, sii.puk2, sii.initial_pin, sii.initial_pin2, sii.imsi, sii.hlr_cd
     , sii.curr_possession, sii.curr_possession_dt
  FROM subscriber@fokus s, physical_device@fokus pd, serial_item_inv@fokus sii
 WHERE s.subscriber_no    = 'GSM047' || '96734232'
   AND s.sub_status       = 'A'
   AND s.customer_id      = pd.ban
   AND s.subscriber_no    = pd.subscriber_no
   AND pd.expiration_date IS NULL
   AND pd.equipment_no    = sii.serial_number
   AND pd.imsi            = sii.imsi
ORDER BY pd.equipment_level DESC, sii.act_issue_date
;

-- Additional Info...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.field_name, a.field_value, a.operator_id
     , u.user_full_name, a.sys_creation_date, a.sys_update_date
  FROM additional_info@fokus A, subscriber@fokus s, users@fokus u
 WHERE s.subscriber_no = 'GSM047'||'96734232'
   AND s.ctn_seq_no    = (SELECT MAX(b.ctn_seq_no)
                            FROM subscriber@fokus b
                           WHERE b.subscriber_no = a.subscriber_no)
   AND a.ban           = s.customer_id
   AND a.subscriber_no = s.subscriber_no
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Campaigns/discounts
SELECT /*+ driving_site(s)*/ bd.ban, bd.subscriber_no
     , bd.campaign, bd.discount_code, bd.disc_seq_no
     , bd.operator_id, u.user_full_name
     , bd.effective_date, bd.commit_orig_no_month AS "MONTHS", bd.expiration_date
     , bd.disc_by_opid, u2.user_full_name AS "OP_FULL_NAME"
  FROM subscriber@fokus s, ban_discount@fokus bd, users@fokus u, users@fokus u2
 WHERE s.subscriber_no      = 'GSM047'||'96734232'
   AND s.ctn_seq_no         = (SELECT MAX(b.ctn_seq_no)
                                 FROM subscriber@fokus b
                                WHERE b.subscriber_no = s.subscriber_no)
   AND bd.ban               = s.customer_id
   AND bd.subscriber_no     = s.subscriber_no
   AND trunc(SYSDATE) BETWEEN bd.effective_date AND nvl(bd.expiration_date, SYSDATE + 1)
--   AND to_date('2021-01-06', 'YYYY-MM-DD') BETWEEN bd.effective_date AND nvl(bd.expiration_date, SYSDATE + 1)
   AND bd.operator_id       = u.user_id(+)
   AND bd.disc_by_opid      = u2.user_id(+)
ORDER BY bd.effective_date
;

-- Service Agreement; SOCs...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, RTRIM(a.soc) AS "SOC", a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
     , a.loan_seq_no, a.trx_id, c.min_commit_period AS "CAMPAIGN_MONTHS"
     , a.effective_date + (365 * c.min_commit_period / 12) AS "CAMPAIGN_EXP_DATE"
     , a.soc_ver_no
  FROM service_agreement@fokus a, campaign_commitments@fokus c, users@fokus u
 WHERE a.subscriber_no        = 'GSM047'||'96734232'
   AND SYSDATE          BETWEEN a.effective_date AND nvl(A.expiration_date, SYSDATE + 1)
--   AND TO_DATE('2022-08-02', 'YYYY-MM-DD') BETWEEN a.effective_date AND nvl(A.expiration_date, SYSDATE + 1)
   AND a.operator_id          = u.user_id(+)
   AND a.campaign             = c.campaign(+)
   AND a.effective_date BETWEEN c.effective_date(+) AND nvl(c.expiration_date(+), SYSDATE + 1)
--   AND a.soc               LIKE 'MPOD%'
--ORDER BY 1,2,3,5
ORDER BY 1, 2, decode(a.service_type, 'P', 0, 1), 3, 5
;

-- Service Feature; Feature parameters...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date --, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, RTRIM(a.ftr_add_sw_prm) AS "FTR_ADD_SW_PRM"
     , a.ftr_exp_rsn_code
  FROM service_feature@fokus a
 WHERE a.subscriber_no = 'GSM047'||'96734232'
   AND SYSDATE BETWEEN a.ftr_effective_date AND nvl(A.ftr_expiration_date, SYSDATE + 1)
--     AND to_date('2022-08-02', 'YYYY-MM-DD') BETWEEN a.ftr_effective_date AND nvl(A.ftr_expiration_date, SYSDATE + 1)
--   AND a.soc LIKE 'MP%'
--   AND a.feature_code LIKE 'F-SWC%' -- Switch
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
   AND a.ftr_add_sw_prm IS NOT NULL
ORDER BY a.ban, a.subscriber_no, a.soc, a.feature_code, a.soc_seq_no
;

-- Soc Loan; Loans, Leases, Switches...
SELECT /*+ driving_site(a)*/
       s.subscriber_no, a.subscriber_id, a.sys_creation_date, a.loan_seq_no
     , a.handle_ind, a.soc, a.full_amt, a.first_install_rate
     , a.other_install_rate, a.last_install_rate, a.no_of_installments
     , a.expiration_date, a.ud_last_date_crg, a.last_date_of_crg
     , a.rowid
--     , a.*
  FROM subscriber_loan@fokus a, subscriber@fokus s
 WHERE a.subscriber_id = s.subscriber_id
   AND s.subscriber_no = 'GSM047'||'96734232'
--   AND s.ctn_seq_no    = (SELECT MAX(b.ctn_seq_no)
--                           FROM subscriber@fokus b
--                          WHERE b.subscriber_no = s.subscriber_no)
--   AND a.soc        LIKE 'LEASZ%'
ORDER BY s.subscriber_no, a.loan_seq_no
;

-- Charges for Loan/Leases...
SELECT /*+ driving_site(c)*/
       c.subscriber_no, c.actv_code, c.actv_reason_code, c.actv_date, c.actv_amt, c.soc, c.soc_seq_no /*, c.soc_date */
     , c.vat_amt, c.tax_code, c.vat_percent_rate, c.no_of_install_from, c.no_of_install_to, c.total_no_of_install, c.bill_comment
--     , c.*
  FROM charge@fokus c, subscriber@fokus s
 WHERE s.subscriber_no = 'GSM047'||'96734232'
   AND s.ctn_seq_no    = (SELECT MAX(s2.ctn_seq_no)
                           FROM subscriber@fokus s2
                          WHERE s2.subscriber_no = s.subscriber_no)
   AND c.root_ban      = s.customer_id
   AND c.ban           = s.customer_id
   AND c.subscriber_no = s.subscriber_no
   AND c.soc          IN (SELECT sa.soc
                            FROM service_agreement@fokus sa
                           WHERE sa.subscriber_no = s.subscriber_no
                             AND SYSDATE    BETWEEN sa.effective_date AND nvl(sa.expiration_date, SYSDATE + 1)
                             AND sa.service_type IN ( 'G' ))   
   AND c.actv_date > TRUNC(SYSDATE - 61, 'MON')
ORDER BY c.actv_bill_seq_no, c.ent_seq_no
;

-- External charges agreements
SELECT /*+ driving_site(a)*/ a.ban, a.subscriber_no, a.soc, a.soc_seq_no
     , a.feature_code, a.effective_date, a.charge_amt, a.next_crg_date
     , RTRIM(a.ext_agreement_id) AS "EXT_AGREEMENT_ID", a.ext_agreement_type, a.rc_type
  FROM subscription_soc_rc@fokus a
 WHERE a.SUBSCRIBER_NO  = 'GSM047'||'96734232'
   AND a.effective_date > TRUNC(SYSDATE, 'MON')
ORDER BY a.effective_date
;

-- External soc charges...
SELECT /*+ driving_site(a)*/ a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.request_seq_no
     , a.feature_code, a.chg_creation_date, a.charge_amt, a.request_status, a.req_status_desc
     --, a.*
  FROM sub_soc_charges@fokus a
 WHERE a.subscriber_no     = 'GSM047'||'96734232'
   AND a.chg_creation_date > TRUNC(SYSDATE, 'MON')
ORDER BY a.request_seq_no
;

-- Vouchers
SELECT a.*
  FROM batch_voucher a
 WHERE a.subscriber_no  = 'GSM047'||'96734232'
   AND a.request_time   > TRUNC(SYSDATE, 'MON')
ORDER BY a.request_time
;

-- Future activities...
SELECT /*+ driving_site(r)*/
       r.cfr_ban, r.cfr_subscriber_no
     , r.cfr_activity_cd, r.cfr_reason_cd
     , a.csa_activity_desc, a.csa_activity_rsn_desc
     , r.cfr_create_date, r.cfr_date, r.cfr_status
     , r.operator_id, u.user_full_name
  FROM csm_future_request@fokus r, csm_status_activity@fokus a, users@fokus u, subscriber@fokus s
 WHERE s.subscriber_no     = 'GSM047'||'96734232'
   AND s.ctn_seq_no        = (SELECT MAX(b.ctn_seq_no)
                                FROM subscriber@fokus b
                               WHERE b.subscriber_no = s.subscriber_no)
   AND r.cfr_subscriber_no = s.subscriber_no
   AND r.cfr_ban           = s.customer_id
   AND r.cfr_activity_cd   = a.csa_activity_code
   AND r.cfr_reason_cd     = a.csa_activity_rsn_code
   AND r.operator_id       = u.user_id(+)
ORDER BY r.cfr_create_date, r.cfr_date
;

-- Porting transactions...
SELECT /*+ driving_site(d)*/
       d.trx_code, d.trx_source, d.int_order_id, d.initi_order_seq, c.trx_desc
     , d.sys_creation_date, d.sys_update_date, d.operator_id, u.user_full_name
     , d.trx_datetime, d.trx_status, d.request_exec_date, d.conf_exec_date -- , d.text_comment
     , d.customer_name, d.customer_id, d.main_number
  FROM np_trx_detail@fokus d, np_trx_codes@fokus c, users@fokus u
 WHERE d.int_order_id = (SELECT MAX(a.int_order_id)
                           FROM np_trx_detail@fokus a
                          WHERE a.main_number = '96734232')
   AND d.trx_code     = c.trx_code
   AND d.trx_source   = c.trx_source
   AND d.operator_id  = u.user_id(+)
ORDER BY d.int_order_id, d.initi_order_seq, d.sys_creation_date
;

-- Int Porting; sync with OC/MC.
SELECT /*+ driving_site(a)*/ a.*
  FROM int_porting@fokus a
 WHERE a.ported_number = '96734232'
ORDER BY a.record_creation_date
;


-- Finally, memoes...
SELECT /*+ driving_site(a)*/
       a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus a, users@fokus u
 WHERE a.memo_subscriber = 'GSM047'||'96734232'
--   AND a.memo_date       > TRUNC(SYSDATE)
   AND a.memo_date       > TRUNC(SYSDATE, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE -  30, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE -  60, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE - 120, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE, 'YEAR')
--   AND a.memo_date       > TRUNC(SYSDATE - 365, 'YEAR')
--   AND a.memo_date       > TRUNC(SYSDATE - 365 * 2, 'YEAR')
   AND a.operator_id     = u.user_id(+)
--   AND (A.memo_system_txt LIKE '%NSANR%'
--     OR a.memo_system_txt LIKE '%LEAS%'
--   )
ORDER BY a.memo_id
;

