SELECT * FROM soc_loan a
  WHERE a.soc IN ('LEAS1', 'LEAS2')
  
--
SELECT a.soc, a.full_rate, a.first_install_rate, a.other_install_rate,
       a.no_of_installments
       , a.first_install_rate + (a.other_install_rate * (a.no_of_installments - 1)) AS "MY_FULL_RATE"
  FROM soc_loan a
  WHERE a.soc IN ('LEAS1', 'LEAS2')
