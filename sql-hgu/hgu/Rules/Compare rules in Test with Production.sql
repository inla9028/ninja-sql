--== Display the rules for a priceplan, that isn't already in production.
--== Note: This query needs to be run by the NINJARULES user, in order to
--== use the db-link properly.
SELECT a.bill_agr_types_sub_id, a.agreement_type, a.ban_tree_ind,
       a.account_type, a.account_sub_type, a.org_priceplan,
       a.new_priceplan, a.org_commitment_band, a.new_commitment_months,
       a.new_campaign_id, a.remaining_com_months,
       a.subscription_type_id, a.effective_date, a.expiration_date,
       a.handset_provisioning, a.move_expiration_date
  FROM ninjastrules.bill_agr_types_sub_types a
  WHERE a.new_priceplan = 'PSFW'
    AND NOT EXISTS (
      SELECT '' FROM bill_agr_types_sub_types@ninjamain b 
        WHERE a.agreement_type = b.agreement_type
            AND a.ban_tree_ind = b.ban_tree_ind
            AND a.account_type = b.account_type
            AND a.account_sub_type = b.account_sub_type
            AND a.org_priceplan = b.org_priceplan
            AND a.new_priceplan = b.new_priceplan
            AND a.org_commitment_band = b.org_commitment_band
            AND a.new_commitment_months = b.new_commitment_months
            AND a.new_campaign_id = b.new_campaign_id
            AND a.remaining_com_months = b.remaining_com_months
            AND a.subscription_type_id = b.subscription_type_id
            AND a.handset_provisioning = b.handset_provisioning)
