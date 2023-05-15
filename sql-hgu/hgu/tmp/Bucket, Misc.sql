SELECT a.bill_agr_types_sub_id, a.agreement_type, a.ban_tree_ind,
       a.account_type, a.account_sub_type, a.org_priceplan,
       a.new_priceplan, a.org_commitment_band, a.new_commitment_months,
       a.new_campaign_id, a.remaining_com_months,
       a.subscription_type_id, a.effective_date, a.expiration_date,
       a.handset_provisioning, a.move_expiration_date
  FROM ninjaatrules.bill_agr_types_sub_types a
  WHERE a.org_priceplan IN ('PPTO', 'PPTP', 'PPTQ')


--
SELECT a.account_type, a.account_sub_type, /*a.org_priceplan,*/
       a.new_priceplan, a.new_campaign_id, COUNT(*) AS "COUNT"
  FROM ninjaatrules.bill_agr_types_sub_types a
  WHERE a.org_priceplan IN ('PPTO', 'PPTP', 'PPTQ')
  GROUP BY a.account_type, a.account_sub_type, /*a.org_priceplan,*/
           a.new_priceplan, a.new_campaign_id
  ORDER BY a.account_type, a.account_sub_type, /*a.org_priceplan,*/
           a.new_priceplan, a.new_campaign_id

--
SELECT a.new_priceplan, COUNT(*) AS "COUNT"
  FROM ninjaatrules.bill_agr_types_sub_types a
  WHERE a.org_priceplan IN ('PPTO', 'PPTP', 'PPTQ')
  GROUP BY a.new_priceplan
  ORDER BY a.new_priceplan

