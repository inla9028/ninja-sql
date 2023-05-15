--==
--== List the account- & sub types available for a given priceplan.
--==
SELECT a.agreement_type, a.ban_tree_ind, a.account_type, a.account_sub_type,
       a.new_priceplan, b.description, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a, priceplan_campaign_descr b
  WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
    AND a.account_type     = 'I'
    AND a.account_sub_type = 'R'
    AND a.new_priceplan    = b.priceplan
    AND a.new_campaign_id  = b.campaign_id
    AND a.new_priceplan    = 'PSCL'
    AND b.language_code    = 'NO'
  GROUP BY a.agreement_type, a.ban_tree_ind, a.account_type, a.account_sub_type, a.new_priceplan, b.description
  ORDER BY a.agreement_type, a.ban_tree_ind, a.account_type, a.account_sub_type, a.new_priceplan, b.description;

--==
--== List the account- & sub types and changes available for a given priceplan.
--==
SELECT a.agreement_type, a.ban_tree_ind, a.account_type, a.account_sub_type,
       a.org_priceplan, a.new_priceplan, b.description, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a, priceplan_campaign_descr b
  WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
--    AND a.account_type     = 'I'
--    AND a.account_sub_type = 'R'
    AND a.org_priceplan    = 'PSDN'
    AND a.new_priceplan    = b.priceplan
    AND a.new_campaign_id  = b.campaign_id
    AND a.new_priceplan    = 'PPUJ'
    AND b.language_code    = 'NO'
  GROUP BY a.agreement_type, a.ban_tree_ind, a.account_type, a.account_sub_type, a.org_priceplan, a.new_priceplan, b.description
  ORDER BY a.agreement_type, a.ban_tree_ind, a.account_type, a.account_sub_type, a.org_priceplan, a.new_priceplan, b.description;

--==
--== List the account- & sub types available for a given priceplan.
--==
SELECT a.agreement_type, a.ban_tree_ind, a.account_type, a.account_sub_type,
       a.new_priceplan, b.description, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a, priceplan_campaign_descr b
  WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
--    AND a.account_type     = 'I'
--    AND a.account_sub_type = 'R'
--    AND a.org_priceplan    = 'PKOF'
    AND a.new_priceplan    = b.priceplan
    AND a.new_campaign_id  = b.campaign_id
    AND a.new_priceplan    = 'PPUJ'
    AND b.language_code    = 'NO'
  GROUP BY a.agreement_type, a.ban_tree_ind, a.account_type, a.account_sub_type, a.new_priceplan, b.description
  ORDER BY a.agreement_type, a.ban_tree_ind, a.account_type, a.account_sub_type, a.new_priceplan, b.description;


--==
--== List the changes available for a given priceplan, including campaign.
--==
SELECT a.org_priceplan, a.new_priceplan, b.description, a.new_campaign_id, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a, priceplan_campaign_descr b
  WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
--    AND a.account_type     = 'I'
--    AND a.account_sub_type = 'R'
--    AND a.org_priceplan    = 'PKOF'
    AND a.new_priceplan    = b.priceplan
    AND a.new_campaign_id  = b.campaign_id
    AND a.new_priceplan    = 'PSVB'
    AND b.language_code    = 'NO'
  GROUP BY a.org_priceplan, a.new_priceplan, b.description, a.new_campaign_id
  ORDER BY a.org_priceplan, a.new_priceplan, b.description, a.new_campaign_id;

--==
--== List the available campaigns for a priceplan.
--==
SELECT a.new_campaign_id, b.description, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a, priceplan_campaign_descr b
  WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
    AND a.new_campaign_id  = b.campaign_id(+)
    AND a.new_priceplan    = b.priceplan(+)
    AND b.language_code    = 'NO'
    AND a.new_priceplan    = 'PSBA'
  GROUP BY a.new_campaign_id, b.description
  ORDER BY a.new_campaign_id, b.description;

--==
--== List the priceplans from which it's allowed to change to ....
--==
SELECT a.org_priceplan, b.description, a.new_priceplan, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a, socs_descriptions b
  WHERE SYSDATE BETWEEN a.effective_date AND a.expiration_date
    AND a.new_priceplan    = 'PPTZ'
    AND a.org_priceplan    = b.soc
    AND b.language_code    = 'EN'
  GROUP BY a.org_priceplan, b.description, a.new_priceplan
  ORDER BY a.org_priceplan, b.description, a.new_priceplan;


