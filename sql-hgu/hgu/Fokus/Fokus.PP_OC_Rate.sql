SELECT a.soc, a.effective_date, a.feature_code, a.no_of_installments,
       a.payment_interval, a.sys_creation_date, a.sys_update_date,
       a.operator_id, a.application_id, a.dl_service_code,
       a.dl_update_stamp, a.rate, a.expiration_date
  FROM ntcrefwork.pp_oc_rate a
  WHERE a.soc like 'PSDP%'
