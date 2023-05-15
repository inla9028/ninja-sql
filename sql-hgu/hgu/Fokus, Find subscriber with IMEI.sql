SELECT a.customer_id, a.subscriber_no, a.equipment_no, a.phd_seq_no,
       a.sys_creation_date, a.sys_update_date, a.operator_id,
       a.application_id, a.dl_service_code, a.dl_update_stamp,
       a.init_activation_date, a.equipment_level, a.expiration_date,
       a.imsi, a.ownership_code, a.ban, a.effective_date,
       a.sw_state_ind, a.last_sw_actv_date, a.next_actv_code,
       a.next_actv_date, a.next_actv_issue_dt, a.device_type,
       a.primary_subscriber, a.conv_run_no, a.dealer_code
  FROM ntcappo.physical_device a
  WHERE a.device_type  = 'H'
    AND a.equipment_no = '359382005973374'
