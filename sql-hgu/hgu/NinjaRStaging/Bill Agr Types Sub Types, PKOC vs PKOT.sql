SELECT a.bill_agr_types_sub_id, a.agreement_type, a.ban_tree_ind,
       a.account_type, a.account_sub_type, a.org_priceplan,
       a.new_priceplan, a.org_commitment_band, a.new_commitment_months,
       a.new_campaign_id, a.remaining_com_months,
       a.subscription_type_id, a.effective_date, a.expiration_date,
       a.handset_provisioning
  FROM bill_agr_types_sub_types a
  WHERE a.new_priceplan IN ('PKOC', 'PKOT')
    AND a.org_priceplan IN ('PKOC', 'PKOT')
    AND a.new_priceplan != a.org_priceplan
    AND a.bill_agr_types_sub_id IN (22145, 22133)
  ORDER BY a.org_priceplan, a.bill_agr_types_sub_id

