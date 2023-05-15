/*
**
** List the priceplans and socs for a specific combination of priceplan & ICIM/SID code
**
*/
SELECT UNIQUE b.priceplan_code AS "PRICEPLAN", b.campaign_code AS "CAMPAIGN",
              b.icim_subscription_type AS "ICIM_PRICEPLAN",
              b.icim_additional_offering AS "ICIM_OFFERING", c.soc, c.soc_type, c.soc_group,
              d.icim_product_code, d.comments, a.modify_mode
  FROM subscription_types_socs a, icim_order_to_subscription b, socs c, icim_product d
 WHERE (a.subscription_type_id    LIKE b.priceplan_code || '%'
     OR a.subscription_type_id    LIKE '%' || b.priceplan_code)
   AND SYSDATE               BETWEEN a.effective_date AND a.expiration_date
   AND a.soc                      = c.soc
   AND c.soc_type                 = d.soc_type
   AND c.soc_group                = d.soc_group
--   AND b.icim_subscription_type   IN ( 'FIXED_DATA' ) -- The ICIM code of the price plan
   AND b.priceplan_code           = 'PLCB' -- The actual price plan code in Fokus
--   AND a.soc                      = 'CALLTRAVS' -- The actual SOC in Fokus.
--   AND d.icim_product_code        IN ( 'CALLTRANSFER' ) -- The ICIM code of additional products...
--   AND  b.campaign_code            = 'PPUQ12A1'
   /*
   ** Additional filters...
   */
--   AND b.icim_additional_offering LIKE 'TLF12LEASUF'
ORDER BY b.priceplan_code, b.icim_subscription_type, b.icim_additional_offering,  c.soc, c.soc_type, c.soc_group
;

/*
**
** Display a simple mapping from SOC to ICIM.
**
*/
select s.soc, i.icim_product_code, i.soc_type, i.soc_group, i.comments 
  from icim_product i, socs s
 where i.soc_type  = s.soc_type
   and i.soc_group = s.soc_group
   and s.soc       = 'CALLTRAVS'
;

/*
** Display the ICIM Additional Offerings available for a ...
*/
SELECT b.priceplan_code AS "PRICEPLAN", b.icim_subscription_type AS "ICIM_PRICEPLAN",
       b.icim_additional_offering AS "ICIM_OFFERING",  COUNT(1) AS "COUNT"
  FROM subscription_types_socs a, icim_order_to_subscription b, socs c, icim_product d
 WHERE (a.subscription_type_id    LIKE b.priceplan_code || '%'
     OR a.subscription_type_id    LIKE '%' || b.priceplan_code)
   AND SYSDATE               BETWEEN a.effective_date AND a.expiration_date
   AND a.soc                      = c.soc
   AND c.soc_type                 = d.soc_type
   AND c.soc_group                = d.soc_group
--   AND b.icim_subscription_type   IN ( 'FIXED_LARGE2' ) -- The ICIM code of the price plan
   AND b.priceplan_code           = 'PSBA' -- The actual price plan code in Fokus
--   AND a.soc                      = 'CALLTRAVS' -- The actual SOC in Fokus.
--   AND d.icim_product_code        IN ( 'CALLTRANSFER' ) -- The ICIM code of additional products...
   /*
   ** Additional filters...
   */
   --AND b.icim_additional_offering LIKE 'TLF12LEASUK'
GROUP BY b.priceplan_code, b.icim_subscription_type, b.icim_additional_offering
ORDER BY b.priceplan_code, b.icim_subscription_type, b.icim_additional_offering
;
