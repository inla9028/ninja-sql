/******************************************************************************
** From PP: 'PPBA', 'PPBB', 'PPBF', 'PPTC', 'PPTF', 'PPTJ', 'PPUA', 'PPUV'
** To.....: SMART 1 GB (PPUR)
******************************************************************************
** From PP: 'PPBC', 'PPBD', 'PPBE', 'PPTA' , 'PPTE'
** To.....: SMART 1 GB med 50kr rabatt i 1 år (PPUR + NSHAPExx)
******************************************************************************
** From PP: 'PPTZ', 'PPUK'
** To.....: SMART Basis (PPUS)
******************************************************************************/

/*
** Check that Ninja has rules for a certain set of pp-changes.
*/
SELECT 'SMART 1 GB' AS "TARGET"
     , au.current_priceplan, au.new_priceplan, COUNT(1) AS "CAMPAIGN_COUNT"
  FROM ninjarules.allowable_upgrades au
 WHERE au.current_priceplan IN ('PPBA', 'PPBB', 'PPBF', 'PPTC', 'PPTF', 'PPTJ', 'PPUA', 'PPUV')
   AND au.new_priceplan       = 'PPUR'
   AND SYSDATE BETWEEN au.effective_date AND au.expiry_date
GROUP BY au.current_priceplan, au.new_priceplan
UNION
SELECT 'SMART 1 GB med 50kr rabatt i 1 år' AS "TARGET"
     , au.current_priceplan, au.new_priceplan, COUNT(1) AS "CAMPAIGN_COUNT"
  FROM ninjarules.allowable_upgrades au
 WHERE au.current_priceplan IN ('PPBC', 'PPBD', 'PPBE', 'PPTA' , 'PPTE')
   AND au.new_priceplan       = 'PPUR'
   AND SYSDATE BETWEEN au.effective_date AND au.expiry_date
GROUP BY au.current_priceplan, au.new_priceplan
UNION
SELECT 'SMART Basis' AS "TARGET"
     , au.current_priceplan, au.new_priceplan, COUNT(1) AS "CAMPAIGN_COUNT"
  FROM ninjarules.allowable_upgrades au
 WHERE au.current_priceplan IN ('PPTZ', 'PPUK')
   AND au.new_priceplan       = 'PPUS'
   AND SYSDATE BETWEEN au.effective_date AND au.expiry_date
GROUP BY au.current_priceplan, au.new_priceplan
ORDER BY 1, 2, 3, 4
;

/*
** List Ninja's change-pp rules, including campaigns...
*/
SELECT 'SMART 1 GB' AS "TARGET"
     , au.current_priceplan, au.new_priceplan, au.new_campaign, COUNT(1) AS "CAMPAIGN_COUNT"
  FROM ninjarules.allowable_upgrades au
 WHERE au.current_priceplan IN ('PPBA', 'PPBB', 'PPBF', 'PPTC', 'PPTF', 'PPTJ', 'PPUA', 'PPUV')
   AND au.new_priceplan       = 'PPUR'
   AND SYSDATE BETWEEN au.effective_date AND au.expiry_date
GROUP BY au.current_priceplan, au.new_priceplan, au.new_campaign
UNION
SELECT 'SMART 1 GB med 50kr rabatt i 1 år' AS "TARGET"
     , au.current_priceplan, au.new_priceplan, au.new_campaign, COUNT(1) AS "CAMPAIGN_COUNT"
  FROM ninjarules.allowable_upgrades au
 WHERE au.current_priceplan IN ('PPBC', 'PPBD', 'PPBE', 'PPTA' , 'PPTE')
   AND au.new_priceplan       = 'PPUR'
   AND SYSDATE BETWEEN au.effective_date AND au.expiry_date
GROUP BY au.current_priceplan, au.new_priceplan, au.new_campaign
UNION
SELECT 'SMART Basis' AS "TARGET"
     , au.current_priceplan, au.new_priceplan, au.new_campaign, COUNT(1) AS "CAMPAIGN_COUNT"
  FROM ninjarules.allowable_upgrades au
 WHERE au.current_priceplan IN ('PPTZ', 'PPUK')
   AND au.new_priceplan       = 'PPUS'
   AND SYSDATE BETWEEN au.effective_date AND au.expiry_date
GROUP BY au.current_priceplan, au.new_priceplan, au.new_campaign
ORDER BY 1, 2, 3, 4
;

/*
** List any mandatory socs for the target priceplans
*/
SELECT 'NINJA' AS "SOURCE"
     , sts.subscription_type_id, cs.soc AS "SOC_1", cs.coexisting_soc AS "SOC_2"
  FROM subscription_types_socs sts, coexisting_socs cs, subscription_types_socs sts2
 WHERE SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.subscription_type_id IN ( 'PPUR' || 'REG1', 'PPUS' || 'REG1' )
   AND sts.ninja_mode_activate   = 'M'
   AND sts.soc                  IN (cs.soc, cs.coexisting_soc)
   AND cs.coexisting_mode        = 'I'
   AND sts2.soc                 IN (cs.soc, cs.coexisting_soc)
   AND sts.subscription_type_id  = sts2.subscription_type_id
   AND SYSDATE              BETWEEN sts2.effective_date AND sts2.expiration_date
   AND sts.soc                  != sts2.soc
UNION
SELECT 'FOKUS' AS "SOURCE"
     , sts.subscription_type_id, RTRIM(sic.soc_first) AS "SOC_1", RTRIM(sic.soc_second) AS "SOC_2"
  FROM subscription_types_socs sts, soc_illegal_comb@fokus sic, subscription_types_socs sts2
 WHERE SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.subscription_type_id IN ( 'PPUR' || 'REG1', 'PPUS' || 'REG1' )
   AND sts.ninja_mode_activate   = 'M'
   AND sts.soc                  IN (RTRIM(sic.soc_first), RTRIM(sic.soc_second))
   AND sic.illegal_ind           = 'Y'
   AND sts2.soc                 IN (RTRIM(sic.soc_first), RTRIM(sic.soc_second))
   AND sts.subscription_type_id  = sts2.subscription_type_id
   AND SYSDATE              BETWEEN sts2.effective_date AND sts2.expiration_date
   AND sts.soc                  != sts2.soc
   AND NOT (sts.subscription_type_id  LIKE RTRIM(sic.soc_first)  || '%'
         OR sts.subscription_type_id  LIKE RTRIM(sic.soc_second) || '%'
         OR sts2.subscription_type_id LIKE RTRIM(sic.soc_first)  || '%'
         OR sts2.subscription_type_id LIKE RTRIM(sic.soc_second) || '%')
ORDER BY 1,2,3,4
;

/*
** List any mandatory socs for the target priceplans
*/
SELECT 'NINJA' AS "SOURCE"
     , sts.subscription_type_id, cs.soc AS "SOC_1", cs.coexisting_soc AS "SOC_2"
  FROM subscription_types_socs sts, coexisting_socs cs, subscription_types_socs sts2
 WHERE SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.subscription_type_id IN ( 'PPUR' || 'REG1', 'PPUS' || 'REG1' )
--   AND sts.ninja_mode_activate   = 'M'
   AND sts.soc                  IN (cs.soc, cs.coexisting_soc)
   AND cs.coexisting_mode        = 'I'
   AND sts2.soc                 IN (cs.soc, cs.coexisting_soc)
   AND sts.subscription_type_id  = sts2.subscription_type_id
   AND SYSDATE              BETWEEN sts2.effective_date AND sts2.expiration_date
   AND sts.soc                  != sts2.soc
UNION
SELECT 'FOKUS' AS "SOURCE"
     , sts.subscription_type_id, RTRIM(sic.soc_first) AS "SOC_1", RTRIM(sic.soc_second) AS "SOC_2"
  FROM subscription_types_socs sts, soc_illegal_comb@fokus sic, subscription_types_socs sts2
 WHERE SYSDATE BETWEEN sts.effective_date AND sts.expiration_date
   AND sts.subscription_type_id IN ( 'PPUR' || 'REG1', 'PPUS' || 'REG1' )
--   AND sts.ninja_mode_activate   = 'M'
   AND sts.soc                  IN (RTRIM(sic.soc_first), RTRIM(sic.soc_second))
   AND sic.illegal_ind           = 'Y'
   AND sts2.soc                 IN (RTRIM(sic.soc_first), RTRIM(sic.soc_second))
   AND sts.subscription_type_id  = sts2.subscription_type_id
   AND SYSDATE              BETWEEN sts2.effective_date AND sts2.expiration_date
   AND sts.soc                  != sts2.soc
   AND NOT (sts.subscription_type_id  LIKE RTRIM(sic.soc_first)  || '%'
         OR sts.subscription_type_id  LIKE RTRIM(sic.soc_second) || '%'
         OR sts2.subscription_type_id LIKE RTRIM(sic.soc_first)  || '%'
         OR sts2.subscription_type_id LIKE RTRIM(sic.soc_second) || '%')
ORDER BY 1,2,3,4
;
