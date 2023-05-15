SELECT a.account_type, a.account_sub_type, a.agreement_type, a.new_priceplan, b.description, COUNT(*) AS "COUNT"
  FROM bill_agr_types_sub_types a, socs_descriptions b
  WHERE a.account_type     = 'S'
    AND a.account_sub_type = 'C2'
    AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
    AND a.new_priceplan = b.soc
    AND b.language_code = 'NO'
  GROUP BY a.account_type, a.account_sub_type, a.agreement_type, a.new_priceplan, b.description
  ORDER BY a.account_type, a.account_sub_type, a.agreement_type, a.new_priceplan, b.description;
