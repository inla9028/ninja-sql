SELECT a.subscriber_no, a.customer_id, a.sys_creation_date,
       a.sys_update_date, a.operator_id, a.application_id,
       a.dl_service_code, a.dl_update_stamp, a.effective_date,
       a.init_activation_date, a.sub_status, a.sub_status_date,
       a.original_init_date, a.sub_status_last_act,
       a.sub_status_rsn_code, a.product_type, a.customer_ban,
       a.ctn_seq_no, a.req_st_grace_period, a.req_end_grace_period,
       a.commit_start_date, a.commit_end_date, a.commit_reason_code,
       a.commit_orig_no_month, a.susp_rc_rate_type, a.contract_no,
       a.cnt_seq_no, a.dealer_code, a.org_dealer_code, a.sales_agent,
       a.org_sales_agent, a.req_deposit_amt, a.leading_number,
       a.pabx_ind, a.next_ctn, a.next_ctn_chg_date, a.prv_ctn,
       a.prv_ctn_chg_date, a.next_ban, a.next_ban_move_date, a.prv_ban,
       a.prv_ban_move_date, a.sub_sts_issue_date, a.activate_waive_rsn,
       a.earliest_actv_date, a.sub_actv_location, a.cust_watch_lmt,
       a.cust_watch_date, a.basic_watch_lmt, a.credit_watch_pin_cd,
       a.sub_market_code, a.limit_reserved_days, a.ff_expiration_date,
       a.flex_ind, a.duo_ind, a.listed_ind, a.sub_department_cd,
       a.last_subs_disc_dt, a.last_subs_disc_dt_ud,
       a.last_subscr_disc_sn, a.last_subscr_disc_sn_ud, a.pni,
       a.rms_ref_store_id, a.rms_ref_type, a.rms_ref_od, a.dlr_act_fee,
       a.prep_amount, a.subscriber_id, a.sub_lang, a.sms_rcv_style_code,
       a.conv_run_no, a.allow_advertising_ind, a.ivr_wrong_access_no,
       a.threshold_amt, a.publish_level, a.auto_release_ind,
       a.cust_watch_eff_date, a.cust_watch_exp_date, a.operator_cw_lmt,
       a.send_sms_for_match, a.cps_status, a.cps_transaction,
       a.cps_type, a.isp_pass, a.isp_type, a.operator_tmp_date,
       a.operator_tmp_lmt
  FROM subscriber a, service_agreement b
  WHERE a.commit_end_date BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + 600
    AND a.customer_id       = b.ban
    AND b.soc               = 'PSFB'
    AND trim(a.sub_status)  = 'A'
