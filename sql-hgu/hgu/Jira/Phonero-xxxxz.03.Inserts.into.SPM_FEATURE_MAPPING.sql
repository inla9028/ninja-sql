INSERT INTO spm_feature_mapping
SELECT DECODE(a.sp_service_code,
              'SMSPLUSS', 'SMS_PLUSS',
              'VMMINI',   'VOICEMAIL_MINI',
              'VMVS',     'VOICEMAIL',
              a.sp_service_code
       ), a.sp_param_code, a.ninja_parameter_code, a.mandatory_ind, a.ninja_feature_code
  FROM sp_features_mapping a
 WHERE RTRIM(a.sp_service_code) IN ('FAX', 'MMS', 'SMSPLUSS', 'VMMINI', 'VMVS')
ORDER BY 1,2,3
;

COMMIT WORK;

SELECT a.*
  FROM spm_feature_mapping a
;