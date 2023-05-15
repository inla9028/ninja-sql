--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the allowed priceplans for a given channel.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT * FROM (
  SELECT a.bill_agr_types_sub_id AS "SUB_ID", a.channel_code, b.new_priceplan,
         /*b.org_priceplan, */ b.account_type, b.account_sub_type,
         b.new_campaign_id, d.description
    FROM bill_agr_typ_channel          a,
         bill_agr_types_sub_types      b,
         bill_agr_typ_sub_x_desc       c,
         bill_agr_types_sub_types_desc d
--    WHERE a.channel_code          = 'DOWE'
    WHERE a.channel_code          = 'NINJAMASTER'
      AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
      AND a.bill_agr_types_sub_id = b.bill_agr_types_sub_id
      AND b.new_priceplan        IN ('PPTJ')
      AND b.new_campaign_id      IN ('PTJWB12N1', 'PTJWB12N2')
      AND SYSDATE BETWEEN b.effective_date AND b.expiration_date
      AND b.bill_agr_types_sub_id = c.bill_agr_types_sub_id
      AND c.bill_agr_name_id      = d.bill_agr_name_id
      AND c.language_code         = d.language_code
      AND d.language_code         = 'NO'
    ORDER BY a.channel_code, b.new_priceplan, /*b.org_priceplan, */ b.account_type, b.account_sub_type, b.new_campaign_id
  )
  GROUP BY "SUB_ID", channel_code, new_priceplan, /*org_priceplan, */ account_type, account_sub_type, new_campaign_id, description
  ORDER BY channel_code, new_priceplan, /*org_priceplan, */ account_type, account_sub_type, new_campaign_id

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== List the socs that are allowed for which priceplans for a given channel.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT * FROM (
  SELECT b.new_priceplan, c.soc, c.channel_code, e.description
    FROM ninjarules.bill_agr_typ_channel     a,
         ninjarules.bill_agr_types_sub_types b,
         ninjarules.sub_typ_soc_channel      c,
         ninjarules.socs_soc_descriptions    d,
         ninjarules.soc_descriptions         e
    WHERE a.channel_code          = 'BOL'
      AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
      AND a.bill_agr_types_sub_id = b.bill_agr_types_sub_id
      AND SYSDATE BETWEEN b.effective_date AND b.expiration_date
--      AND b.new_priceplan        IN ('PSVB', 'PSIB')
      AND b.subscription_type_id  = c.subscription_type_id
      AND c.channel_code          = 'BOL'
      AND SYSDATE BETWEEN c.effective_date AND c.expiration_date
      AND NVL(c.channel_mode_for_addition, 'O') != 'N'
      AND c.soc                   = d.soc
      AND d.language_code         = 'NO'
      AND d.soc_name_id           = e.soc_name_id
  )
  GROUP BY new_priceplan, soc, channel_code, description
  ORDER BY new_priceplan, soc

