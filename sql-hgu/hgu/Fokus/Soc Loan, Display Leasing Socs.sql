/*
** Display the relevant info regarding a Leasing soc.
*/
SELECT   a.soc, a.effective_date, a.expiration_date, a.full_rate,
         a.first_install_rate, a.no_of_installments, a.grace_period
    FROM soc_loan@prod a
   WHERE RTRIM (a.soc) IN ('LEASUD')
ORDER BY a.effective_date, a.expiration_date
;

/*
** List the "interesting" columns of SOC_LOAN table.
*/
select   rtrim(a.soc) as "SOC", a.full_rate, a.first_install_rate,
         a.other_install_rate, a.no_of_installments, a.grace_period
    from soc_loan a
   where sysdate between a.effective_date and nvl(a.expiration_date, sysdate + 1)
order by "SOC"
;

/*
** Display all info regarding a Leasing soc.
*/
SELECT   a.soc, a.effective_date, a.sys_creation_date, a.sys_update_date,
         a.operator_id, a.application_id, a.dl_service_code,
         a.dl_update_stamp, a.loan_ver_no, a.full_rate, a.full_rt_tax_categ,
         a.full_rt_inc_tax, a.first_install_rate, a.other_install_rate,
         a.handling_fee, a.hndl_fee_policy, a.handling_feature,
         a.installment_feature, a.full_pmnt_feature, a.crdt_feature,
         a.no_of_installments, a.grace_period, a.expiration_date,
         a.penalty_policy, a.term_penalty_ftr
    FROM soc_loan@prod a
   WHERE RTRIM (a.soc) IN ('LEASUD')
ORDER BY a.effective_date, a.expiration_date;
