/*
**
** Norway/NetCom :: Locate an available equipment, for example a SIM?
**
*/
SELECT /*+ driving_site(a)*/
       a.serial_number, a.location_id, a.item_id, a.hlr_cd, a.sim_status,
       a.package_msisdn, a.imsi
  FROM serial_item_inv@fokus a
 WHERE a.item_ownership      = 'C'
   AND a.curr_possession     = 'A'
   AND a.comited_to_pos_ind  = 'N'
   AND a.missing_ind         = 'N'
   AND a.in_repair_ind       = 'N'
   AND a.in_transit_ind      = 'N'
   AND a.comited_to_pos_ind  = 'N'
   AND a.location_id         = 'NCLO'
   AND a.hlr_cd             IN ('66') -- 01 = NetCom, 10 = TeliaDK, 56 = Chess, 66 = Phonero
   AND a.sim_status         IN ('R')
   AND a.item_id      NOT LIKE 'DUAL%'
   AND ROWNUM                < 11
;

/*
**
** Denmark/TeliaDK :: Locate an available equipment, for example a SIM?
**
*/
SELECT a.serial_number, a.location_id, a.item_id, a.hlr_cd, a.sim_status,
       a.package_msisdn, a.imsi
  FROM serial_item_inv a
 WHERE a.item_ownership      = 'C'
   AND a.curr_possession     = 'A'
   AND a.comited_to_pos_ind  = 'N'
   AND a.missing_ind         = 'N'
   AND a.in_repair_ind       = 'N'
   AND a.in_transit_ind      = 'N'
   AND a.comited_to_pos_ind  = 'N'
   AND a.location_id         = 'TEMO'
   AND a.hlr_cd             IN ('10') -- 01 = NetCom, 10 = TeliaDK, 56 = Chess
   AND a.sim_status         IN ('R')
   AND a.item_id      NOT LIKE 'DUAL%'
;


select /*+ driving_site(a)*/
       a.serial_number, a.location_id, a.item_id, a.hlr_cd, a.sim_status,
       a.package_msisdn, a.imsi
  FROM serial_item_inv@fokus a
  WHERE a.serial_number = '08947080050400002772'
;

SELECT /*+ driving_site(a)*/ a.*
  FROM serial_item_inv@fokus a
  WHERE a.serial_number = '08947080050400002772'
;

