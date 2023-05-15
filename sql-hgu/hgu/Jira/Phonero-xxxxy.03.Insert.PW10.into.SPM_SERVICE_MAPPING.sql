INSERT INTO spm_service_mapping VALUES('DATA_GPRS',      'GPRS',  'REGULAR', NULL, NULL, NULL);
INSERT INTO spm_service_mapping VALUES('MMS',            'MMS',   'DUMMY',   NULL, NULL, NULL);
INSERT INTO spm_service_mapping VALUES('VOICEMAIL',      'VOICE', 'VMS',     NULL, NULL, NULL);
INSERT INTO spm_service_mapping VALUES('VOICEMAIL_MINI', 'VOICE', 'VMMINI',  NULL, NULL, NULL);

COMMIT WORK;

SELECT a.*
  FROM spm_service_mapping a
;

