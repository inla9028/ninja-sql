--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Find the rates for Epost Faktura in the PP_OC_RATE table.
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.soc, a.effective_date, a.feature_code, a.no_of_installments,
       a.payment_interval, a.sys_creation_date, a.sys_update_date,
       a.operator_id, a.application_id, a.dl_service_code,
       a.dl_update_stamp, a.rate, a.expiration_date
  FROM pp_oc_rate a
  WHERE a.feature_code LIKE 'FAK%'
    AND a.expiration_date IS NULL

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== Display the Account Type and Subtype that should get billed for Invoices
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT a.account_type, a.account_sub_type, a.print_category,
       a.effective_date, a.sys_creation_date, a.sys_update_date,
       a.operator_id, a.application_id, a.dl_service_code,
       a.dl_update_stamp, a.feature_code, a.expiration_date
  FROM invoice_prt_cat_fee a
  ORDER BY a.account_type, a.account_sub_type

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
--== XXX
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
SELECT  a.account_type, a.account_sub_type, a.print_category, b.rate
  FROM invoice_prt_cat_fee a, pp_oc_rate b
  WHERE b.soc LIKE 'EPOST%'
  ORDER BY a.account_type, a.account_sub_type


--==
SELECT a.account_type, a.account_sub_type, a.print_category, b.rate
  FROM invoice_prt_cat_fee a, pp_oc_rate b
  WHERE a.feature_code = b.feature_code
--    AND b.soc          = 'DEFSOC'
    AND b.expiration_date IS NULL
  ORDER BY a.account_type, a.account_sub_type

