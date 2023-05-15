select a.*
  from serial_item_inv a
;

select a.*
  from all_tables a
 where a.table_name LIKE '%HLR%'
;

select a.*
  from MSISDN_HLR_RELATION a
;

select a.phy_hlr, a.description, count(*) as "COUNT"
  from MSISDN_HLR_RELATION a
GROUP BY a.phy_hlr, a.description
ORDER BY a.phy_hlr, a.description
;

select a.*
  from physical_device a
 where a.equipment_no = '358848044454494'
;

select a.customer_id, a.subscriber_no, a.equipment_no, a.device_type,
       a.sys_creation_date, a.sys_update_date, a.expiration_date, a.dealer_code,
       u.user_id, u.user_full_name
  from physical_device a, users u
 where a.equipment_no = '011774004431158' -- '358848044454494'
   and a.operator_id  = u.user_id
order by a.sys_creation_date
;
