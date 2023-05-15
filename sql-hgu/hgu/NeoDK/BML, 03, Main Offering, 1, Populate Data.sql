--==
--== First overview...
--==
select a.icim_order_type as "ORDER_TYPE",
       a.icim_subscription_type || '.' || a.icim_additional_offering as "OFFERING_CODE",
       a.priceplan_code as "BASE_CODE",
       a.campaign_code as "CAMPAIGN",
       '' as "PROMO",
       b.id as "BILLING_SYSTEM_ID"
  from icim_order_to_subscription a, bml_billing_system b
 where a.icim_subscription_type      = 'DATA_FLEXPU_BIZ'
   and a.icim_product_agreement_code = b.brand
   and b.billing_system              = 'FOKUS'
order by a.icim_subscription_type, a.icim_additional_offering, a.icim_order_type
;

--==
--== Second overview...
--==
INSERT INTO bml_main_product_mapping
(
    order_type, offering_code, base_code, campaign, promo, billing_system_id
)
select * from (
  select a.icim_order_type as "ORDER_TYPE",
         a.icim_subscription_type || '.' || a.icim_additional_offering as "OFFERING_CODE",
         a.priceplan_code as "BASE_CODE",
         a.campaign_code as "CAMPAIGN",
         '' as "PROMO",
         b.id as "BILLING_SYSTEM_ID"
    from icim_order_to_subscription a, bml_billing_system b
   where a.icim_subscription_type      = 'DATA_FLEXPU_BIZ'
     and a.icim_product_agreement_code = b.brand
     and b.billing_system              = 'FOKUS'
  order by a.icim_subscription_type, a.icim_additional_offering, a.icim_order_type
)
;

--==
--== Final overview...
--==
INSERT INTO bml_main_product_mapping
(
    order_type, offering_code, base_code, campaign, promo, billing_system_id
)
select distinct * from (
  select a.icim_order_type as "ORDER_TYPE",
         a.icim_subscription_type || '.' || a.icim_additional_offering as "OFFERING_CODE",
         a.priceplan_code as "BASE_CODE",
         a.campaign_code as "CAMPAIGN",
         '' as "PROMO",
         b.id as "BILLING_SYSTEM_ID"
    from icim_order_to_subscription a, bml_billing_system b
   where a.icim_product_agreement_code = b.brand
     and b.billing_system              = 'FOKUS'
  order by a.icim_subscription_type, a.icim_additional_offering, a.icim_order_type
)
;
