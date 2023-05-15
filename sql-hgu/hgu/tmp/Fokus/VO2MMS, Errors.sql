SELECT a.ban, a.subscriber_no, a.soc, a.soc_seq_no, a.ftr_soc_ver_no,
       a.service_ftr_seq_no, a.sys_creation_date, a.sys_update_date,
       a.operator_id, a.application_id, a.dl_service_code,
       a.dl_update_stamp, a.campaign_seq, a.campaign,
       a.commit_orig_no_month, a.soc_effective_date, a.customer_id,
       a.feature_code, a.mps_ftr_code, a.service_type, a.soc_level_code,
       a.ftr_effective_date, a.service_ftr_qty, a.ftr_eff_rsn_code,
       a.ftr_expiration_date, a.ftr_exp_rsn_code, a.ftr_special_telno,
       a.ftr_special_tn_date, a.rc_waiver_eff_date,
       a.rc_waiver_expr_date, a.rc_waiver_rsn, a.rc_waiver_opid,
       a.ftr_eff_issue_date, a.ftr_exp_issue_date, a.ftr_trx_id,
       a.ftr_ins_trx_id, a.ftr_prev_seq_no, a.ftr_add_sw_prm,
       a.conv_run_no, a.loan_ver_no, a.loan_seq_no, a.manual_rc_rate,
       a.manual_rc_exp_date
  FROM ntcappo.service_feature a
  WHERE a.subscriber_no = 'GSM04798645091'
    AND a.ftr_expiration_date > SYSDATE
  ORDER BY a.soc
/*
04740492633
04799463745
04798874285
04745458988
04797698878
04793292919
04795700192
04793669960
*/
