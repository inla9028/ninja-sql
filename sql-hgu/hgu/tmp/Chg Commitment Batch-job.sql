SELECT t1.bill_agr_types_sub_id, t1.agreement_type, t1.ban_tree_ind,
       t1.account_type, t1.account_sub_type, t1.new_priceplan,
       t1.new_campaign_id, t1.new_commitment_months, t1.subscription_type_id,
       t1.handset_provisioning, t3.description, t1.org_commitment_band,
       t1.remaining_com_months
  FROM bill_agr_types_sub_types t1, commitment_band t6, bill_agr_typ_sub_x_desc t2,
       bill_agr_types_sub_types_desc t3, bill_agr_typ_channel t5
  WHERE t2.bill_agr_types_sub_id = t1.bill_agr_types_sub_id
    AND t1.bill_agr_types_sub_id = t5.bill_agr_types_sub_id
    AND t5.channel_code = 'NINJAMASTER'
    AND t3.bill_agr_name_id = t2.bill_agr_name_id
    AND t2.language_code = 'NO'
    AND t1.agreement_type = 'R'
    AND t1.ban_tree_ind = 'Y'
    AND t1.account_type like 'B'
    AND t1.account_sub_type like 'V'
    AND t1.org_priceplan = 'PSTB'
    AND t1.org_commitment_band =  t6.commitment_band_code
    AND 24 BETWEEN t6.commitment_months_from AND t6.commitment_months_to
--    AND t1.remaining_com_months >= 16
    AND t1.new_commitment_months = 24
    AND to_date('20071029', 'yyyyMMdd') BETWEEN t5.effective_date AND t5.expiration_date
    AND to_date('20071029', 'yyyyMMdd') BETWEEN t1.effective_date AND t1.expiration_date
