/*
** Mark the current number, Ctrl+H and replace...
*/
SELECT mhr.msisdn_begin_range, mhr.msisdn_end_range, mhr.phy_hlr,
       mhr.sys_creation_date, mhr.description, lp.phd_id
  FROM msisdn_hlr_relation mhr, logic_phd lp
 WHERE mhr.phy_hlr = lp.logical_dvc_id
   AND '047'||'93170000' BETWEEN mhr.msisdn_begin_range AND mhr.msisdn_end_range
   AND LENGTH('047'||'93170000') = LENGTH(mhr.msisdn_begin_range)
ORDER BY mhr.msisdn_begin_range
;

/*
** Via db-link...
*/
SELECT /*+ driving_site(mhr)*/
       mhr.msisdn_begin_range, mhr.msisdn_end_range, mhr.phy_hlr,
       mhr.sys_creation_date, mhr.description, lp.phd_id
--     , mhr.*
--     , lp.* 
  FROM msisdn_hlr_relation@fokus mhr, logic_phd@fokus lp
 WHERE mhr.phy_hlr = lp.logical_dvc_id
   AND '047'||'93170000' BETWEEN mhr.msisdn_begin_range AND mhr.msisdn_end_range
   AND LENGTH('047'||'93170000') = LENGTH(mhr.msisdn_begin_range)
ORDER BY mhr.msisdn_begin_range
;

/*
** List the HLR and Physical HLR of a SIM.
*/
SELECT a.serial_number, a.item_id, a.hlr_cd
     , p.phd_id, p.market_code
     , a.operator_id, u.user_full_name
  FROM serial_item_inv a, users u, logic_phd p
 WHERE a.serial_number = '08947080099001251478'
   AND a.operator_id   = u.user_id(+)
   AND a.hlr_cd        = p.logical_dvc_id(+)
ORDER BY 1
;

/*
** ...and via db-link...
*/
SELECT /*+ driving_site(a)*/ 
       a.serial_number, a.item_id, a.hlr_cd
     , p.phd_id, p.market_code
     , a.operator_id, u.user_full_name
  FROM serial_item_inv@fokus a, users@fokus u, logic_phd@fokus p
 WHERE a.serial_number = '08947080099001251478'
   AND a.operator_id   = u.user_id(+)
   AND a.hlr_cd        = p.logical_dvc_id(+)
ORDER BY 1
;

/*
** List all number-ranges with a certain HLR.
*/
SELECT mhr.msisdn_begin_range, mhr.msisdn_end_range, mhr.phy_hlr,
       mhr.sys_creation_date, mhr.description
  FROM msisdn_hlr_relation mhr
 WHERE mhr.phy_hlr = '03'
ORDER BY mhr.msisdn_begin_range
;

/*
** Again, via db-link.
*/
SELECT /*+ driving_site(mhr)*/
       mhr.msisdn_begin_range, mhr.msisdn_end_range, mhr.phy_hlr,
       mhr.sys_creation_date, mhr.description
  FROM msisdn_hlr_relation@fokus mhr
 WHERE mhr.phy_hlr = '03'
ORDER BY mhr.msisdn_begin_range
;
