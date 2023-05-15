SELECT serial_number
  FROM serial_item_inv@fokus
WHERE  serial_number      = '08947080026001813296'
   AND item_ownership     = 'C'
   AND curr_possession    = 'A'
   AND comited_to_pos_ind = 'N'
   AND missing_ind        = 'N'
   AND in_repair_ind      = 'N'
   AND in_transit_ind     = 'N'
   AND location_id        = 'NCLO'
   AND sim_status         = 'R'
   AND package_msisdn    IS NULL
;

--
SELECT a.serial_number, a.item_ownership, a.curr_possession,
       a.comited_to_pos_ind, a.missing_ind, a.in_repair_ind, a.in_transit_ind,
       a.location_id, a.sim_status, NVL(a.package_msisdn, '(NULL)') AS "PACKAGE_MSISDN"
  FROM serial_item_inv@fokus a
 WHERE a.serial_number = '08947080026001813296'
;
