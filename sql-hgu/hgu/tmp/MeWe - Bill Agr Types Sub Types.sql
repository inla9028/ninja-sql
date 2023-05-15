SELECT a.new_priceplan, a.agreement_type, a.account_type, a.account_sub_type, a.org_priceplan, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a
  WHERE a.new_priceplan IN ('PPTR', 'PPTS', 'PPTT', 'PPTU',
                            'PPTV', 'PPTW', 'PPTX', 'PPTY')
--                            , 'PPTC') -- ActiveTalk
    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
    AND a.org_priceplan IN ('PPTR', 'PPTS', 'PPTT', 'PPTU',
                            'PPTV', 'PPTW', 'PPTX', 'PPTY')
  GROUP BY a.new_priceplan, a.agreement_type, a.account_type, a.account_sub_type, a.org_priceplan
  ORDER BY a.new_priceplan, a.agreement_type, a.account_type, a.account_sub_type, a.org_priceplan


----
SELECT a.agreement_type, a.account_type, a.account_sub_type, a.new_priceplan,
       a.new_campaign_id, a.remaining_com_months, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a
  WHERE a.new_priceplan IN ('PPTR', 'PPTS', 'PPTT', 'PPTU',
                            'PPTV', 'PPTW', 'PPTX', 'PPTY')
    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
  GROUP BY a.agreement_type, a.account_type, a.account_sub_type, a.new_priceplan,
           a.new_campaign_id, a.remaining_com_months

--
SELECT a.new_priceplan, a.agreement_type, a.account_type, a.account_sub_type, a.new_campaign_id, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a
  WHERE a.new_priceplan IN ('PPTR', 'PPTS', 'PPTT', 'PPTU',
                            'PPTV', 'PPTW', 'PPTX', 'PPTY')
    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
  GROUP BY a.new_priceplan, a.agreement_type, a.account_type, a.account_sub_type, a.new_campaign_id
  ORDER BY a.new_priceplan, a.agreement_type, a.account_type, a.account_sub_type, a.new_campaign_id


