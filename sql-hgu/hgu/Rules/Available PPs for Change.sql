SELECT t5.channel_code, t1.bill_agr_types_sub_id, t1.agreement_type, t1.ban_tree_ind, t1.account_type, t1.account_sub_type, 
       t1.org_priceplan, t1.new_priceplan, t1.new_campaign_id, t1.new_commitment_months, t1.subscription_type_id, 
       t1.handset_provisioning, t3.language_code, t3.description, t1.org_commitment_band, t1.remaining_com_months,
       t1.effective_date, t1.expiration_date
  FROM bill_agr_types_sub_types t1,
       commitment_band t6,
       bill_agr_typ_sub_x_desc t2, 
       bill_agr_types_sub_types_desc t3, 
       bill_agr_typ_channel t5 
  WHERE t2.bill_agr_types_sub_id = t1.bill_agr_types_sub_id
    AND t1.bill_agr_types_sub_id = t5.bill_agr_types_sub_id
    AND t5.channel_code          = 'DOWE' 
    AND t3.bill_agr_name_id      = t2.bill_agr_name_id
    AND t2.language_code         = 'NO' 
    AND t1.agreement_type        = 'R' 
    AND t1.ban_tree_ind          = 'N' 
    AND t1.account_type       LIKE 'I' 
    AND t1.account_sub_type   LIKE 'R' 
    AND t1.org_priceplan       IN ('PPTF')
    AND t1.new_priceplan       IN ('PPTE')
--    AND t1.org_commitment_bAND =  t6.commitment_bAND_code 
--    AND 12 BETWEEN t6.commitment_months_from AND t6.commitment_months_to -- existing campaign commitment
--    AND t1.remaining_com_months >= 12
--    AND t1.org_priceplan not in ('___NEW___')
--    AND t1.org_priceplan in ('PPTF')
--    AND t1.new_priceplan in ('PPOA')
--    AND t1.new_campaign_id       = 'RIPTE2400'
    AND t1.new_campaign_id      != '000000000'
--    AND t1.subscription_type_id = 'PSFUREG1'
--    AND 'PSFO' in (t1.org_priceplan, t1.new_priceplan)

