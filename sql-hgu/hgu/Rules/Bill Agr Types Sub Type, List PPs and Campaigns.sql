--== List the available priceplans and campaigns for the specified location
/*
{Agreement Type: [R]| Ban Tree Indicator: [N]| Account Type: [O]|
 Account Sub Type: [R]| New Price Plan: [PPOJ]| New Campaign Code: [000000000]}
*/
SELECT a.new_priceplan, a.new_campaign_id, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a
  WHERE a.agreement_type   = 'REGULAR' --'COOP'
--    AND a.ban_tree_ind     = 'N'
--    AND a.account_type     = 'I'
--    AND a.account_sub_type = 'FB'
--    AND a.org_priceplan    = 'PPTC'
    AND a.new_priceplan    = 'PSFB'
  GROUP BY a.new_priceplan, a.new_campaign_id

--== List all available rating changes for the specified transition
SELECT a.org_priceplan, a.new_priceplan, a.new_campaign_id, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a
  WHERE /*a.agreement_type   = 'COOP'
    AND a.ban_tree_ind     = 'N'
    AND a.account_type     = 'I'
    AND a.account_sub_type = 'FB'
    AND a.org_priceplan    = 'PKOF'
    AND */a.new_priceplan    = 'PSFB'
  GROUP BY a.org_priceplan, a.new_priceplan, a.new_campaign_id
  ORDER BY a.org_priceplan, a.new_priceplan, a.new_campaign_id;




