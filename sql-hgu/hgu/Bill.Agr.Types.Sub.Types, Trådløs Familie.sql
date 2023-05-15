--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display all entries for a Trådløs Familie agreement. ==--==--==--==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.bill_agr_types_sub_id, a.agreement_type, a.ban_tree_ind,
       a.account_type, a.account_sub_type, a.org_priceplan,
       a.new_priceplan, a.org_commitment_band, a.new_commitment_months,
       a.new_campaign_id, a.remaining_com_months,
       a.subscription_type_id, a.effective_date, a.expiration_date,
       a.handset_provisioning
  FROM ninjarules.bill_agr_types_sub_types a
  WHERE a.account_type     = 'I'
    AND a.account_sub_type = 'FB'

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the priceplans allowed on a Trådløs Familie agreement. --==--==--==
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT DISTINCT a.new_priceplan
  FROM ninjarules.bill_agr_types_sub_types a
  WHERE a.account_type     = 'I'
    AND a.account_sub_type = 'FB'
  ORDER BY a.new_priceplan

