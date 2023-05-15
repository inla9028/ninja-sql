SELECT a.*
  FROM subscriber a
 WHERE a.subscriber_no = 'GSM047' || '91548690'
;

SELECT pd.*
  FROM physical_device pd
 WHERE pd.customer_id   = 266030014
   AND pd.subscriber_no = 'GSM047' || '91548690'
;

-- eSIM: 08947080041000000019

SELECT a.*
  FROM serial_item_inv a
 WHERE a.serial_number = '08947080041000000019'
;

-- SELECT a.sim_number, a.reserve_id, a.reserve_date, a.status,
--       a.last_update_date, a.dealer_code, a.hlr, a.imsi, a.location,
--       a.pin, a.pin2, a.puk, a.puk2, a.sim_type, a.matching_id
SELECT a.serial_number, 'TERJE_B_SAMSUNG_WATCH', a.curr_possession_dt, 'RESERVED'
     , a.sys_update_date, 'NENI', a.hlr_cd, a.imsi, a.location_id
     , a.initial_pin, a.initial_pin2, a.puk, a.puk2, a.sim_type, a.matching_id
  FROM serial_item_inv a
 WHERE a.serial_number = '08947080041000000019'
;
