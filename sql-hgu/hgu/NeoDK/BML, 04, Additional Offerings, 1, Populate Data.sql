
INSERT INTO bml_additional_product_mapping
(
  bundle, offering_code, base_code, promo_code, special_handling, billing_system_id
)
select * from (
  select c.icim_subscription_type || '.' || c.icim_additional_offering as "BUNDLE",
         d.icim_product_code as "OFFERING_CODE",
         a.soc  as "BASE_CODE",
         null   as "PROMO_CODE",
         null   as "SPECIAL_HANDLING",
         f.id   as "BILLING_SYSTEM_ID" -- 3: FOKUS / TELIADK
    from subscription_types_socs a, bill_agr_types_sub_types b,
         icim_order_to_subscription c, icim_product d, socs e,
         bml_billing_system f
   where sysdate between a.effective_date and a.expiration_date
     -- and a.subscription_type_id = 'I_TM_COMFORT'
     and a.subscription_type_id = b.subscription_type_id
     and sysdate between b.effective_date and b.expiration_date
     and b.new_priceplan        = c.priceplan_code
     and b.new_campaign_id      = c.campaign_code
     and a.soc                  = e.soc
     and e.soc_type             = d.soc_type
     and e.soc_group            = d.soc_group
     and c.icim_product_agreement_code = f.brand
     and f.billing_system              = 'FOKUS'
   group by c.icim_subscription_type || '.' || c.icim_additional_offering,
         d.icim_product_code, a.soc, null, null, f.id
   order by c.icim_subscription_type || '.' || c.icim_additional_offering,
         d.icim_product_code, a.soc, null, null, f.id
)
;






select a.*
  from subscription_types_socs a
 where sysdate between a.effective_date and a.expiration_date
   and a.subscription_type_id = 'I_TM_COMFORT'
order by a.subscription_type_id, a.soc
;

select distinct * from
(
select a.subscription_type_id, a.soc, b.new_priceplan, b.new_campaign_id,
       c.icim_subscription_type || '.' || c.icim_additional_offering as "BUNDLE",
       d.icim_product_code
  from subscription_types_socs a, bill_agr_types_sub_types b,
       icim_order_to_subscription c, icim_product d, socs e
 where sysdate between a.effective_date and a.expiration_date
   and a.subscription_type_id = 'I_TM_COMFORT'
   and a.subscription_type_id = b.subscription_type_id
   and sysdate between b.effective_date and b.expiration_date
   and b.new_priceplan        = c.priceplan_code
   and b.new_campaign_id      = c.campaign_code
   and a.soc                  = e.soc
   and e.soc_type             = d.soc_type
   and e.soc_group            = d.soc_group
order by a.subscription_type_id, a.soc
)
;

