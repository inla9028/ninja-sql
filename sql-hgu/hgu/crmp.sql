--Displan Adapter queue
select MSG_ID, CODE, INTERNAL_ORDER_ID, REFERENCE_ID, STATUS, CREATION_DATE, SEND_RCV_DATE
   from XDP_OUTBOUND_MESSAGES_V
   -- where nvl(STATUS, 'X') <> 'Processed'
   order by CREATION_DATE


--Displan Adapter queue size
select count(1)
  from XDP_OUTBOUND_MESSAGES_V
--   where CODE = 'XXCU_CS'

-- Display Adapter queue size, divided into operations
SELECT a.code, COUNT(*) AS COUNT
  FROM xdp_outbound_messages_v a
  GROUP BY a.code
  ORDER BY a.code


-- Get the name of a service/priceplan
select
  b.segment1    PRICEPLAN,
  c.description DESCRIPTION,
  b.attribute13 CAMPAIGN
  from mtl_system_items_b b, mtl_system_items_tl c
  where b.inventory_item_id = c.inventory_item_id
    and c.language = 'N'
    and b.segment1 like 'VMSTO%'

-- Get the parent and root of a ban in next cycle...
select tree_root_ban, parent_ban, ban
  from ban_hierarchy_tree@cpx
  where ban = 693795403
     and expiration_date is null

-- Display the scripting table for the last two days
select
  ENABLING_PRODUCT_ID PRODUCT_ID,
  SUBSCRIBER,
  TASK,
  STATUS,
  CREATION_DATE,
  LAST_UPDATE_DATE LAST_UPDATED,
  ERROR_COUNT ERR_COUNT,
  ERROR_MESSAGE
  from xxcu.xxcu_enabling_products
    --where CREATION_DATE > sysdate - 2
    where SUBSCRIBER = '93066930'
    order by LAST_UPDATE_DATE

-- Display all the features for the specified subscriber 
select * from mdcust.service_feature
  where subscriber_no = 'GSM04790560639'


-- Bring the features over for the specified Subscriber and BAN
exec xxcu_convert_single_feature('GSM04790560639', 905207304)


-- Search for all with both SOCS
SELECT a.ban, a.subscriber_no, a.soc pp, b.soc soc
  FROM mdcust.service_agreement@cpx a, mdcust.service_agreement@cpx b
  WHERE a.ban = b.ban
    AND a.subscriber_no = b.subscriber_no
    AND a.soc = 'PSKV'
    AND b.soc = 'VMFRA'
    AND a.expiration_date > SYSDATE
    AND b.expiration_date > SYSDATE
	

-- Display current socs
SELECT ban, subscriber_no, soc
  FROM mdcust.service_agreement@cpx
  WHERE subscriber_no = 'GSM04793412571'
    AND expiration_date > SYSDATE
  order by soc

  
-- Display everyone with that soc...
SELECT ban, subscriber_no, soc
  FROM mdcust.service_agreement@cpx
  WHERE soc = 'VMBED'


--Display soc, pni cug for tb
select distinct
  c.attribute5 msisdn, d.attribute22 TBSOC, d.attribute21 TBPNI, d.attribute19 TBCUG 
  from hz_cust_accounts a, oe_order_headers_all b, oe_order_lines_all c, hz_parties d
    where c.header_id = b.header_id 
      and b.SOLD_TO_ORG_ID = a.cust_account_id
      and d.party_id = a.party_id
      and c.attribute5 in ('40003461', '40411116', '40499037', '41447572', '41564555', '41651065', '41651070', '48027233', '48168717', '48280303', '90032561', '90033893', '90122020', '90609689', '90625198', '90676271', '90682038', '90778920', '90833793', '90933664', '90972592', '90987532', '91112071', '91112072', '91112075', '91112085', '91169116', '91379672', '91379736', '91390703', '91532688', '91556688', '91575719', '91618024', '91628712', '91634167', '91664935', '91716640', '91756940', '91801485', '91833634', '91835885', '91845574', '92021253', '92031424', '92205521', '92243744', '92247618', '92298907', '92407777', '92425523', '92680248', '92689071', '92803387', '92803388', '92804179', '92810970', '92813231', '92883064', '92887959', '93006761', '93015034', '93022042', '93024595', '93028748', '93053184', '93060600', '93060618', '93060619', '93092614', '93096588', '93212246', '93229493', '93240512', '93252022', '93252425', '93412571', '93435051', '93481714', '93486034', '95074279', '95705171', '95917250', '95940053', '95940054', '97043859', '97125733', '97147750', '97184997', '97510550', '97544724', '97671870', '97745210', '98053001', '98205945', '98215647', '98215648', '98215649', '98217459', '98218627', '98225234', '98225235', '98225237', '98228992', '98231266', '98237738', '98239785', '98241849', '98254356', '98254365', '98254370', '98254372', '98254376', '98254378', '98254386', '98254387', '98254389', '98254390', '98254392', '98256551', '98256833', '98257709', '98262877', '98269584', '98269585', '98269587', '98283415', '98289575', '98290717', '98291290', '98299463')
	order by c.attribute5


-- Select soc, pni and cug from salesmaker
select b.value_key tbsoc, c.value_key tbpni, d.value_key tbcug
  from
    salesmaker.esm_orion_er9_multivalues@smot b,
    salesmaker.esm_orion_er9_multivalues@smot c,
    salesmaker.esm_orion_er9_multivalues@smot d
  where d.desc_key    = 'CUG'
    and d.value_key   = 'SKAAD'
	and d.man 		  = c.man
    and c.desc_key    = 'VPN-NR'
    and c.man 		  = b.man
    and b.desc_key 	  = 'TB MND AVG'
	

-- Display the priceplans allowed to switch to/from in BOL 
select
  c.description "PRICEPLAN_DESCRIPTION", b.inventory_item_id,
  b.segment1    "PRICEPLAN_CODE",        a.ui_def_id, 
  b.attribute13 "HANDSET_PROVISIONING",  b.attribute9 "INVALID_CHANGE_TO_PRICEPLANS",
  b.attribute8  "INVALID_BANS"
  from cz_model_publications a, mtl_system_items_b b, mtl_system_items_tl c 
  where b.inventory_item_id  = c.inventory_item_id
    and c.language           = 'N'  
    and a.top_item_id        = b.inventory_item_id
    and a.export_Status      = 'OK'
    and a.publication_mode   = 'p'
    and a.deleted_flag       = 0
    and a.source_target_flag = 'T'
    and a.applicable_until  >= sysdate
