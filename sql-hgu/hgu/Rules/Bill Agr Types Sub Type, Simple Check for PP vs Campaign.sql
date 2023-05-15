select a.new_priceplan, a.new_campaign_id, b.icim_additional_offering, count(1) as "COUNT"
  from bill_agr_types_sub_types a, campaigns b
 where 1 = 1
   and sysdate between a.effective_date and a.expiration_date
   and a.new_campaign_id  = b.campaign_code
   and a.new_priceplan   IN ( 'FLEXPA25', 'FLEXPA26', 'FLEXPA27', 'FLEXPA28' )
   and a.new_campaign_id IN ( 'SPOTPA25', 'SPOTPA26', 'SPOTPA27', 'SPOTPA28' )
group by a.new_priceplan, a.new_campaign_id, b.icim_additional_offering
order by a.new_priceplan, a.new_campaign_id, b.icim_additional_offering
;