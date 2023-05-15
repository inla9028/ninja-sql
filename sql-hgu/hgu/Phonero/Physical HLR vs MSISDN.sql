SELECT t1.msisdn_begin_range, t1.msisdn_end_range, t1.phy_hlr,
       t1.sys_creation_date, t1.description, t2.phd_id
  FROM msisdn_hlr_relation t1, logic_phd t2
 WHERE t1.phy_hlr = t2.logical_dvc_id
   AND '04747230005' BETWEEN msisdn_begin_range AND msisdn_end_range
   AND LENGTH('04747230005') = LENGTH(msisdn_begin_range)
ORDER BY t1.msisdn_begin_range
;

SELECT ti.nl, ti.ngp, mhr.phy_hlr, mhr.msisdn_begin_range, mhr.msisdn_end_range, COUNT(1) AS "COUNT"
  FROM tn_inv ti, msisdn_hlr_relation mhr
 WHERE ti.nl         = 'PHO'
   AND ti.ngp        = 'A'
   AND ti.ctn  BETWEEN mhr.msisdn_begin_range AND mhr.msisdn_end_range
   AND LENGTH(ti.ctn) = LENGTH(mhr.msisdn_begin_range)
GROUP BY ti.nl, ti.ngp, mhr.phy_hlr, mhr.msisdn_begin_range, mhr.msisdn_end_range
ORDER BY 1,2,3,4
;

