-- BAN status...
SELECT /*+ driving_site(b)*/
       b.ban, b.curr_root_ban, b.sys_creation_date, b.account_type, b.account_sub_type
     , b.ban_status, b.operator_id, u.user_full_name, b.credit_class
     , decode(b.bill_cycle, 99, '99 (Due to Billing)', b.bill_cycle) AS "BILL_CYCLE"
     , b.bl_last_prod_date, b.bl_prt_category
  FROM billing_account@fokus b, users@fokus u
 WHERE b.customer_id   IN ( 222237117 )
   AND b.operator_id   = u.user_id(+)
ORDER BY b.customer_id 
;

-- Customer table...
SELECT /*+ driving_site(c)*/
       c.customer_id, c.operator_id, u.user_full_name, c.customer_telno, c.e_post
--     , c.*
  FROM customer@fokus c, users@fokus u
 WHERE c.customer_id IN ( 222237117 )
   AND c.operator_id   = u.user_id(+)
ORDER BY c.customer_id 
;

-- Discounts.
SELECT /*+ driving_site(a)*/ a.*
  FROM ban_discount@fokus a
 WHERE a.ban IN ( 222237117 )
ORDER BY 1,3,4,2
;

-- Campaigns/discounts
SELECT /*+ driving_site(s)*/ bd.ban, bd.subscriber_no
     , bd.campaign, bd.discount_code, bd.disc_seq_no
     , bd.operator_id, u.user_full_name
     , bd.effective_date, bd.commit_orig_no_month AS "MONTHS", bd.expiration_date
     , bd.disc_by_opid, u2.user_full_name AS "OP_FULL_NAME"
  FROM ban_discount@fokus bd, users@fokus u, users@fokus u2
 WHERE bd.ban              IN ( 222237117 )
   AND trunc(SYSDATE) BETWEEN bd.effective_date AND nvl(bd.expiration_date, SYSDATE + 1)
--   AND to_date('2021-01-06', 'YYYY-MM-DD') BETWEEN bd.effective_date AND nvl(bd.expiration_date, SYSDATE + 1)
   AND bd.operator_id       = u.user_id(+)
   AND bd.disc_by_opid      = u2.user_id(+)
ORDER BY bd.effective_date
;

-- Addresses...
SELECT *
  FROM (
  SELECT /*+ driving_site(anl)*/
         anl.ban
       , decode(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
       , anl.link_type, anl.birth_date, nd.id_type, nd.tpid, nd.comp_reg_id, nd.e_faktura_ref
       , nd.first_name, nd.last_business_name, nd.additional_title
       , ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email
  --     , nd.id_type, nd.identify
       , nd.name_format
       , nd.name_id
  --     , nd.*
       , NULL AS "SUB_STATUS"
       , anl.effective_date
    FROM address_name_link@fokus anl
       , name_data@fokus         nd
       , address_data@fokus      ad
   WHERE anl.ban           IN ( 222237117 )
     AND anl.link_type     IN ( 'B', 'L' )
     AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
     AND anl.name_id        = nd.name_id
     AND anl.address_id     = ad.address_id
  UNION
  SELECT /*+ driving_site(anl)*/
         anl.ban
       , decode(anl.subscriber_no, '0000000000', NULL, anl.subscriber_no) AS "SUBSCRIBER_NO"
       , anl.link_type, anl.birth_date, nd.id_type, nd.tpid, nd.comp_reg_id, nd.e_faktura_ref
       , nd.first_name, nd.last_business_name, nd.additional_title
       , ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email
  --     , nd.id_type, nd.identify
       , nd.name_format
       , nd.name_id
  --     , nd.*
       , s.sub_status
       , anl.effective_date
    FROM address_name_link@fokus anl
       , name_data@fokus         nd
       , address_data@fokus      ad
       , subscriber@fokus        s
   WHERE anl.ban           IN ( 222237117 )
     AND anl.link_type     IN ( 'U' )
     AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
     AND anl.name_id        = nd.name_id
     AND anl.address_id     = ad.address_id
     AND s.subscriber_no    = anl.subscriber_no 
     AND s.customer_id      = anl.ban
     AND s.sub_status      IN ( 'A', 'R', 'S' )
     AND s.ctn_seq_no       = (SELECT MAX(s2.ctn_seq_no)
                                 FROM subscriber@fokus s2
                                WHERE s2.subscriber_no = s.subscriber_no)
)
--ORDER BY ban, subscriber_no, link_type
ORDER BY ban, decode(link_type, 'L', 1, 'B', 2, 'U', 3, 4), subscriber_no
;

-- Additional Info...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.field_name, a.field_value, a.operator_id
     , u.user_full_name, a.sys_creation_date, a.sys_update_date
  FROM additional_info@fokus a, users@fokus u
 WHERE a.ban          IN ( 222237117 )
   AND a.subscriber_no = '0000000000'
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Hierarchy...
SELECT /*+ driving_site(a)*/
       a.tree_root_ban, a.parent_ban, a.ban, a.tree_level, a.effective_date, a.expiration_date
  FROM ban_hierarchy_tree@fokus a
 WHERE 222237117   IN (a.tree_root_ban, a.ban, a.parent_ban)
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY a.tree_level, a.tree_root_ban, a.ban, a.parent_ban
;

-- List cycle control...
SELECT cc.cycle_code, cc.cycle_start_date
     , MAX(cc.cycle_close_date) AS "CYCLE_CLOSE_DATE", cc.sys_creation_date
  FROM cycle_control@fokus cc
 WHERE cc.cycle_code IN (SELECT b.bill_cycle
                           FROM billing_account@fokus b
                           WHERE b.ban       IN ( 222237117 )
                             AND b.ban_status = 'O')
   AND cc.cycle_start_date > trunc(SYSDATE, 'YEAR') - 30
GROUP BY cc.cycle_code, cc.cycle_start_date, "CYCLE_CLOSE_DATE", cc.sys_creation_date
ORDER BY 1, 2
;

-- List all future cycles
SELECT /*+ driving_site(cc)*/
       cc.cycle_code, cc.cycle_start_date,
       MAX(cc.cycle_close_date) as "CYCLE_CLOSE_DATE", cc.sys_creation_date
  FROM cycle_control@fokus cc
 WHERE trunc(SYSDATE, 'MON') < cc.cycle_start_date
   AND SYSDATE               < cc.cycle_close_date
   AND cc.cycle_code        IN (
   SELECT b.bill_cycle
     FROM billing_account@fokus b
     WHERE b.ban       IN ( 222237117 )
       AND b.ban_status = 'O'
 )
GROUP BY cc.cycle_code, cc.cycle_start_date, "CYCLE_CLOSE_DATE", cc.sys_creation_date
ORDER BY cc.cycle_code
;


-- SOCs...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
     , a.*
  FROM service_agreement@fokus a, users@fokus u
 WHERE a.ban          IN ( 222237117 )
   AND a.subscriber_no = '0000000000'
--   AND SYSDATE BETWEEN a.effective_date AND nvl(A.expiration_date, SYSDATE + 1)
--   AND TO_DATE('2021-03-28', 'YYYY-MM-DD') BETWEEN a.effective_date AND nvl(A.expiration_date, SYSDATE + 1)
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Features...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date
     , TO_CHAR(a.sys_creation_date, 'YYYY-MM-DD HH24:MI:SS') AS "SYS_CREATION_DATE"
     , a.ftr_expiration_date, a.feature_code, RTRIM(a.ftr_add_sw_prm) AS "FTR_ADD_SW_PRM"
     , a.ftr_exp_rsn_code -- J: Settle with Credit, I: Regular Settle
  FROM service_feature@fokus a
 WHERE a.subscriber_no = '0000000000'
   AND a.ban        IN ( 222237117 )
--   AND SYSDATE BETWEEN a.ftr_effective_date AND nvl(A.ftr_expiration_date, SYSDATE + 1)
   AND a.soc LIKE 'LOPT%'
--   AND a.feature_code LIKE 'F-SWC%'
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
--   AND a.ftr_add_sw_prm IS NOT NULL
ORDER BY a.ban, a.subscriber_no, a.soc, a.feature_code
;



-- Memos...
SELECT /*+ driving_site(a)*/
       a.memo_id, a.memo_ban, a.memo_subscriber, to_char(A.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
     , a.memo_type
  FROM memo@fokus a, users@fokus u
 WHERE a.memo_ban        IN ( 222237117 )
   AND a.memo_subscriber IS NULL
--   AND a.memo_date       > TRUNC(SYSDATE)
--   AND a.memo_date       > TRUNC(SYSDATE, 'MON')
--   AND a.memo_date       > TRUNC(SYSDATE - 30, 'MON')
   AND a.memo_date       > TRUNC(SYSDATE - 60, 'MON')
--   AND a.memo_date       > trunc(SYSDATE, 'YEAR')
--   AND a.memo_date       > TRUNC(SYSDATE - 365, 'YEAR')
--   AND a.memo_date       > trunc(SYSDATE - (2 * 365), 'YEAR')
   AND a.operator_id     = u.user_id(+)
--   AND a.memo_type    LIKE '300%' -- Special Instructions only...
ORDER BY a.memo_id
;


