SELECT RTRIM(sr.soc_dest) AS "SOC_DEST", sr.relation_type, sr.src_effective_date
     , sr.dest_effective_date, sr.expiration_date, RTRIM(s.soc) AS "SOC"
     , s.soc_status, s.for_sale_ind, s.service_type, s.effective_date
     , s.sale_eff_date, s.sale_exp_date, RTRIM(s.soc_description) AS "SOC_DESCRIPTION"
     , s.soc_level_code, s.customer_type, s.minimum_no_months
     , pt.duration, pt.duration_ind, pt.pp_ind, pt.auto_renewal_ind, pt.cut_date
FROM /*+ driving_site(s)*/
     soc@fokus              s,
     soc_relation@fokus     sr,
     promotion_terms@fokus  pt,
     soc_credit_class@fokus scc
WHERE pt.soc                 = s.soc
  AND sr.soc_src             = s.soc
  AND sr.relation_type       = 'F'
  AND sr.src_effective_date <= SYSDATE 
  AND scc.soc                = S.SOC
  AND scc.credit_class      >= 'X'
  AND scc.effective_date     = S.EFFECTIVE_DATE
  AND SYSDATE          BETWEEN sr.dest_effective_date AND NVL(sr.expiration_date, SYSDATE + 1)
  AND SYSDATE          BETWEEN pt.effective_date      AND NVL(pt.expiration_date, SYSDATE + 1)
  AND SYSDATE          BETWEEN s.effective_date       AND NVL(s.expiration_date,  SYSDATE + 1)
  AND sr.soc_dest         LIKE 'INSURLS1%' -- Filter...
ORDER BY s.soc_level_code ASC, s.soc ASC
;