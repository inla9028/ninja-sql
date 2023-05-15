-- BAN status...
SELECT /*+ driving_site(b)*/
       b.ban, b.curr_root_ban, b.sys_creation_date, b.account_type, b.account_sub_type
     , b.ban_status, b.operator_id, u.user_full_name, b.credit_class
     , decode(b.bill_cycle, 99, '99 (Due to Billing)', b.bill_cycle) AS "BILL_CYCLE"
     , b.bl_last_prod_date, b.bl_prt_category
  FROM billing_account@fokus b, users@fokus u
 WHERE b.customer_id   IN ( 438133217 )
   AND b.operator_id   = u.user_id(+)
ORDER BY b.customer_id 
;

-- Addresses...
SELECT /*+ driving_site(s)*/
       anl.ban, /*anl.subscriber_no,*/ anl.link_type, anl.birth_date,
       nd.comp_reg_id, nd.first_name, nd.last_business_name, nd.additional_title,
       ad.adr_primary_ln, ad.adr_secondary_ln, ad.adr_email --, nd.*
  FROM address_name_link@fokus anl
     , name_data@fokus         nd
     , address_data@fokus      ad
 WHERE anl.ban            = 438133217
   AND anl.subscriber_no  = '0000000000'
   AND SYSDATE      BETWEEN anl.effective_date AND NVL(anl.expiration_date, SYSDATE + 1)
   AND anl.name_id        = nd.name_id
   AND anl.address_id     = ad.address_id
ORDER BY anl.ban, anl.subscriber_no, anl.link_type
;

-- Hierarchy...
SELECT a.tree_root_ban, a.ban, a.parent_ban, a.tree_level, a.effective_date, a.expiration_date
  FROM ban_hierarchy_tree@fokus a
 WHERE 438133217    IN (a.tree_root_ban, a.ban, a.parent_ban)
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
ORDER BY a.tree_level, a.tree_root_ban, a.ban, a.parent_ban
;

-- List cycle control...
SELECT cc.cycle_code, cc.cycle_start_date
     , MAX(cc.cycle_close_date) AS "CYCLE_CLOSE_DATE", cc.sys_creation_date
  FROM cycle_control@fokus cc
 WHERE cc.cycle_code IN (SELECT b.bill_cycle
                           FROM billing_account@fokus b
                           WHERE b.ban        = 438133217
                             AND b.ban_status = 'O')
GROUP BY cc.cycle_code, cc.cycle_start_date, "CYCLE_CLOSE_DATE", cc.sys_creation_date
ORDER BY 1, 2
;

-- List all future cycles
select cc.cycle_code, cc.cycle_start_date,
       max(cc.cycle_close_date) as "CYCLE_CLOSE_DATE", cc.sys_creation_date
  from cycle_control@fokus cc
 where trunc(sysdate, 'MON') < cc.cycle_start_date
   and sysdate               < cc.cycle_close_date
   and cc.cycle_code        in (
   select b.bill_cycle
     from billing_account@fokus b
     where b.ban        = 438133217
       and b.ban_status = 'O'
 )
group by cc.cycle_code, cc.cycle_start_date, "CYCLE_CLOSE_DATE", cc.sys_creation_date
order by cc.cycle_code
;


-- SOCs...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.campaign, a.soc_seq_no, a.effective_date
     , a.expiration_date, a.operator_id, u.user_full_name, a.application_id
  FROM service_agreement@fokus a, users@fokus u
 WHERE a.customer_id IN ( 438133217 )
   AND a.subscriber_no = '0000000000'
   AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1)
   AND a.operator_id   = u.user_id(+)
ORDER BY 1,2,3
;

-- Features...
SELECT /*+ driving_site(a)*/
       a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_effective_date, a.sys_update_date
     , a.ftr_expiration_date, a.feature_code, a.ftr_add_sw_prm
  FROM service_feature@fokus a
 WHERE a.subscriber_no = '0000000000'
   AND a.customer_id IN ( 438133217 )
   AND SYSDATE BETWEEN a.ftr_effective_date AND NVL(a.ftr_expiration_date, SYSDATE + 1)
--   AND a.soc LIKE 'VM%'
--   AND a.feature_code LIKE 'F-SWC%'
--   AND a.ftr_add_sw_prm LIKE '%IMEI%'
   AND a.ftr_add_sw_prm IS NOT NULL
ORDER BY a.ban, a.subscriber_no, a.soc, a.feature_code
;

-- Memos...
SELECT /*+ driving_site(a)*/
       a.memo_id, a.memo_ban, a.memo_subscriber, TO_CHAR(a.memo_date, 'YYYY-MM-DD HH24:MI:SS') AS "MEMO_DATE"
     , a.operator_id, u.user_full_name, a.memo_system_txt, a.memo_manual_txt
  FROM memo@fokus a, users@fokus u
 WHERE a.memo_ban        IN ( 438133217 )
 --  AND a.memo_subscriber IS NULL
   AND a.memo_date       > TRUNC(SYSDATE - 30, 'MON')
   AND a.operator_id     = u.user_id(+)
ORDER BY a.memo_id
;

select /*+ driving_site(a)*/ a.*
  from all_tables@fokus a
 where a.table_name like '%ORDER%'
order by 1,2,3
;
/*
ORDER_ADD_INFO
ORDER_DETAILS
ORDER_HEADER
ORDER_HEADER_28_010
ORDER_LINES_ADD_INFO
ORDER_PAYMENTS
*/

select /*+ driving_site(a)*/ a.*
  from order_details@fokus a
 where a.order_number IN ( 43, 48 )
order by 1,2,3
;

select /*+ driving_site(a)*/ a.*
  from order_header@fokus a
 where a.order_number IN ( 43, 48 )
order by 1,2,3
;

select /*+ driving_site(a)*/ a.*
  from ORDER_ADD_INFO@fokus a
 where a.order_number IN ( 43, 48 )
order by 1,2,3
;

select /*+ driving_site(a)*/ a.*
  from ORDER_LINES_ADD_INFO@fokus a
 where a.order_number IN ( 43, 48 )
order by 1,2,3
;

select /*+ driving_site(a)*/ a.*
  from ORDER_PAYMENTS@fokus a, order_header@fokus h
 where a.ban               = h.ban
   and a.external_order_id = h.external_order_id
   and h.order_number      IN ( 43, 48 )
order by 1,2,3
;
