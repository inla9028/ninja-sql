SELECT a.*
  FROM sp_services_mapping a
ORDER BY 1,2,3
;

SELECT a.*
  FROM tn_inv@fokus a
 WHERE a.ctn = '047'||'90440666'
;

SELECT a.nl, a.ngp, count(1) AS "COUNT"
  FROM tn_inv@fokus a
GROUP BY a.nl, a.ngp
ORDER BY 1,2
;
   

SELECT a.*
  FROM tn_inv@fokus a
 WHERE a.nl         = 'SVE'
   AND a.ngp        = 'A'
   AND a.ctn_status = 'AA'
   AND a.ctn BETWEEN '04790440000' AND '04790450000'
   AND ROWNUM       < 101
ORDER BY 1
;

SELECT a.*
  FROM sim_type@fokus a
 WHERE a.sim_type_id = 442 -- Svea
ORDER BY a.sim_type_id
;

SELECT s.*
  FROM serial_item_inv@fokus s
 WHERE s.sim_type           = 442 -- SIM_TYPE 442 = 'YT MID UICC E1', physical_hlr_cd = 58
   AND s.curr_possession    = 'A'
   AND s.comited_to_pos_ind = 'N'
   AND ROWNUM               < 11
;

SELECT a.*
  FROM ninja_dealer_fokus_user a
 WHERE a.dealer_code = 'SP07'
;
 
