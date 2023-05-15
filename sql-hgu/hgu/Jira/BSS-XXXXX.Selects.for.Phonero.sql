SELECT a.*
  FROM socs a
 WHERE a.soc = 'PW10'
;

SELECT a.*
  FROM socs_descriptions a
 WHERE a.soc = 'PW10'
;

SELECT a.*
  FROM sub_typ_soc_channel a
 WHERE a.channel_code         = 'Phonero'
;

SELECT a.*
  FROM subscription_types a
 WHERE a.subscription_type_id = 'PW10' || 'REG1'
;

SELECT a.*
  FROM subscription_types_socs a
 WHERE a.subscription_type_id = 'PW10' || 'REG1'
--   AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

SELECT a.*
  FROM sub_typ_soc_channel a
 WHERE a.subscription_type_id = 'PW10' || 'REG1'
--   AND SYSDATE BETWEEN a.effective_date AND a.expiration_date
;

SELECT a.*
  FROM allowable_upgrades a
 WHERE a.new_priceplan = 'PW10'
ORDER BY 1,2
;

SELECT a.*
  FROM account_type_sub_type a
 WHERE a.account_type     = 'S'
   AND a.account_sub_type = 'PO'
;

SELECT a.*
  FROM billing_agreement_types a
 WHERE a.account_type     = 'S'
   AND a.account_sub_type = 'PO'
   AND SYSDATE BETWEEN a.effective_date AND a.expiry_date
;


SELECT a.*
  FROM priceplans a
 WHERE a.priceplan_code = 'PW10'
   AND SYSDATE BETWEEN a.sales_effective_date AND a.sales_expiry_date
;

SELECT a.*
  FROM feature_parameters a
 WHERE a.soc = 'PW10'
;

SELECT a.*
  FROM socs_features a
 WHERE a.soc = 'PW10'
;

SELECT a.*
  FROM rating_account_types a
 WHERE a.priceplan_code = 'PW10'
--   AND SYSDATE BETWEEN a.effective_date AND a.expiry_date
;

SELECT a.*
  FROM dealers a
 WHERE a.dealer_code = 'PO01'
;


