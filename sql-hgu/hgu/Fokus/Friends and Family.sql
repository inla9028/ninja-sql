SELECT a.subscriber_no, a.ban, a.effective_date, a.personal_tel,
       a.personal_tel_to, a.plan_code, a.sys_creation_date,
       a.sys_update_date, a.operator_id, a.application_id,
       a.dl_service_code, a.dl_update_stamp, a.discount_type,
       a.start_hour, a.duration, a.expiration_date, a.conv_run_no,
       a.ff_soc
  FROM ntcappo.friends_and_family a
  WHERE (a.subscriber_no IN ('GSM04793096910', 'GSM04792653600')
      OR a.personal_tel  IN (   '04793096910',    '04792653600'))
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1);
    
SELECT a.subscriber_no, a.ban, a.effective_date, a.personal_tel,
       a.personal_tel_to, a.plan_code, a.sys_creation_date,
       a.sys_update_date, a.operator_id, a.application_id,
       a.dl_service_code, a.dl_update_stamp, a.discount_type,
       a.start_hour, a.duration, a.expiration_date, a.conv_run_no,
       a.ff_soc
  FROM ntcappo.friends_and_family a
  WHERE (a.subscriber_no IN ('GSM04795174240')
      OR a.personal_tel  IN (   '04795174240'))
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1);
    
SELECT a.subscriber_no, a.ban, a.effective_date, a.personal_tel,
       a.personal_tel_to, a.plan_code, a.sys_creation_date,
       a.sys_update_date, a.operator_id, a.application_id,
       a.dl_service_code, a.dl_update_stamp, a.discount_type,
       a.start_hour, a.duration, a.expiration_date, a.conv_run_no,
       a.ff_soc
  FROM ntcappo.friends_and_family a
  WHERE a.ban = 292625605
    AND SYSDATE BETWEEN a.effective_date AND NVL(a.expiration_date, SYSDATE + 1);

/*
**
** Selecting a FnF for a SUBSCRIBER_NO, will give you a list of subscribers.
** The column PLAN_CODE is mapped via FR_FM_PLAN.FR_FM_PLAN_CD and
** shows FR_FM_PLAN.FR_FM_PLAN_DESC in the CSM GUI.
**
*/