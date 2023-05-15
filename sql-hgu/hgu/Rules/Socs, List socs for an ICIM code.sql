--== List the socs for a specific ICIM/SID code.
select a.*, b.icim_product_code, b.comments
  from socs a, icim_product b
 where a.soc_type          = b.soc_type
   and a.soc_group         = b.soc_group
   and b.icim_product_code IN ( 'STOP_CLI', 'VOICEMAIL_MINI', 'GPRS', 'WAP' )
  order by a.soc, a.soc_type, a.soc_group;

--== v1.0 :: List the priceplans and socs for a specific combination of priceplan & ICIM/SID code
select b.priceplan_code, b.icim_subscription_type,  c.soc, c.soc_type, c.soc_group, d.icim_product_code, d.comments
  from subscription_types_socs a, priceplans b, socs c, icim_product d
 where (a.subscription_type_id  LIKE b.priceplan_code || '%'
     or a.subscription_type_id  LIKE '%' || b.priceplan_code)
   and b.priceplan_code         in ( 'PPUE' )
   and b.icim_subscription_type in ( 'FLEXI_TALK' )
   and a.soc                    = c.soc
   and c.soc_type               = d.soc_type
   and c.soc_group              = d.soc_group
   and d.icim_product_code      IN ( 'GPRS', 'ID_DOUBLE', 'SURF_S_PRIV', 'SURF_S_PRIV_PROMO' )
  order by b.priceplan_code, b.icim_subscription_type,  c.soc, c.soc_type, c.soc_group;

--== v1.1 :: List the priceplans and socs for a specific combination of priceplan & ICIM/SID code
SELECT UNIQUE b.priceplan_code AS "PRICEPLAN", b.icim_subscription_type AS "ICIM_PRICEPLAN",
              b.icim_additional_offering AS "ICIM_OFFERING",  c.soc, c.soc_type, c.soc_group,
              d.icim_product_code, d.comments, a.modify_mode
  FROM subscription_types_socs a, icim_order_to_subscription b, socs c, icim_product d
 WHERE (a.subscription_type_id    LIKE b.priceplan_code || '%'
     OR a.subscription_type_id    LIKE '%' || b.priceplan_code)
--   AND a.add_mode             NOT IN ( 'N' )
   AND SYSDATE               BETWEEN a.effective_date AND a.expiration_date
--   AND b.icim_subscription_type   IN ( 'C_PREMIUM' )
--   AND b.icim_additional_offering IN ( 'REGULAR' )
   AND a.soc                      = c.soc
   AND c.soc_type                 = d.soc_type
   AND c.soc_group                = d.soc_group
--   AND d.icim_product_code        IN ( 'MMS' )
  ORDER BY b.priceplan_code, b.icim_subscription_type, b.icim_additional_offering,  c.soc, c.soc_type, c.soc_group;



select a.subscription_type_id, b.icim_subscription_type
  from subscription_types_socs a, NINJARULES_ST.priceplans b
 where (a.subscription_type_id  LIKE b.priceplan_code || '%'
     or a.subscription_type_id  LIKE '%' || b.priceplan_code)
   and b.icim_subscription_type in ( 'FLEXI_TALK' )
;

select c.*, d.icim_product_code, d.comments
  from socs c, icim_product d
 where c.soc_type          = d.soc_type
   and c.soc_group         = d.soc_group
   and d.icim_product_code IN ( 'PRESENCE' )
  order by c.soc, c.soc_type, c.soc_group;


SELECT UNIQUE b.priceplan_code AS "PRICEPLAN", b.icim_subscription_type AS "ICIM_PRICEPLAN",
              b.icim_additional_offering AS "ICIM_OFFERING",  c.soc, c.soc_type, c.soc_group,
              d.icim_product_code, d.comments, a.channel_mode_for_modification
  FROM sub_typ_soc_channel a, icim_order_to_subscription b, socs c, icim_product d
 WHERE (a.subscription_type_id    LIKE b.priceplan_code || '%'
     OR a.subscription_type_id    LIKE '%' || b.priceplan_code)
--   AND a.add_mode             NOT IN ( 'N' )
   AND SYSDATE               BETWEEN a.effective_date AND a.expiration_date
   AND b.icim_subscription_type   IN ( 'C_BEDRIFT' )
   AND b.icim_additional_offering IN ( 'REGULAR' )
   AND a.soc                      = c.soc
   AND c.soc_type                 = d.soc_type
   AND c.soc_group                = d.soc_group
   AND d.icim_product_code        IN ( 'INTFRITIDFREE' )
  ORDER BY b.priceplan_code, b.icim_subscription_type, b.icim_additional_offering,  c.soc, c.soc_type, c.soc_group;

SELECT
  t1.subscription_type_id,
  t1.soc,
  t1.add_mode,
  t1.modify_mode,
  t1.delete_mode,
  t1.displayable,
  t1.ninja_mode_activate,
  t1.ninja_mode_change,
  t1.ninja_mode_delete,
  t1.ninja_replacement_soc,
  t1.overidden_by_soc,
  t1.additionally_adds_soc,
  t1.ninja_default_soc,
  t2.soc_type,
  t2.soc_group,
  t5.language_code,
  t5.description
FROM
  subscription_types_socs t1,
  socs t2,
  socs_descriptions t5
WHERE
  t1.subscription_type_id = 'PLAAREG1'
AND t1.soc                = 'CHFRITIDF'
AND
  (
    t1.add_mode             IN ('A','O','R')
  OR t1.ninja_mode_activate IN ('A','M')
  )
AND t2.soc                                                      = t1.soc
AND t5.soc                                                      = t2.soc
AND t5.language_code                                            = 'NO'
AND t1.effective_date                                          <= TO_DATE('20111123', 'YYYYMMDD')
AND NVL(t1.expiration_date, TO_DATE('20111123', 'YYYYMMDD')+1) >= TO_DATE(
  '20111123', 'YYYYMMDD');